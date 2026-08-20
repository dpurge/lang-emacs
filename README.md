# lang-emacs

This repository contains an Emacs setup for editing structured language-learning Markdown files.

## Overview

The active code in `src/` is split into a thin startup layer and a few feature modules:

- `src/init.el` — minimal user init entrypoint
- `src/dpurge.el` — main Emacs configuration
- `src/dpurge/dpurge-lang.el` — wires Markdown support and keybindings together
- `src/dpurge/dpurge-markdown.el` — block detection, structured field navigation, and field-based IME switching
- `src/dpurge/dpurge-ime-config.el` — language/script → field IME configuration
- `src/dpurge/dpurge-schema-config.el` — transition schemas for structured block types
- `src/dpurge/dpurge-dictionary.el` — simple dictionary buffer and lookup stub

Legacy files moved out of the active codepath are kept under `old/`.

## How startup works

### 1. `src/init.el`

This file is intended to be loaded from your real Emacs init.

It does only two things:

- sets `custom-file` to `~/.emacs.d/dpurge.el`
- loads that file if it exists

So `init.el` is just the bootstrap entrypoint.

### 2. `src/dpurge.el`

This is the main configuration file.

It:

- enables package management and MELPA
- installs and requires `use-package`
- installs and loads `markdown-mode`
- installs and loads `pyim` / `pyim-basedict` when available
- enables UTF-8 defaults
- autoloads `markdown-mode`
- associates `*.md` with `markdown-mode`
- adds `~/.emacs.d/dpurge`, `~/.emacs.d/dpurge/ime`, and `~/.emacs.d/public` to `load-path`
- requires `dpurge-lang`

This is the file that makes the feature code under `src/dpurge/` active.

## Feature modules

### `src/dpurge/dpurge-lang.el`

This is the top-level feature glue.

It requires:

- `markdown-mode`
- `dpurge-dictionary`
- `dpurge-markdown`

Then it binds `C-c d` to `dpurge-vocabulary-lookup` in:

- `dpurge-markdown-edit-mode-map`
- `markdown-mode-map`
- `markdown-ts-mode-map` when available

That means the lookup command is available directly in Markdown buffers, while the command itself still checks whether point is inside a vocabulary block.

### `src/dpurge/dpurge-markdown.el`

This file contains the Markdown block logic, structured field navigation, and field-based IME switching.

#### Buffer-local state

Important buffer-local variables include:

- `dpurge-markdown-block-type`
- `dpurge-markdown-block-lang`
- `dpurge-markdown-block-script`
- `dpurge-markdown-block-as`
- `dpurge-markdown-current-field-state`
- `dpurge-markdown-current-input-method`
- `dpurge-markdown-current-font`
- `dpurge-markdown-current-setup-function`

These describe the current block and the active editing field/IME state.

#### Minor mode

It defines a minor mode:

- `dpurge-markdown-edit-mode`

This mode is enabled when point is inside structured entry blocks such as `vocabulary`, `models`, and `questions`.

#### Block parser

The main parser is:

- `dpurge-markdown-current-block`

It scans backward for lines like:

```text
{start-vocabulary lang=heb script=hebr}
```

and matches them with closing lines like:

```text
{end-vocabulary}
```

If point is inside such a block, it returns a plist such as:

```elisp
(:type vocabulary :lang "heb" :script "hebr" :as nil)
```

For block types that define it, the plist may also include `:as`, for example in `text` and `dialog` blocks.

#### Mode update logic

The function:

- `dpurge-markdown-update-block-mode`

checks the current block and updates the buffer-local state.

Behavior:

- inside structured entry blocks (`vocabulary`, `models`, `questions`, `parallel`, `parallel-dialog`): enable `dpurge-markdown-edit-mode`; in `parallel`/`parallel-dialog` blocks, `TAB` inserts the next `---` field separator and `M-RET` starts a new `===` record; `translation` and `transcription` fields are both forced left-to-right regardless of source script
- inside text-like blocks (`text`, `dialog`): keep block metadata and update IME state from `as=`
- outside special blocks: disable the minor mode and clear local state

#### Hooks

The function:

- `dpurge-markdown-blocks-setup`

adds `dpurge-markdown-update-block-mode` to `post-command-hook` locally and also runs it once immediately.

That setup is installed from both:

- `markdown-mode-hook`
- `markdown-ts-mode-hook`

So the feature works in both classic Markdown mode and tree-sitter Markdown mode.

#### User command

The command:

- `dpurge-vocabulary-lookup`

works like this:

1. verify that `dpurge-markdown-edit-mode` is active
2. parse the current vocabulary entry line
3. extract only the `phrase` field
4. call `dpurge-dictionary-lookup` with the phrase, language, and script

If point is not in a vocabulary block, it raises:

```text
Not inside a vocabulary block
```

### `src/dpurge/dpurge-dictionary.el`

This is a simple dictionary UI stub.

It currently does not call a real external dictionary backend.

Important functions:

- `dpurge-dictionary-open` — opens or reuses a `*Dictionary*` buffer
- `dpurge-dictionary-send` — appends text to that buffer
- `dpurge-dictionary-lookup` — formats a lookup message using the word, language, and script

Right now a lookup produces output like:

```text
Looking up שלום in language=heb script=hebr
```

## Expected Markdown format

The editor currently understands several structured block families.

### Vocabulary

```md
{start-vocabulary lang=heb script=hebr}
שלום {N} [šālōm] = pokój (uwaga)
{end-vocabulary}
```

Field order:

- `phrase`
- `grammar`
- `transcription`
- `translation`
- `notes`

### Models

```md
{start-models lang=cmn script=hans}
越…越… [yuè… yuè…] = im bardziej… tym bardziej…
{end-models}
```

Field order:

- `phrase`
- `transcription`
- `translation`
- `notes`

### Questions

```md
{start-questions lang=cmn script=hans}
为什么 [wèishénme] = 因为 [yīnwèi]
{end-questions}
```

Field order:

- `question`
- `question-transcription`
- `answer`
- `answer-transcription`

### Text and dialog

```md
{start-text as=source lang=cmn script=hans}
你好
{end-text}

{start-dialog as=translation lang=lat script=latn}
@A:
  Witaj.
{end-dialog}
```

`text` and `dialog` do not use structured TAB field-cycling. Their IME behavior is driven by `as=`:

- `source` → phrase IME
- `transcription` → transcription IME
- `translation` → no IME
- `grammar` → no IME

### Parallel

```md
{start-parallel lang=ara script=arab}
مرحبا
---
hello
---
marhaba
===
شكرا
---
thanks
{end-parallel}
```

A record splits on every lone `---` line into up to three fields — **source**,
**translation**, **transcription** (the last two optional). Records are
separated by a lone `===` line. Field-driven behavior:

- `source` → the marker's `lang=`/`script=` IME, font, and text direction
- `translation` → no IME (book language), text direction **forced left-to-right** regardless of the source's own script
- `transcription` → the source language's transcription IME, text direction **forced left-to-right**

`TAB` inserts the next `---` field separator and moves into it; `M-RET` starts a
new record (`===`). A 4th+ `---` field is absorbed into the transcription.

### Parallel Dialog

```md
{start-parallel-dialog lang=ara script=arab}
**Ahmad**: مرحبا
---
**Ahmad**: hello
---
**Ahmad**: marhaba
{end-parallel-dialog}
```

`{start-parallel-dialog}` shares `parallel`'s exact row/field grammar
(`---` field separators, `===` record separators) and editing behavior
(`TAB`, `M-RET`, field-driven IME/direction) — the only difference is that
each field holds a dialog turn or heading instead of plain prose, and
`as=` is not accepted (both columns' languages are already fixed by
field position).

## Typical control flow

When you open a Markdown file:

1. `src/init.el` loads `src/dpurge.el`
2. `src/dpurge.el` requires `dpurge-lang`
3. `dpurge-lang` loads the Markdown, structured editing, and dictionary modules
4. entering `markdown-mode` or `markdown-ts-mode` runs `dpurge-markdown-blocks-setup`
5. moving point updates block detection and field-specific IME state
6. inside a structured block, `TAB` may insert/move between fields depending on the block type
7. inside a vocabulary block, `C-c d` runs `dpurge-vocabulary-lookup`
8. the dictionary buffer opens and shows the lookup request

## Installation assumptions

The current code assumes your live Emacs uses symlinks under `~/.emacs.d/`, especially:

- `~/.emacs.d/init.el`
- `~/.emacs.d/dpurge.el`
- `~/.emacs.d/dpurge/`
- `~/.emacs.d/dpurge/ime/`
- `~/.emacs.d/public/` when present

It also assumes your main startup file loads `~/.emacs.d/init.el`.

For example, `~/.emacs` can contain:

```elisp
(load (expand-file-name "~/.emacs.d/init.el") nil t)
```

The repository also provides cross-platform tasks in `Taskfile.yml`:

- `task install`
- `task uninstall`
- `task doctor`
- `task test`

## Limitations / next steps

Current limitations:

- dictionary lookup is only a stub
- block parsing is regex-based and line-oriented
- some structured editing logic is still duplicated across block types
- `dpurge.el` uses `~/.emacs.d/...` paths directly

Possible improvements:

- connect `dpurge-dictionary-lookup` to a real dictionary package or API
- continue refactoring toward a more generic field-parsing/navigation engine
- make paths repo-relative or package-relative instead of home-directory-specific
- add more ERT tests for real file opening and point motion
