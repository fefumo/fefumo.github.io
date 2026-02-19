---
tags:
  - prog
---
- [x] gotta read about jumps [here](#### [7.1.2. Jump by Language Features](https://lazyvim-ambitious-devs.phillips.codes/course/chapter-7/#_jump_by_language_features)) 🔼 🛫 2025-10-01 📅 2025-10-04 ✅ 2025-10-04
crazy book: https://lazyvim-ambitious-devs.phillips.codes
* in `shift + v` : use `o` to switch the directon of selecting
* use `:normal <command>` when selected some lines to use a command on all of them
* use `%` to go to the beginning/end of a function bracket (aim at one of the brackets)
* when in the middle of the word, use `v + i + w` to select the  whole word
* to select something in the quotes INCLUDING the quotes (or another type of surrounding around the word), use `v + a + <surroundings>`
	* or `v + i + <surrounding>` to not include the surroundings themselves
_important:_ it actually works with any type of edit command, so for example, if we want to *change* the entire thing inside of, say parenthesis, then just use `c + i + (` and it does the thing!
> basically you can think about it like this: `command` - any letter `i` - inside `brase` - any brase

its super duper frikin cool when you want to select a huge amount of code inside of brackets. just use `v + i + {` and it’s magic on the screen

* `w` - for selecting a word, we already know, but `W` - for the whole “thing” until *the next whitespace*!

- use `.` to repeat the action that you did with editing something. basic example: use `cw`, write something, then `esc`, go to another line, use `.` and you’ve changed the word to the one you used with `cw`
Ctrl-o / Ctrl-i — back/forward in jumplist (like Back/Forward after jumps).

- `%` — to a matching bracket/tag.
- `* / #` — search for a word under the cursor forward/backward.
- `zz / zt / zb` — center/stick top/bottom.
- `g; / g,` — back/forward in the changelist.

#### jumping
- `[{ / ]}` or `f{ / f}` — to the beginning/end of the current block {…} (convenient in code).
As a shortcut, you can also use `[%` and `]%` where the `%` key is basically a placeholder for “whatever is bracketing me.”

- The `[c`, `]c`, `[f`, `]f`, `[m`, and `]m` keybindings allow you to navigate around a source code file by jumping to the previous or next class/type definition, function definition, or method definition.
If you instead want to jump to the end, just add a Shift keypress: `[C`, `]C`, `[F`, `]F`, `[M`, and `]M` will get you there.

- `h` and `]h` allow you to jump to the next git “hunk” – a section of a file that contains modifications that haven’t been staged or committed yet.