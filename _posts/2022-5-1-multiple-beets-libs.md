---
layout: post
title: Multiple Beets Libraries on one machine?
comments: true
published: 2024-11-01
image: /images/2022-5-1-multiple-beets-libs/beets_logo.png
draft: false
---

{% include figure.html filename="/images/2022-5-1-multiple-beets-libs/beets_logo.png" alt_text="the Beets beetroot logo" caption="" width="20%" float="left" margin="4.5px 10px 0 0" img_style="border: 5px solid #303030;" %}

This article is about [Beets  - the best music library manager out there](https://github.com/beetbox/beets/blob/master/README.rst). If you are a music collector who uses command-line tools but haven't discovered it yet, [watch this short demo video](https://beets.io) and read the [Getting Started Guide](https://beets.readthedocs.io/en/stable/guides/main.html).


**This article is not a beginners guide. It describes an opinionated but handy setup for Beets developers and advanced users.**


Soon after I started contributing to the Beets project, I wanted to manage multiple Beets libraries installed within a single user account on my macOS and Linux machines. The initial goal was to find a way to quickly test new code or config settings and comfortably switch back to working in my production library. Later on I realized the setup's potential to even separate contentwise.


## Why more than one?

Currently I run 3 Beets installations:

- **prod** -> my main Beets library
- **dev** -> a development setup I use to play around with new features, test unmerged pull requests, get crazy with the config
- **book** -> a separate library I use for audio books about language training, music education practice tracks and actual audio books. The reason I keep this separate is to prevent mixing up music search results (including smartplaylists) with any non-music content.

## Prerequisites

This tutorial assumes the following tools installed and set up according to their original documentation:

- [Zsh](https://www.zsh.org)
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh/)
- [pyenv](https://github.com/pyenv/pyenv)
- [Zsh pyenv plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pyenv)
- [The Zsh Agnoster theme](https://github.com/ohmyzsh/ohmyzsh/?tab=readme-ov-file#themes)
- And of course [Beets](https://beets.readthedocs.io)

Beets is assumed to be installed from Git and Python running within a `pyenv` controlled virtual environment.

## Where to put configuration files?

The [default location for the Beets config.yaml file](https://beets.readthedocs.io/en/latest/reference/config.html#default-location) is `~/.config/beets`. We are following this idea and use subdirectories of `~/.config/` for all of our three libraries:

- `~/.config/beets/config.yaml`  for **prod**,
- `~/.config/devbeets/config.yaml`  for **dev**,
- and `~/.config/bookbeets/config.yaml`  for the **book** library.


## Custom Zsh prompt

**_All of the described setup happens within the Zsh configuration file, usually `~/.zshrc`_**


### $BEETSDIR

As an alternative to specifiying a Beets config file via the `-c` option the [$BEETSDIR environment variable](https://beets.readthedocs.io/en/latest/reference/config.html#id131) comes in handy.

### pyenv

Your pyenv initialization lines might be slightly different, but generally look similar to this:

```bash
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

It's important that the oh-my-zsh pyenv plugin is loaded _after_ pyenv has been initialized, so let's put this line right below:

```bash
plugins+=(pyenv)
```

### Agnoster theme prompt functions

Ok, so our first goal is to see at all times which Beets library and Python environment is currently active:

To stick together the parts (called "segments") of the Zsh prompt, the Agnoster theme uses the function `build_prompt` which is defined in `~/.oh-my-zsh/themes/agnoster.zsh-theme`. The original version looks [like this](https://github.com/ohmyzsh/ohmyzsh/blob/ab3d42a34cd0600b723de0accc248632f2dcf4e3/themes/agnoster.zsh-theme#L257-L269). We simply redefine the function near the end of our `~/.zshrc` while adding a new line to it:

```bash
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

We also define a new function named `prompt_beets`:

```bash
prompt_beets () {
        local beetsdir="$BEETSDIR"
        if [[ "$beetsdir" =~ ".*/beets$" ]]; then
                prompt_segment 0 1 "prod"
        elif [[ "$beetsdir" =~ ".*/devbeets$" ]]; then
                prompt_segment 0 2 "dev"
        elif [[ "$beetsdir" =~ ".*/bookbeets$" ]]; then
                prompt_segment 0 2 "books"
        elif [[ -z $beetsdir ]]  && \
             [[ -z "$PYENV_VERSION" ]] && \
             [[ -z "$VIRTUAL_ENV" ]]; then
                prompt_segment 1 0 "sys-py"
        fi
}
```
What this does is look up what config file is currently active according to `$BEETSDIR` and return a snippet defining how the prompt segment should look like. Play around with the two digits after `prompt_segment` to set fore- and background colors of the string displayed!

As a nice additional feature, which is not only Beets-related, I personally like to have a fallback that tells me that I'm not in any virtual environment and the _system's Python installation_ is active. `1 0` here means an alerting red background and white as the foreground color.

### Customizing how the pyenv plugin alters the prompt

Additionally we could change the original format of the virtualenv prompt, which looks like this

FIXME screenshots

```bash
 (VirtualEnvName) > ~/we/are/here > master >
```

to something like the following - we remove brackets, and change colors (yes you can use color names here too!):

FIXME screenshots

We achieve this by overwriting the original prompt_virtualenv() function which is defined [here in the original code of the Agnoster theme](https://github.com/ohmyzsh/ohmyzsh/blob/ab3d42a34cd0600b723de0accc248632f2dcf4e3/themes/agnoster.zsh-theme#L223-L228).

to this:

```bash
prompt_virtualenv() {
  if [[ -n "$VIRTUAL_ENV" && -n "$VIRTUAL_ENV_DISABLE_PROMPT" ]]; then
      prompt_segment white black "${VIRTUAL_ENV:t:gs/%/%%}"
  fi
}
```

## Shell aliases for switching the active library

We add an alias for each library in our `.zshrc`. If desired at this point we could also activate a specific virtual Python environment simultaneously using the `pyenv activate` command. Another conveniance feature I like is to directly jump to Beets source code.

```bash
bprod="export BEETSDIR=~/.config/beets; pyenv activate beets310; cd ~/git/beets"
bdev="export BEETSDIR=~/.config/devbeets; pyenv activate beets311; cd ~/git/beet"
bbook="export BEETSDIR=~/.config/bookbeets; pyenv activate beets311; cd ~/git/beet"
```

To quit working/using Beets I also define a quit alias - actually I use it to quit _any_ `pyenv` controlled environment and the `b`-prefix is not perfectly appropriate - but who cares?.

```bash
bquit="unset BEETSDIR; pyenv deactivate"
```

I hope this is of use to fellow Beeters. Please tell me what you think and also I'm very interested in your ideas of handling Beets environments!



