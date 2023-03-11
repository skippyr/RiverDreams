<h1 align="center">⛵ River Dreams 🌊</h1>

<div align="center">
  <img src="https://img.shields.io/github/license/skippyr/river_dreams?style=social"/>
</div>

The ZSH theme that developers have been _river dreaming_ for a long time. It
will finally show how you are the best terminal wizard out there while providing
you useful information about your development environment.


## Preview

![](images/preview/preview_kitty.png)
![](images/preview/preview_xterm.png)

> Default behavior of River Dreams in `kitty` and `xterm` in same environment
> conditions.

## What features does it have?

River Dreams was designed to help people that want to take their terminals to
another level and need to use it for programming and doing maintenance.
Everything that you will probably need will be at your glance even when you
do not have a proper modern terminal.

Everything in it is a module:

| Module | Function |
| ------ | -------- |
| commands_separator  | Shows a separator between commands. |
| local_ip_address    | Shows your local ip address.
| clock               | Shows the current hours and minutes with an icon that changes depending of the hour of the day. |
| disk_usage          | Shows the disk usage percentage of the partition mounted at `/`. |
| python_environment  | Shows the sourced Python environment. |
| tag                 | Shows the latest Git tag. |
| storage_devices     | Shows the quantity of external storage devices connected to the machine including a numeric indicator to show how many are actually mounted. |
| exit_code           | Shows the exit code of commands that throwed an error. |
| root                | Shows a decorator if you are root. |
| vi_mode             | Shows the vi mode if you are using the [`zsh-vi-mode`](https://github.com/jeffreytse/zsh-vi-mode) plugin. |
| directory           | Shows the current directory. It will use an icon if it is a home directory. |
| directory_ownership | Shows a decorator if you are not the owner of the current directory. |
| git                 | Shows branch, status with numeric indicators and last commit hash |
| jobs                | Shows the quantity of jobs running in the background. |
| hidden_files        | Shows the quantity of hidden files. |
| docker_containers   | Shows the quantity of active Docker containers. |
| time_elapsed        | Shows the time elapsed by the last command in minutes and seconds. |

By default, River Dreams will also use fallback text if it detects that your
terminal emulator only supports the 4-bits color palette. This is a measure that
allows you to use all its capabilities even in old terminals, that probably
does not support UTF-8.

But, I know that sometimes this behavior will not work as intended. For those
cases, you can define the environment variable `RIVER_DREAMS_USE_FALLBACK_TEXT`:
if its value is `true`, it will use fallback text, otherwise, it will not.


## What about speed?

River Dreams is fast enough to be usable, but its performance is not ideal.
I will keep trying to find a solution to its speed.

You can always test its speed by using a benchmark like [`zsh-bench`](https://github.com/romkatv/zsh-bench)
and can obtain a trace of its functions by using `set -x`.


## Installation/Uninstallation

Before installing the theme, you need to ensure that you have its required
dependencies installed:
  + the Noto Font family - this font has a variety of characters that can
    be used as a fallback by your terminal if your current font does not
    contains some symbols used in the theme.
  + a font patched by Nerd Fonts or only the Nerd Font symbols - this font will
    provide you the symbols used in the theme. You can download it in its
    official repository on GitHub.
  + `awk` or some variant - it will be used to parse commands.

Optionally, you can install these other dependencies to get more information
to show in the theme:
  + `git` - it will be used to provide Git information.
  + `docker` - it will be used to provide Docker information. Remember to
     activate its socket/daemon.
  + `ip` or `ipconfig` - it will be used to provide your local IP address.

If you are using Linux, you can probably download the dependencies using
your distribution's package manager.

If you are using MacOS, you can use [HomeBrew](https://brew.sh).

### Installing/Uninstalling With OhMyZSH
  + clone this repository to `${ZSH_CUSTOM}/themes` that is, by default, at
    `~/.oh-my-zsh/custom/themes`.

    ```bash
    git clone --depth 1 https://github.com/skippyr/river_dreams ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/river_dreams
    ```
  + Set the variable `ZSH_THEME=river_dreams/river_dreams` in your `~/.zshrc`.
  + Refresh your ZSH by reopening your terminal emulator.

  If you want to uninstall it, use the following command:
  
  ```bash
  rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/river_dreams
  ```

### Installing/Uninstalling Manually
  + clone this repository to a separated directory, for example
    `~/.config/zsh/plugins/river_dreams`.

    ```bash
    git clone --depth 1 https://github.com/skippyr/river_dreams ~/.config/zsh/plugins/river_dreams
    ```
  + source the theme file `river_dreams.zsh-theme` that is inside the
    repository's directory in your `.zshrc`.

    ```bash
    source ~/.config/zsh/plugins/river_dreams/river_dreams.zsh-theme
    ```
  + Refresh your ZSH by reopening your terminal emulator.

  If you want to uninstall it, remove the directory you have cloned:

  ```bash
  rm -rf ~/.config/zsh/plugins/river_dreams
  ```

### Know Installation Issues

It has been detected that some Linux distributions that have their own default
configurations for `zsh` can result in River Dreams causing errors, but those
can be fixed if those default configurations are removed.

One example of distribution that caused this issue was `Kali Linux`.

## See Also

River Dreams is now part of the [`awesome-zsh-plugins`](https://github.com/unixorn/awesome-zsh-plugins)
repository. What about going there to find out more cool themes, frameworks and
plugins for ZSH?

Are you looking for a color scheme? I am proud to announce that
[`Tropical Paradise`](https://github.com/skippyr/tropical_paradise) has been
released with dark and light variants. What about checking it out?

## Issues, Enhancements And Questions

If you have found an issue while using this software or have an idea to
improve it, feel free to use the issues tab on its page on GitHub.

Questions can be made in the same way, but it would be better if you use
the Discussions tab instead.

## License

Copyright (c) 2023, Sherman Rofeman. MIT License.

