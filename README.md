# Install config onto a new system

Prior to the installation, make sure you have sourced the following function:
```sh
function config {
    /usr/bin/git --git-dir=$HOME/.config.git --work-tree=$HOME "$@"
}
```

Clone your config into a bare repository under `$HOME`:
```sh
git clone --bare git@github.com:simonratner/.config.git
```

Checkout the actual content from the bare repository to your `$HOME`:
```sh
config checkout
config submodule update --init --recursive
```

The step above might fail with a message like:
```
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
Please move or remove them before you can switch branches.
Aborting
```

This is because your `$HOME` folder might already have some stock configuration
files which would be overwritten by Git. The solution is simple: back up the
files if you care about them, remove them if you don't care.

Set the flag showUntrackedFiles to no on this specific (local) repository:
```sh
config config --local status.showUntrackedFiles no
```

See: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
