# Use this kit with your coding agent

You don’t install a WordPress add-on. You **open this folder**. That’s the whole trick.

```bash
git clone https://github.com/AmanSarraf/wordpress-agency-kit.git
cd wordpress-agency-kit
./bin/wp-agency doctor
```

Then start the agent **inside this directory**.

## Codex CLI

```bash
cd wordpress-agency-kit
codex
```

Try:

> Read AGENTS.md. Run doctor. Create a client called demo from empty.

## Claude Code

```bash
cd wordpress-agency-kit
claude
```

Skills in `skills/` load automatically.

## Grok

Open `wordpress-agency-kit` as the workspace. Optional: add `skills/` to your Grok skills paths.

## Cursor

**File → Open Folder** → `wordpress-agency-kit`. Chat as usual.

## Copilot / OpenCode / others

Open the same folder. They should pick up `AGENTS.md`.

---

If the agent asks where client sites go: default is `../client-projects/` next to the kit.
