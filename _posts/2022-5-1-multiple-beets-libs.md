---
layout: post
title: Multiple Beets libraries on one machine?
comments: true
published: 2024-10-20
image: /images/2022-5-1-multiple-beets-libs/01-th.jpg
draft: false
---

This article is about [Beets  - the best music library manager out there](https://beets.io).

{% include figure.html filename="/images/2022-5-1-multiple-beets-libs/01.jpg" alt_text="the Beets beetroot logo" caption="" width="23%" float="left" margin="4.5px 10px 0 0" img_style="border: 5px solid #303030;" %}

If you are a music collector who uses command-line tools but haven't discovered it yet, [watch its demo video](https://beets.io) and read the [Getting Started Guide](https://beets.readthedocs.io/en/latest/guides/main.html).

Soon after I started contributing to the Beets project, I wanted to manage multiple Beets libraries installed within a single user account on my macOS and Linux machines. The initial goal was to find a way to quickly switch between testing new code or config settings and working in my main library. Later on I realized the setup's potential to also make life more comfortable when splitting different content types to separate libraries.

&nbsp;

<p style="text-align:center; font-style:italic; font-weight:bold;">This is not a beginners guide. It describes an opinionated setup for Beets developers and advanced users.</p>

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
- and of course [Beets](https://beets.readthedocs.io)

Beets is assumed to be installed from Git and Python running within a `pyenv` controlled virtual environment,

and these _Zsh_ related things should be set up:

- _Oh My Zsh_ plugins `git` and `virtualenv` active with their default settings
- [Oh My Zsh pyenv plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pyenv) configured,
- [Zsh Agnoster theme](https://github.com/ohmyzsh/ohmyzsh/?tab=readme-ov-file#themes) in use


## Where to put configuration files?

The [default location for the Beets config.yaml file](https://beets.readthedocs.io/en/latest/reference/config.html#default-location) is `~/.config/beets`. We are following this idea and use subdirectories of `~/.config/` for all of our three libraries:

- `~/.config/beets/config.yaml`  for **prod**,
- `~/.config/devbeets/config.yaml`  for **dev**,
- and `~/.config/bookbeets/config.yaml`  for the **book** library.


## Custom Zsh prompt

**_All of the following setup happens within the Zsh configuration file, usually `~/.zshrc`_**

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

It's important that the _Oh My Zsh_ pyenv plugin is loaded _after_ pyenv has been initialized, so let's put this line right below:

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

So for example if `$BEETSDIR` is set to `~/.config/devbeets` we would get a prompt like this:

{% include figure.html filename="/images/2022-5-1-multiple-beets-libs/02.jpg" alt_text="" caption="" width="75%" %}

As a nice additional feature, which is not only Beets-related, I personally like to have a fallback that tells me that I'm not in any virtual environment and the _system's Python installation_ is active. `1 0` here means an alerting red background and white as the foreground color. We'll find out how that looks like further below. No spoilers now :-P

### Customizing how the virtualenv plugin alters the prompt

Additionally we are changing the original format of the segment generated by the _Oh My Zsh_ `virtualenv` plugin. As we saw in the screenshot above it uses parentheses around the environment name and the same background color as the prompt. We want to remove parentheses and change colors:

{% include figure.html filename="/images/2022-5-1-multiple-beets-libs/04.jpg" alt_text="" caption="" width="75%" %}

We achieve this by overwriting the original `prompt_virtualenv()` function which is defined [here in the original code of the Agnoster theme](https://github.com/ohmyzsh/ohmyzsh/blob/ab3d42a34cd0600b723de0accc248632f2dcf4e3/themes/agnoster.zsh-theme#L223-L228). We can use literal color names too:

```bash
prompt_virtualenv() {
  if [[ -n "$VIRTUAL_ENV" && -n "$VIRTUAL_ENV_DISABLE_PROMPT" ]]; then
      prompt_segment white black "${VIRTUAL_ENV:t:gs/%/%%}"
  fi
}
```

## Shell aliases for switching the active library

We add an alias for each library in our `.zshrc`. If desired at this point we could also activate a specific virtual Python environment simultaneously using the `pyenv activate` command. Another convenience feature I like is to directly jump to Beets source code.

```bash
bdev="export BEETSDIR=~/.config/devbeets; pyenv activate beets311; cd ~/git/beet"
bprod="export BEETSDIR=~/.config/beets; pyenv activate beets310; cd ~/git/beets"
bbook="export BEETSDIR=~/.config/bookbeets; pyenv activate beets311; cd ~/git/beet"
```
We saw the `dev` environment prompt above already - this is what we get if we now switch with `bprod` or `bbook`:

{% include figure.html filename="/images/2022-5-1-multiple-beets-libs/03.jpg" alt_text="" caption="" width="75%" %}
{% include figure.html filename="/images/2022-5-1-multiple-beets-libs/05.jpg" alt_text="" caption="" width="75%" %}

To quit working/using Beets I also define a quit alias - actually I use it to quit _any_ `pyenv` controlled environment and the `b`-prefix is not perfectly appropriate - but who cares?

```bash
bquit="unset BEETSDIR; pyenv deactivate"
```

So since `bquit` deactivates any Python virtual environment we'll fall back to alerting `sys-py` prompt we talked above:

{% include figure.html filename="/images/2022-5-1-multiple-beets-libs/06.jpg" alt_text="" caption="" width="75%" %}

I hope this is of use to fellow Beeters. Please tell me what you think! I'm very interested in your own ideas of handling multiple Beets environments and how this setup could be advanced further!
