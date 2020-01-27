## Steps after installing the script

### Install Font Fira Code

Access: https://github.com/tonsky/FiraCode/releases
Dowload latest release and install in your fonts
After use 'Fira Code Retina' in your terminal

### Set Spacehsip

Alter ZSH_THEME for:

```
    ZSH_THEME="spaceship"
```

After restarting your terminal with:

```
    source ~/.zshrc
```

### Additional settings for spaceship

In endfile .zshrc add:

```
    SPACESHIP_PROMPT_ORDER=(
    user          # Username section
    dir           # Current directory section
    host          # Hostname section
    git           # Git section (git_branch + git_status)
    hg            # Mercurial section (hg_branch  + hg_status)
    exec_time     # Execution time
    line_sep      # Line break
    vi_mode       # Vi-mode indicator
    jobs          # Background jobs indicator
    exit_code     # Exit code section
    char          # Prompt character
    )
    SPACESHIP_USER_SHOW=always
    SPACESHIP_PROMPT_ADD_NEWLINE=false
    SPACESHIP_CHAR_SYMBOL="λ"
    SPACESHIP_CHAR_SUFFIX=" "
```

### Plugins zsh

Open .zshrc file and below the line "### End of Zplugin's installer chunk", add:

```
    zplugin light zdharma/fast-syntax-highlighting
    zplugin light zsh-users/zsh-autosuggestions
    zplugin light zsh-users/zsh-completions
```

And restart with:

```
    source ~/.zshrc
```

### Nvm setup

After install nvm, please add lines of below to the correct profile file( ~/.bashrc, ~/.zshrc( if install zsh ) ):

```
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

And restart with:

```
    source ~/.zshrc
```

### Yarn global setup

After install yarn, if want use global, add in .zshrc file:

```
    export PATH="$HOME/.yarn/bin:$PATH"
```

## Tips

### VsCode

Install the "Settings Sync" extension, install your extensions and configure the setup, after using the settings synchronization to save your configuration, other times.

### Help or suggestions

Please open issue, i will try to solve it as soon as possible.
