# devbox

My local development environment:

```
docker pull alexgenco/devbox

# Start a tmux session ("ctrl-a d" to detach)
docker run --name devbox --detach-keys 'ctrl-a,d' -it alexgenco/devbox

# Rejoin a detached session
docker attach --detach-keys 'ctrl-a,d' devbox
```
