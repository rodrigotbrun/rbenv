# .rbdev env

This is my dev env settings, that includes my daily basis tools, aliases and
functions.

This is focused on my mac env.

This is always a work in progress!.

## Installing

- Clone this git repo, and run the `bash ./install.sh`. This will take care of
  installing everything I use when starting on a new mac.

- If you already have everything installed, and just need to enable my .rbenv,
  just source it at the end of your .zshrc file with

```
source ~/.rbdev/rbrc.sh
```

## Update env

1. Pull the git repo changes
2. Give exec permissions to the _update.sh_ script if you haven't yet `chown +x
~/.rbenv/update.sh`
3. Run `bash ~/.rbdev/update.sh`

This will run my update scripts, usually only will run the stow symlinks again
(in case anything new appears), otherwise, no need to run this update script.
