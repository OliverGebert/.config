## tMux CLI commands

| topic | command | comment |
| --- | --- | --- |
| tmux | tmux ls | show sessions |
| tmux | tmux attach | re-attach to existing session |
| tmux | tmux kill-server | kill server to ensure .tmux.conf is loaded |
| tmux | tmuxp load tmsession.yaml | load multiple windows with python tmux loader |

## tMux Windows Navigation

| topic | command  | comment |
| --- | --- | --- |
| tmux | <ctrl>x c | create window |
| tmux | <ctrl>x n | navigate windows |
| tmux | <ctrl>x 1 | goto window 1 |
| tmux | <ctrl>x % | split horizontal |
| tmux | <ctrl>x " | split vertical |
| tmux | <ctrl>x hjkl | move left/down/up/right |
| tmux | <ctrl>x d | detach from tmux session |
| tmux | <ctrl>x s | show running sessions |
| tmux | <ctrl>x r | reload config |
