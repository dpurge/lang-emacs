# AGENTS.md

## Purpose
This repo contains an Emacs setup for editing structured language-learning Markdown.

Main active code lives in `src/`.
Legacy / archived files live in `old/` and should not be edited unless explicitly requested.

## Important paths
- `README.md` — human-facing project overview; keep it synchronized with current code and block support
- `src/init.el` — bootstrap init
- `src/dpurge.el` — main Emacs config
- `src/dpurge/dpurge-lang.el` — mode/keybinding glue
- `src/dpurge/dpurge-markdown.el` — block detection, field navigation, IME switching
- `src/dpurge/dpurge-ime-config.el` — language/script → field IME config
- `src/dpurge/dpurge-schema-config.el` — block transition schemas
- `src/dpurge/ime/*.el` — IME implementations
- `test/dpurge/markdown-test.el` — block/navigation tests
- `test/dpurge/ime-test.el` — IME/config tests
- `test/dpurge/test-setup.el` — shared test setup
- `test/run-tests.el` — suite entrypoint
- `Taskfile.yml` — `install`, `uninstall`, `doctor`, `test`

## How to validate
Always run after changes:

```sh
task test
```

This runs:

```sh
emacs --batch -Q -L ./src/dpurge -L ./src/dpurge/ime -l test/run-tests.el -f ert-run-tests-batch-and-exit
```

If you change install logic, also consider:

```sh
task doctor
```

## Architecture notes
Structured Markdown blocks currently supported:
- `vocabulary`
- `models`
- `questions`
- `text` with `as=source|transcription|translation|grammar`
- `dialog` with `as=source|transcription|translation|grammar`

Field/IME behavior is split like this:
- block schema transitions: `src/dpurge/dpurge-schema-config.el`
- language/script IME mapping: `src/dpurge/dpurge-ime-config.el`
- runtime parsing + navigation: `src/dpurge/dpurge-markdown.el`

## Editing rules
- Keep changes small and local.
- Prefer extending config files over hardcoding new language logic in multiple places.
- Do not reintroduce legacy `jdp-` names in active `src/` code unless explicitly asked.
- IME names in active code should use `dpurge-` prefix for custom IMEs.
- When renaming fields or schemas, update both runtime code and tests.

## Current naming conventions
Custom IMEs:
- file names are short, e.g. `heb.el`, `urd.el`, `zho-pinyin.el`
- provided input method names are `dpurge-*`, e.g. `dpurge-heb`

Structured state variables are now markdown-generic, not vocabulary-specific.

## Common pitfalls
- `src/dpurge/dpurge-markdown.el` is sensitive to parenthesis mistakes; run tests immediately after edits.
- `questions` uses field names:
  - `question`
  - `question-transcription`
  - `answer`
  - `answer-transcription`
- `text` and `dialog` blocks do not use tab-cycling, only IME switching by `as=`.
- When block support changes, update `README.md` and `AGENTS.md` together so the docs stay aligned.
- Windows install uses PowerShell symlinks; Unix install uses `ln -sfn`.

## Preferred next-step style
If refactoring, do it incrementally:
1. extract one helper
2. run `task test`
3. extract the next helper

Avoid large parser rewrites in one shot.
