---
layout: post
title: Multiple Beets Libraries on one machine?
comments: true
published: 2024-11-1
image: /images/2022-5-1-mutliple-beets-libs/beets_logo.png
draft: true
---


This article is directed at advanced users of Beets - the best music library manager out there. If you are a music collector who uses command-line tools but haven't discovered it yet, [start here](https://beets.io). If you already use it and are exploring the configuration possibilities, or if you are a contributing developer, this is for you!

Soon after I started using Beets and contributing to the project, I wanted to manage multiple Beets libraries installed within a single user account on my macOS and Linux machines. The initial goal was to find a way to quickly test new code or config settings and easily and safely switch back to working in my production library. Later on I realized the setup's potential to even separate contentwise.

Currently I run 3 Beets installations:

- **prod** -> my main Beets library
- **dev** -> a development setup I use to play around with new features, test unmerged pull requests, get crazy with the config
- **book** -> a separate library I use for audio books about language training, music education practice tracks and actual audio books. The reason I keep this separate is to prevent mixing up music search results (including smartplaylists) with any non-music content.

## Prerequisites 

This tutorial assumes the following tools installed and set up according to their original documentation:

- [Zsh](https://www.zsh.org)
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh/)
- [pyenv](https://github.com/pyenv/pyenv)
- [The Zsh Agnoster theme](https://github.com/ohmyzsh/ohmyzsh/?tab=readme-ov-file#themes)
- And of course [Beets](https://beets.readthedocs.io)

### Beets should be

- installed from Git
- running within Python virtual environments handled with pyenv (I generally only use one venv for all my setups)

## Beets setup(s)

- configured via subdirectories in `~/.config/`, for example in my case I use
   - `~/.config/beets/config.yaml`  for my **prod** library,
   - `~/.config/devbeets/config.yaml`  for the **dev** one,
   - and `~/.config/bookbeets/config.yaml`  for the **book** library.

All of the described setup happens within the Zsh configuration file, usually `~/.zshrc`


## $BEETSDIR


## Custom Zsh prompt

At all times we'd like to see which Beets library and Python environment is currently active.
Your pyenv initialization lines might be slightly different, but generally look similar to the following:

```
# PYENV initialization and settings
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

It's important that the oh-my-zsh pyenv plugin is loaded _after_ pyenv has been initialized, so let's put this line right below:

```
plugins+=(pyenv)
```

To stick together the parts (called "segments") of the Zsh prompt, the theme uses the function `build_prompt` which is defined in `~/.oh-my-zsh/themes/agnoster.zsh-theme`. The original version looks [like this](https://github.com/ohmyzsh/ohmyzsh/blob/ab3d42a34cd0600b723de0accc248632f2dcf4e3/themes/agnoster.zsh-theme#L257-L269). We simply redefine the function near the end of our `~/.zshrc` while adding a new line to it:

``` sh
# Finally Generate Prompt
build_prompt () {
        RETVAL=$?
        prompt_status
        prompt_beets  # This is what we add
        prompt_virtualenv
        prompt_context
        prompt_dir
        prompt_git
        prompt_bzr
        prompt_hg
        prompt_end
}
```

We define a new `prompt_beets` function right above or below the `build_prompt`, definition. The exact position in your `.zshrc` is not important:

``` sh
# Beets prompt or not
prompt_beets () {
        local beetsdir="$BEETSDIR"
        if [[ "$beetsdir" =~ ".*/beets$" ]]
        then
                prompt_segment 0 1 "prod"
        elif [[ "$beetsdir" =~ ".*devbeets$" ]]
        then
                prompt_segment 0 2 "dev"
        elif [[ -z $beetsdir ]]  && [[ -z "$PYENV_VERSION" ]] && [[ -z "$VIRTUAL_ENV" ]]
        then
                prompt_segment 1 0 "sys-py"
        fi
}
```

Additionally we could change the original format of the virtualenv prompt, which looks like this

FIXME screenshots

```
 (VirtualEnvName) > ~/we/are/here > master >
```

to something like this (remove brackets, white bg, black font color):

FIXME screenshots

We achieve this by overwriting the original prompt_virtualenv() function which is defined in the Agnoster themeFIXME code here: https://github.com/ohmyzsh/ohmyzsh/blob/ab3d42a34cd0600b723de0accc248632f2dcf4e3/themes/agnoster.zsh-theme#L223-L228

to this:

```
# Python VENV Prompt
prompt_virtualenv() {
  if [[ -n "$VIRTUAL_ENV" && -n "$VIRTUAL_ENV_DISABLE_PROMPT" ]]; then
      prompt_segment white black "${VIRTUAL_ENV:t:gs/%/%%}"
  fi
}
```



## Additional Notes

Zsh pyenv plugin documentation

https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pyenv


