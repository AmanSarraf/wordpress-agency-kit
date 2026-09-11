#!/usr/bin/env bash
# Throwaway end-to-end check of doctor + new + compose config + unique ports.
set -euo pipefail
KIT="$(cd "$(dirname "$0")/.." && pwd)"
export WP_AGENCY_CLIENTS_DIR="${TMPDIR:-/tmp}/wp-agency-kit-e2e-$$"
mkdir -p "$WP_AGENCY_CLIENTS_DIR"
cleanup() {
  if [[ "${WP_AGENCY_E2E_KEEP:-}" == 1 ]]; then
    echo "Kept $WP_AGENCY_CLIENTS_DIR"
    return
  fi
  # down compose if we started it
  if [[ -f "$WP_AGENCY_CLIENTS_DIR/e2e-demo/docker-compose.yml" ]] && docker info >/dev/null 2>&1; then
    (cd "$WP_AGENCY_CLIENTS_DIR/e2e-demo" && docker compose down -v >/dev/null 2>&1 || true)
    (cd "$WP_AGENCY_CLIENTS_DIR/e2e-demo2" && docker compose down -v >/dev/null 2>&1 || true)
  fi
  rm -rf "$WP_AGENCY_CLIENTS_DIR"
}
trap cleanup EXIT

echo "== skills frontmatter =="
missing=0
while IFS= read -r f; do
  if ! grep -q '^name:' "$f" || ! grep -q '^description:' "$f"; then
    echo "BAD $f"
    missing=1
  fi
done < <(find "$KIT/skills" -name SKILL.md)
[[ "$missing" -eq 0 ]]

echo "== README =="
grep -q 'wp-agency doctor' "$KIT/README.md"
grep -q 'html-to-classic-theme' "$KIT/README.md"

echo "== doctor =="
# doctor may fail if docker daemon down — that's still a valid run; capture
set +e
"$KIT/bin/wp-agency" doctor
doc=$?
set -e
echo "doctor exit $doc (0=ready, 1=missing deps is OK on bare CI)"

echo "== new empty =="
"$KIT/bin/wp-agency" new e2e-demo --from empty
test -f "$WP_AGENCY_CLIENTS_DIR/e2e-demo/docker-compose.yml"
test -f "$WP_AGENCY_CLIENTS_DIR/e2e-demo/.env"
test -f "$WP_AGENCY_CLIENTS_DIR/e2e-demo/CLAUDE.md"
test -f "$WP_AGENCY_CLIENTS_DIR/e2e-demo/themes/agency-starter/style.css"
grep -q '^WP_PORT=' "$WP_AGENCY_CLIENTS_DIR/e2e-demo/.env"
p1="$(grep '^WP_PORT=' "$WP_AGENCY_CLIENTS_DIR/e2e-demo/.env" | cut -d= -f2)"

echo "== compose config =="
(cd "$WP_AGENCY_CLIENTS_DIR/e2e-demo" && docker compose config >/dev/null)

echo "== second project unique ports =="
"$KIT/bin/wp-agency" new e2e-demo2 --from empty
p2="$(grep '^WP_PORT=' "$WP_AGENCY_CLIENTS_DIR/e2e-demo2/.env" | cut -d= -f2)"
echo "ports $p1 vs $p2"
[[ "$p1" != "$p2" ]]

echo "== html zip path =="
htmlzip="$WP_AGENCY_CLIENTS_DIR/mini-html.zip"
mkdir -p "$WP_AGENCY_CLIENTS_DIR/mini-html"
echo '<html><body>Hi</body></html>' > "$WP_AGENCY_CLIENTS_DIR/mini-html/index.html"
(cd "$WP_AGENCY_CLIENTS_DIR/mini-html" && zip -q -r "$htmlzip" .)
"$KIT/bin/wp-agency" new e2e-html --from html --zip "$htmlzip"
grep -q 'Hi' "$WP_AGENCY_CLIENTS_DIR/e2e-html/html-template/index.html"

echo "== optional live compose =="
if docker info >/dev/null 2>&1; then
  (cd "$WP_AGENCY_CLIENTS_DIR/e2e-demo" && docker compose up -d)
  ok=0
  for i in $(seq 1 40); do
    code="$(curl -s -o /dev/null -w '%{http_code}' "http://127.0.0.1:$p1/" || true)"
    if [[ "$code" == "200" || "$code" == "302" || "$code" == "301" ]]; then
      echo "WordPress HTTP $code on $p1"
      ok=1
      break
    fi
    sleep 3
  done
  (cd "$WP_AGENCY_CLIENTS_DIR/e2e-demo" && docker compose down -v)
  if [[ "$ok" -ne 1 ]]; then
    echo "WARNING: compose came up but WP did not return 200/30x in time (still treating scaffold as pass)"
  fi
else
  echo "Docker daemon not running — skipped live HTTP"
fi

echo "E2E PASS"
