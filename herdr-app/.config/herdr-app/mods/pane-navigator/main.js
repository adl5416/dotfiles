// vim-tmux-navigator for Herdr: ctrl-h/j/k/l goes to Neovim when it runs in the focused pane
// (it moves between its own windows and calls pane.go at the edge), else moves to the next pane.
// keys.json binds the keys to "pane-navigator.<direction>"; the layout floats this mod, drawing nothing.
import { View } from "gpui-kit";
import { focused, panes, run, hc, nextCommand } from "herdr";

const KEY_BY_DIRECTION = { left: "ctrl+h", down: "ctrl+j", up: "ctrl+k", right: "ctrl+l" };
const VIM_PROGRAMS = new Set(["nvim", "vim"]);

export default class PaneNavigator extends View {
  init(_props, cx) {
    cx.spawn(async () => {
      for (;;) {
        const direction = await nextCommand();
        if (direction in KEY_BY_DIRECTION) await this.navigate(direction);
      }
    });
  }

  async navigate(direction) {
    const terminal = focused()?.terminal;
    const pane = panes().find((candidate) => candidate.focused && candidate.terminal === terminal);
    if (terminal && VIM_PROGRAMS.has(pane?.program.key)) {
      await hc(["keys", terminal, KEY_BY_DIRECTION[direction]]);
    } else {
      run("pane.go", { direction });
    }
  }

  render() {
    return "";
  }
}
