  - [Quick Guide](#quick-guide)
  - [How to use this document](#how-to-use-this-document)
  - [Clearing up some myths](#clearing-up-some-myths)
  - [Git as a collaboration tool](#git-as-a-collaboration-tool)
- [Prerequisites](#prerequisites)
- [Commands cheat sheet section](#commands-cheat-sheet-section)
  - [The "in-between" commands](#the-in-between-commands)
  - [Saving state commands](#saving-state-commands)
  - [Changing history commands - Basic](#changing-history-commands---basic)
  - [Jumping to "points in time"](#jumping-to-points-in-time)
  - [Starting a Git repo](#starting-a-git-repo)
  - [Putting things aside](#putting-things-aside)
  - [Deleting files](#deleting-files)
  - [Removing uncommited changes](#removing-uncommited-changes)
  - [Getting back stuff](#getting-back-stuff)
  - [Working with Git servers](#working-with-git-servers)
- [Best practice and theory section](#best-practice-and-theory-section)
  - [What should be in a commit?](#what-should-be-in-a-commit)
  - [What should be in a commit message?](#what-should-be-in-a-commit-message)
  - [The importance of `.gitignore`](#the-importance-of-gitignore)
  - [Removing instead of commenting out lines](#removing-instead-of-commenting-out-lines)
  - [Branches](#branches)
- [Example use-cases](#example-use-cases)
  - [Example use-case 1 - Static Website](#example-use-case-1---static-website)
  - [Example use-case 2 - React app from scratch](#example-use-case-2---react-app-from-scratch)
- [Appendix](#appendix)
  - [UNIX-like command line tools and shells](#unix-like-command-line-tools-and-shells)
  - [git-bash, bash and zsh](#git-bash-bash-and-zsh)
  - [Configuring your shell](#configuring-your-shell)
    - [Configuring git-bash during its setup](#configuring-git-bash-during-its-setup)
  - [Recommendations on terminal programs](#recommendations-on-terminal-programs)
    - [Windows](#windows)
    - [macOS](#macos)
    - [Linux](#linux)
  - [VIM editor life jacket](#vim-editor-life-jacket)
  - [Version managers and virtual environments](#version-managers-and-virtual-environments)
    - [NVM](#nvm)
    - [pyenv](#pyenv)

# Introduction
This is a **cheat sheet** and my personal **best practice collection** aimed at ongoing developers, DevOps engineers, sysadmins and other people interested in getting started using [Git](https://git-scm.com/). After roughly 10 years of using it myself and often having successfully introduced its sometimes complex paradigms to both former sysadmin colleagues and novice developers, I thought it's time for a write-up accompanying my teaching.


This document lists commands (including `--options`) I find most helpful. At the very end of the documents there is an [examples section](#example-use-cases) that puts some of them to use in real-life scenarios.


## Quick Guide
If you have a rough idea of how Git works already, I recommend reading these chapters to get you going quickly:

- The introductory chapters [Intro](#introduction), [How to use... ](#how-to-use-this-document), [Myths](#clearing-up-some-myths) and [Git as a collaboration tool](#git-as-a-collaboration-tool).
- Then dive directly into [The examples section](#example-use-cases).

Use the rest of the chapters as a reference and cheat sheet only!

Following that, I recommend proceeding to the [Best practice and theory section](#best-practice-and-theory-section).

## How to use this document
Don't feel overwhelmed by the amount of commands in this document, as often I'm presenting several possible ways of achieving the same. Pick and remember those you feel the most comfortable with.

Use these listings as a cheat sheet only. Type the commands into your terminal each time, rather than copying/pasting, and you will soon have learned them by heart.

There is dozen's of Git how-tos out there, Git is super-powerful, nobody knows everything about it. This document tries to be practical and give some workflow ideas already without getting into too much detail on all the possibilities.

**Make using Git a habit!** Creating habits for most humans at first feels like a burden but once it is established each execution feels like an achievement.

I promise Git will be a life-safer, your second brain and a tremendous help even for the tiniest of projects.


## Clearing up some myths

Git is **offline first**! Despite of common misbelieve, Git does not require any server part!

Git is not simply an upload tool for GitHub, Gitlab, Gitea or any other public or private Git backend system. It can certainly be used for for that but it's not its main purpose.

Git is a "versioning" or "version control" tool. That does not literally mean it's ment to create "release versions" of a program. It can certainly help with that but it's not its sole purpose. A more descriptive name for tools like Git is "revision control". If desired read the wikipedia entry about [version control](https://en.wikipedia.org/wiki/Version_control).

Git not only helps to save your code, it is a documentation tool as well. Whenever you go back to a previous project to look up something "you know you must have done" but don't recall the details, you'll be happy to find a description in your own words as well as an isolated version of "the changes required" to achieve it. Looking up things in horribly huge programs will be a thing of the past!

No coding project is too small to be put into a Git repo!


## Git as a collaboration tool
_The main goal of this document is to give a starting point for **personal  coding projects**._

_When working in **teams** though, it's all about **common team rules**. Some of the things in this document might be opinionated but I strongly believe that every developer/team member should at least know these basics, to successfully collaborate._


# Prerequisites
- A working Git installation on Windows, macOs or Linux.
- A basic understanding of UNIX-like command line tools.
- A basic understanding of what a shell is, which one you are using and how you configure the editor being used for text editing.

Check out the [appendix chapters](#appendix) if you're not savvy with any of the above.


# Commands cheat sheet section
## The "in-between" commands
or  **The "staying informed" commands** or simply **The "looking around" commands**

You use them all the time: Before _committing_, after _commiting_, whenever you get back to work, when you are not sure about the state of your repo, ...

_**As a rule of thumb, before you do anything with Git, use them!**_

_**They all are read-only and can be issued safely any time.**_

|  |  |
| ---------------------- | - |
| `git status`        | Displays files with _uncommited_ changes, _untracked_ files and gives hints in what state Git is in general. **Your most important git command!** |
| `git log`           | The history. Displays the list of commits including all the details. |
| `git log --oneline` | A brief variant of the history. |
| `git show <hash>`   | Displays the _diff_(erence) of one commit to its previous one. In short, **it displays a commit** referenced by its commit-hash. Omit `<hash>` to see the last commit (the top-most in the history) |
| `git diff`          | Show the _diff_ between _uncommited_ changes and the last commit (the top-most in the history). |
| `git diff <hash1> <hash2>` | Show the _diff_ between the two commits |

_Hint: The Commit-hashes you see in `git log` are pretty longish, but they can be abbreviated to a certain amount. If you look at `git log --oneline` you see about the maximum a hash can be abbreviated. Just try it out by looking at `git log` and then marking and copying only a part of the hash you see, starting from the left. Use that hash in another command, for example `git show abcdef123456`. It should work!_


## Saving state commands
Coming to Git's main purpose: Tracking changes in files. The "chunks" we save those changes in, Git calls commits.

_My personal rule of thumb and number 1 recommendation to any Git-non-experts: **Never** commit without double checking **what** will be committed with `git diff` and `git status`. Make it a habit!_

|  |   |
|------------------------- | - |
| `git add <filename>`       | Hand over a file into Git's control. It will be added with the _next_ commit. We call this "staging for a commit" |
| `git add .`               | Hand over **all files** in the directory into Git's control. It will be added with the _next_ commit. |
| `git commit`              | Finally record all staged changes into a new commit. You'll be prompted to write a description - **_The Commit Message_**. |
| `git commit -m "Sentence"`           | Finally record all staged changes into a new commit. You pass the description on the command line already. |
| `git commit -a`           | A combination of "staging" and "commiting": All changes in files known to Git will be staged and commited. You'll be asked for a description. |
| `git commit -a -m "Sentence"`        | The same as above, providing the commit message on the command line already. |
| `git commit -v`           | My personal favorite: Comitting all staged changes. The editor prompting to input the description will **additionally** show **the diff** of your change. This helps to describe your changes right within the editor! |
| `git commit -v -a`        | The same as above but do it for all changes in all files known to Git! |

_Hint: After staging (`git add`ing) something for a commit, `git status` tells you that it's staged (green). If you change a file (again) _after_ that, you have to **stage that file again** (use `git add ` again)! `git status` will tell you that, so always use it before finally _committing_!_

_Hint: Commit often! Don't make the beginners mistake of finishing the program, then doing one commit, just so you can upload it to GitHub!_


## Changing history commands - Basic
If a commit is done it can still be changed, you can "amend" to it. The order of commits can also be changed (but that's not demonstrated here).

_Note (generalizing): Changing history is perfectly fine in personal projects but needs to be thought through carefully when working in teams. Don't worry about it for now and use below commands often to fix/improve your existing commits_

|  |   |
|--------------------- | - |
| `git commit --amend`        | Add all staged changes to the last commit (and be prompted for commit message changes). If no staged changes are present, this simply is **the command to correct your commit message!** |
| `git commit -a --amend`     | Add **all changes in all files** to last commit |
| `git commit -a -v --amend`  | My personal favorite: Add **all changes in all files** to last commit, adapt **commit message**, while additionally **showing the _diff_** of all those changes within the commit message editor. _This is an immensive help when writing commit messages!_ |


## Jumping to "points in time"
To change the current state of a repo you can jump to any commit referencing it by its _commit-hash_. A commit can also have a "human readable" name, that is called a _branch_. The default branch Git creates for you is called `main` (or `master` in older Git versions).

|  |   |
| --------------------- | - |
| `git checkout <hash>` | Set the repo to the state of that commit |
| `git checkout main`          | Set the repo back to the state of the branch named `main` (essentially this **usually** is the command to return to the most recent commit.) |


## Starting a Git repo
Any directory, no matter if entirely empty or populated with files already can be translated into a Git repo.

|  |   |
| ------------ | - |
| `git init`   | Initialize the current directory as a Git repo (essentially creating a hidden subdirectory called `.git`) |

_Hint: Typical steps after `git init` are creating and committing a `.gitignore` file, and adding and committing all files you might already have (`git add .; git commit`)_


## Putting things aside
Sometimes you'd want to "move aside" your current, uncommited changes (without commiting them) to do something else with git that requires it.

|   |   |
| --------------- | - |
| `git stash`     | Move aside all unstaged changes onto the _stash stack_ |
| `git stash pop` | Get back the top-most entry from the _stash stack_ |

_Hint: One use-case of `stash` is whenever you forgot something in your last commit and had started to work *on the next thing* already (i.e. changed code already): `git stash` all those changes. Fix what you forgot and `git commit -a --amend`  to your previous commit. Get back your changes with `git stash pop` and move on._


## Deleting files

|   |   |
| ----------------- | - |
| `git rm <filename>` | Delete a file and **additionally** stage that change for the next commit |

_Hint: Deleting with regular operating system methods (File browser, `rm` command) is certainly also possible. You'd have to stage that change with `git add <filename>` in that case. `git rm`. spares you that step_

_Hint: Keeping deletions in separate commits, makes it easy to restore those files later on._


## Removing uncommited changes
Sometimes you experimented with something which doesn't work anyway, want to get rid of it and start from a "known good" state.

|   |   |
| ----------------- | - |
| `git reset --hard HEAD` | Delete all uncommited changes and reset the repo the state of the previous/the top-most commit. `HEAD` references the _top-most commit_! |

_Hint: Instead of `HEAD` any commit-hash or branch-name can be used to set back the repo to exactly that state!_


## Getting back stuff
Any change you ever recorded with Git can be restored, even entire file deletions!

Lookup the change you want to retrieve with `git log` (read your commit messages) and display the details (the actual changes) of a commit with `git show <commit-hash>`. If you found what you were looking for, use below's checkout command to get that file's change back.

|   |   |
| --------------- | - |
| `git checkout <commit-hash> <filename>`| Get back the state of the file as it was in the specified commit. You will get it as _staged_ changes already. Use `git status` and `git diff --staged` to see them. |

_Hint: Usually if you find the commit that _removed_ something (a line or even an entire file), you would want to `checkout` from the commit **before** that, because it **still has** that required data present (Your recorded **the deletion** back then, thus want to restore from the state right before that operation!)_




## Working with Git servers
A local Git repo can be connected to another Git repo hosted on a server. Git calls those adresses _remotes_. A Git repo can be connected to **one or multiple** _remotes_.

|   |   |
| --------------- | - |
| `git remote -v` | Display all remotes |
| `git remote add myrepo https://github.com/username/reponame.git` | Connects the local Git repo to the remote repo hosted on GitHub and naming the remote  `myrepo` |

When a repo is existing on a server already, it can be _cloned_, which creates a local copy of that repo into a subdirectory including a _remote_ entry already.

|  |   |
| --------------- | - |
| `git clone https://github.com/username/reponame.git myrepo` | Clone the repo into the local directory `myrepo`
| `git clone https://github.com/username/reponame.git` | Clone the repo into the local directory `reponame` (automatically picks the remote repo's name for the foldername)

As long as proper remote entries are available, data can be transferred to servers, as well as retrieved from them. Assuming there is only one _remote_ configured, use:

|  |   |
| --------------- | - |
| `git push` | Send to the _remote_ |
| `git pull` | Retrieve from _remote_ |

When collaborating on the same repository, Git needs to handle scenarios where others may have pushed changes to the server while you worked on your offline copy. If you attempt to push your latest commits, Git will prevent it. Instead, you must first pull down those changes, integrate them locally, and then proceed with pushing your changes. The command best suited for this task is:

|  |   |
| --------------- | - |
| `git pull --rebase` | Move local changes aside, retrieve new commits from _remote_, integrate them into local copy, and put your previous local changes on top of it again. Now Git will allow sending your changes with `git push`. |


_Since this document's main focus is not about Git as a collaboration tool, you shouldn't worry too much about this last concept for now. You'll get guidance from your team colleauges in the future._

_Hint: There is one reason though this concept might come in handy for you: If you happen to work on the same Git repo yourself from different computers!_

# Best practice and theory section
## What should be in a commit?
One of the things people struggle most with when starting out with Git is deciding what and when to commit...

- A commit combines changes in the code that make sense together, examples for that are:
    - A bug is fixed
    - A functionality was added / A feature was added
    - A function was refactored
- The reality is, you will make the beginners mistake of throwing too much into a commit! Don't worry about it, you'll learn to judge what belongs together, but be aware of the reasons why smaller commits are preferable:
  - Whenever you look at a commit's change later on, it is always easier to read a "tiny change" in isolation than dozens of changed lines. You get the point!
  - Later on in your career you'll learn to combine several smaller commits into one bigger commit. Start small! Combining to bigger is **easily** possible, **but not the other way round!**


## What should be in a commit message?
Writing good commit messages is on one hand an art form itself and on the other: Something a developing team needs to work out and agree on and if working alone, totally up to you!

I've read dozens of articles about writing commit messages but this one rule is sticking with me ever since and I found it most useful:

- Use the present tense or use the imperative form!
- Don't use the past tense!
- A sentence formed as follows should make sense: **_If this commit is applied, it will "your commit message"_**

So for example, your commit message could be: `Sort entries by date on user accounts page`, thus that sentence wouldn't be perfect english but it would make sense: **_If this commit is applied, it will sort entries by ID on user accounts page._**

- The maximum character length of the first line of a commit message (50 chars) should be respected! (You see it in `git log --oneline`)
- Feel free to elaborate in the rest of the commit message. Better more descriptive than not! Long commit messages don't hurt anyone!

A proper commit message could look like this:

```
Sort entries by ID on user accounts page

- By using the built-in sort method for arrays before passing it
  to the Table component.
- FIXME remember to fix the leading-zero problem later on!
```

I recommend [this article on freecodecamp](https://www.freecodecamp.org/news/how-to-write-better-git-commit-messages/) if you want to further improve your commit message skills.


## The importance of `.gitignore`
Seldomly you'd want each and every file in your project repo to be tracked by Git. It makes sense to generally hide some files from it.

A `.gitignore` file resides in the root of the repo and has a very simple syntax. Each line represents a filename or _part_ of a filename. Attaching `/` ensures matching a directory.

**Keeping `.gitignore` changes in their _own_ commits and not mixing with actual _code_ commits is a good practice.**

Examples for files you _usually_ do not want to be commited **ever** are:

- Configuration files of editors (`.vscode/`)
- Installed packages (`node_modules/`)
- Metadata cache files of operating systems and file browsers (`.DS_Store`, `Thumbs.db`)
- Directories holding final "builds" of your program (`.dist/`, `.build/`)
- Any temporary or cache files and directories (`.cache`, `.tmp`)
- Any other files you keep directly in your repo directory because you like to have them handy (documentation, code templates, CSS templates, ...).

A `.gitignore` file for a JavaScript project could look like this:
```bash
.DS_Store
.vscode/
.cache
node_modules/
build/
dist/
requirements_checklists_for_this_project/
```

_Hint: Some tools/toolchains bring their own `.gitignore` template already, for example projects created with `vite.js`, or `npx create-react-app`. Use those provided `.gitignore` files, commit them separately and add to them if required during the course of your project._

_Hint: GitHub lets you select from a list of `.gitignore` templates when creating a fresh repo._

_Hint: GitHub saves their collection of templates [in a public repo](https://github.com/github/gitignore/blob/main/Node.gitignore). For example [this is their JavaScript/Node template](https://github.com/github/gitignore/blob/main/Node.gitignore), you can copy/paste to your existing project!_


## Removing instead of commenting out lines
Beginning developers tend to comment out a lot of stuff they are not sure about, want to keep it for reference and the likes. That basically is a good thing but there is a better way: Learn to read _diffs_ and how to get those changes back!

So instead of putting a comment mark in front of a line (`#`, `//`, ...), simply delete it. Keeping such a change (the deletion) in a separate commit with a descriptive commit message, allows for easy retrieval later on. Often the purpose of "commenting out" is because of "keeping it for reference".

So for example we deleted a line from a CSS file and recorded that change in a separate commit, we can easily look it up later on with `git show <commit-hash>`:

```diff
commit 27399aedf2c6f4295b80e42ad2970006f9317bde (HEAD -> main)
Author: J0J0 Todos <jojo@peek-a-boo.at>
Date:   Thu Jan 18 11:28:38 2024 +0100

    Delete border-bottom style of .nav-link.active CSS class

diff --git a/styles.css b/styles.css
index 023332d..b8f2c91 100644
--- a/styles.css
+++ b/styles.css
@@ -52,7 +52,6 @@ hr {

 .nav-link.active {
   color: rgba(var(--dark_800), 1);
-  border-bottom: 1px solid;
 }
```

_Hint: Git remembers everything for you! Use this valuable feature!_

_Hint: Looking at diffs might be confusing at first. Get accustomed to it, it is an essential skill for any striving developer._

_Hint: In most default terminal configurations diffs are presented in colors already. A tremendeous help for reading them. If that's not the case, research how to fix your shell's configuration!_


## Branches
Branches mostly come in when working in teams and thus are not a focus in this write-up. A very basic understanding for them would be if you think of a branch as a "human readable name" for a specific commit which additionally allows to stack further commits on top of it.

**For now it is sufficient if you stick with the idea that a branch simply is a "human readable name" for a _commit hash_.**


# Example use-cases
In this chapter you'll find some recipies for real-life scenarios putting to use some of the above commands and concepts.
## Example use-case 1 - Static Website
You have a directory containing a static website project already. You have files named `index.html`, `styles.css`, `scripts.js`. You plan to use some more JavaScript in the project and might install some packages from `npm` soon.

You `cd` into the directory and run `git init`.

To make sure Git never commits some things, you create a file `.gitignore` in the directory containing the following:
```bash
.vscode
node_modules
```

You _add_ and _commit_:
```bash
git add .gitignore
git commit -m "Initial commit, adding .gitignore"
```

You realize that you want to elaborate on your commit message, so you call:
```bash
git commit --amend
```

You extend your commit message to be:
```bash
Initial commit, adding .gitignore

to make sure the vscode config dir and any installed node modules won't ever
be committed to Git.
```

In a second commit you want to add what you already had coded in your html, css and js files. You first inform yourself which files git sees as "untracked files" by issuing `git status`. You see your three files as "untracked" and decide you want to add them all together in one commit:

```bash
git add .
git commit -v
```
You get presented an editor that prompts you for the commit message and additionally displays the contents of your files (-v option), which helps you to find the right words for your message. You describe what you roughly had coded so far:

```bash
Basic structure of the project

The following features are working so far:

- ...
- ...
- ...
```

You save and quit the editor and have a look at your history with `git log`. You see your two commits and think it's enough for the day.

The next day you come back to your project, you decide you want to use the `axios` JavaScript package. You install it with `npm install axios` and then check with `git status` which new files/dirs Git now sees as "untracked". It shows two files named `package.json` and `package-lock.json`. The `node_modules` directory (that `npm` just created) is not being shown since yesterday you made sure it will be ignored already. You commit those two files:

```bash
git add package.json package-lock.json
git commit -m "Add npm package files after installing axios"
```

You make sure with `git status` that there are no "untracked" files and open changes.

You start working on your project's html, js and css files and after some time have a navigation bar working that required changes in all three files. You display the changes with `git diff`, skim quickly through the _diff_ to remind yourself what roughly you had coded and then commit them with:

```bash
git commit -a -v
```

You elaborate in the editor being presented what new features are working.


## Example use-case 2 - React app from scratch
You create a new React app using `npx create-react-app myapp`.

You `cd` into the `myapp` directory and run `git status`. You realize that `create-react-app` already initialized the directory as a git repo. You don't have to issu `git init`.

`git status` also tells you `nothing to commit, working tree clean`, which seems odd but after issuing `git log` you understand what's going on: `create-react-app` already did an initial commit for you. It looks like this:

```bash
commit ff28dc2bb2b0f40d625e790fbdaf7895041232ec (HEAD -> main)
Author: J0J0 Todos <jojo@peek-a-boo.at>
Date:   Thu Jan 18 14:06:47 2024 +0100

    Initialize project using Create React App
```

You type `git show` to view that commit. You skim through the changes quickly, see that `.gitignore` already lists a lot of stuff, so it seems you don't need have to bother about that anymore. You find a default `README.md` provided you would probably want to adapt later on. All the source code of the example app seems to reside below a `src/` directory.

You start by deleting stuff you most probably won't use right now. You'd like to record these deletions in an orderly fashion, to have a way to look up how it was done later on.

You _stage_ the deletion of the logo with `git rm src/logo.svc` as a first step. You check with `git status`.

You remove all code that relates to that log file in the index.js

`git diff` now tells you what exactly you had removed and you check visually if the change looks alright:
```diff
diff --git a/src/App.js b/src/App.js
index 3784575..e914079 100644
--- a/src/App.js
+++ b/src/App.js
@@ -1,11 +1,9 @@
-import logo from './logo.svg';
 import './App.css';

 function App() {
   return (
     <div className="App">
       <header className="App-header">
-        <img src={logo} className="App-logo" alt="logo" />
         <p>
           Edit <code>src/App.js</code> and save to reload.
         </p>
@@ -22,4 +20,4 @@ function App() {
   );
 }
```

You see that the `import logo...` line will be removed and so will the line with the `<img>` tag. You have another look on the real App in the webbrowser and decide that it's fine.

You _stage_ all those changes and _commit_ with:
```bash
git commit -a -m "Remove default logo and all code referencing it"
```

You convince yourself again that your deletions are recorded nicely, so you can look it up if you ever need it later. You issue `git show` and see that now you have everyhing together in one commit: The svg-logo-file deletion as well as the deletions of the relevant code lines (you saw a moment ago when checking with `git diff` prior to committing!)



As a final step you check `git log` and it looks like this:
```bash
commit 61eacfab5213daa3685329976ed5a259a0fc15f4 (HEAD -> main)
Author: J0J0 Todos <jojo@peek-a-boo.at>
Date:   Thu Jan 18 14:45:08 2024 +0100

    Remove default logo and all code referencing it

commit ff28dc2bb2b0f40d625e790fbdaf7895041232ec
Author: J0J0 Todos <jojo@peek-a-boo.at>
Date:   Thu Jan 18 14:06:47 2024 +0100

    Initialize project using Create React App
```

Whenever you would want to look up how that logo of the default App was implemented, you simply would issue `git show 61eacfab52`.

You do some more cleanup commits but decide that cleaning makes tired. It was an important first step but you need a break. You look forward to starting fresh with an already tidied up project repo after your break :-)

# Appendix
Often beginning developers come from a mostly GUI oriented world of computers. These chapters should give the crashiest of crash courses to command line interfaces. 

## UNIX-like command line tools and shells
UNIX-like commands typically follow a pattern with a `command` accepting options, often with long (`--something`) and abbreviated (`-s`) forms. Due to the limited alphabet, shortforms may not be intuitive, but you can find them using `--help` or `-h`.

A _shell_, very simply put, is a program that accepts interactive command inputs from a user. Two common ones are named `bash` and `zsh`. 

A _shell_ on a graphical operating system requires a _Terminal Emulator Program_ to be run!

So to be exact, a _shell_ is not a _Terminal_. A _Terminal_ just runs a _shell_ as the very first thing when launched.

## git-bash, bash and zsh
`git` is a UNIX-like command. I _suppose_ because of its UNIX-like nature, things like `git-bash` were invented to adapt it for Windows (where command syntax actually follows a different pattern (eg. `/s` for an option instead of `-s`).

`git-bash` is a Windows version of the widely-used `bash` shell known from Linux/BSD/macOS and other *NIX systems. It's not directly related to the functionality of the `git` command itself.

Nowadays macOS and Linux often use `zsh` as the default shell, which in fact is a `bash`-compatible shell.

To find out which shell you are using, do
```bash
echo $SHELL
```
If that points to something like this: `/bin/sh`, and you still are not sure, do
```bash
sh --version
```


## Configuring your shell
To configure your shell, find and edit the `.zshrc` or `.bashrc` file in your _home directory_. **If not existing, simply create it!**

_`git-bash` also uses `.bashrc`._

_The `cd` command without any arguments always sends you "back home". To find out where your homedirectory is located exactly, use `echo $HOME`)_

 Append a line to the config file of your shell, to modify the `EDITOR` environment variable, which **sets the default editor** for CLI tools like `git`. For example on Windows to use notepad:


```bash
export EDITOR="notepad"
```

Restart the shell for changes to take effect (use the `exit` command). Verify the new setting with `echo $EDITOR`.

_It helps to choose an editor that supports syntax highlighting, since Git can display source code within the editor while writing commit-messages. So on Windows you could use `notepad++` if you have it installed, or `nano`, which ships with git-bash, on macOS also try `nano`._

_If for some reason setting `EDITOR` does not work, it could be that Git's own config overrides it._

- _**Check** with `git config --global --get core.editor`_
- _**Set** with `git config --global core.editor notepad`_

### Configuring git-bash during its setup
The git-bash installer asks a ton of questions, those are worth considering:

- _Select Components_ - Activate **"Add a Git Bash Profile to Windows Terminal"**
- _Changing the default editor used by Git_ - Best you leave this at default (vim), because only then you keep the possiblity to control it using the `EDITOR` shell environment variable. If you've had changed it.
- _Configuring the terminal emulator to use with Git Bash_ - Don't set to "Use Windows default console window", keep the default "Use minTTY"!

_Hint: To change settings after you've completed setup already, re-run the git-bash installation fiile._


## Recommendations on terminal programs
### Windows
The git-bash installation, comes with it's own terminal emulater named [minTTY](https://mintty.github.io/).

Microsofts "own" (but developed open-source) [Windows Terminal](https://apps.microsoft.com/detail/9N0DX20HK701?hl=en-US&gl=US) is a good alternative to minTTY.

_Hint: To use `git-bash` as the **default shell when opening a new Windows Terminal** window, go to its Settings dialog -> Startup -> Default Profile, and select "Git Bash"_

_Hint: Copy marked text in Windows Terminal to the clipboard by using the Return key. Paste text into it with a "Right Click"._

### macOS
On macOS I find the default Terminal app lacking. My recommendation is the Open Source alternative [iTerm](https://iterm2.com/). It remembers the state of open terminals when your computer reboots (or even crashes), it supports "split panes" and offers loads of other handy features!

### Linux
For Linux, I personally was using `Terminator` for ages, but nowadays like `Konsole`. Both supporting "split panes". Numerous excellent alternatives exist on any Linux distro.

## VIM editor life jacket
`vim` stands out as a super-powerful text editors that became famous with UNIX admins and programmers because of it's wide spread availability on commercial *NIX systems as well as Linux and macOS. For those new to `vim`, its unconventional interface can be intimidating.

Here are some life saving concepts you need to know to at least write commit messages with it. If you don't want to go down that rabbit hole, just reconfigure your shell to use your favorite editor as shown in the previous chapter.

- `vim` initiates in the _normal_ mode, requiring commands for actions. Copy lines by moving over them and typing `yy`. Paste elsewhere with `p`. (just an example, so you get the idea!)
- To input characters, switch to _insert_ mode using the `i` command.
- While in _insert_ mode, edit as usual.
- Exit _insert_ mode by pressing `Esc` (back to _normal_ mode). There's also an _ex_ mode, accessed with `:`.
- Save the file with `:w`.
- Quit the file with `:q`.
- Save and quit simultaneously with `:wq`.

Many might exclaim, "That is crazy!" Indeed, it might be, but the strength of `vim` lies in its design for complete mouse-less control. Mastering numerous shortcuts enables swift and efficient editing.

Anyway, choose your poison and HTH!

## Version managers and virtual environments
A slightly off-topic chapter around the "dependency hell" new developers _will_ face often. JavaScript programmers want to use _NVM_, Python programmers have several options, I recommend _pyenv_.
### NVM

Allows changing the Node version during a shell session with simple commands. [Read the installation chapter in the official GitHub repo](https://github.com/nvm-sh/nvm).

`nvm` usually is installed directly into the the user's home directory into a hidden directory named `.nvm/`. A main concept of how it works is it's simply writing a few lines to the user's shell configuration (`.bashrc`, `.zshrc`). Details if interested in [this section of its docs](https://github.com/nvm-sh/nvm?tab=readme-ov-file#git-install).

For developing on Windows there's **another project existing**. It's **unrelated** to the original `nvm` project and follows an entirely different approach. [Get nvm-windows here](https://github.com/coreybutler/nvm-windows)

_Hint: There is a caveat with nvm-windows when being used with git-bash: Due to its differnt nature (not configured via shell configuration files) it does not work when git-bash is run via minTTY (The original "Git Bash" entry in Start Menu!). You have to run git-bash via a Windows Terminal profile [as described previously](#windows)._

### pyenv

`pyenv` is my recommendation for creating self-contained virtual Python development environments without touching the "built-in" version of the OS. [Learn what it does](https://github.com/pyenv/pyenv?tab=readme-ov-file#what-pyenv-does) and [follow its excellent installation documentation](https://github.com/pyenv/pyenv?tab=readme-ov-file#installation).