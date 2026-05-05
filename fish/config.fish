#neofetch --ascii_distro Arch

# Commands to run in interactive sessions can go here
if status is-interactive
    # No greeting
    set fish_greeting

    # Use starship
    function starship_transient_prompt_func
        starship module character
    end
    if test "$TERM" != "linux"
        starship init fish | source
        enable_transience
    end
    
    # Colors
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    # kitty doesn't clear properly so we need to do this weird printing
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias celar "printf '\033[2J\033[3J\033[1;1H'"
    alias claer "printf '\033[2J\033[3J\033[1;1H'"
    alias pamcan pacman
    alias q 'qs -c ii'
    if test "$TERM" != "linux"
        alias ls 'eza --icons'
    end
    
end

#neofetch --ascii_distro Arch # Hehe

# Configs & Binds
# apagar isso pro TAB voltar a mostrar os arquivos
function fish_user_key_bindings
    bind \t forward-char
end

# My Aliases & Functions
alias ic="cd ~/Projects/eta-car-photometry/"
alias classes="cd ~/Projects/Classes/" 
alias entervenv="source venv/bin/activate.fish & echo "running!""

function mkvenv
	python -m venv venv
	source venv/bin/activate.fish
	echo "set and running!"
end

alias hypr="cd ~/.config/hypr/"
alias ii="cd ~/.config/illogical-impulse/"
alias quickshell="cd ~/.config/quickshell/"

alias vimfish="vim ~/.config/fish/config.fish"

alias reboot="sudo reboot now"

function cleansystem
    echo "=== Starting system deep clean ==="

    echo ""

    echo "=> Trimming pacman cache (keeping 1 version)..."
    sudo paccache -rk1

    echo ""

    echo "=> Removing orphan packages..."
    if pacman -Qtdq > /dev/null
        sudo pacman -Rns (pacman -Qtdq)
    else
    	echo "No orphans found."
    end	

    echo ""

    echo "=> Clearing AUR build cache..."
    rm -rf ~/.cache/yay
    rm -rf ~/.cache/paru
    echo "Done!"

    # not working cause I accidentally deleted the folder
    # echo "Cleaning Hyprland-dots cache..."
    # rm -rf ~/.cache/dots-hyprland

    echo ""

    echo "=> Deleting system logs (older than 2 weeks)..."
    sudo journalctl --vacuum-time=2weeks
    echo "Done!"

    echo ""

    echo "Cleanup complete. Your system can breathe again!"
end

alias conf="cd ~/.config"

function c
	cd ~/Projects/
	nohup code . >/dev/null 2>&1 &
	kill -9 $fish_pid
end

function github
	nohup zen-browser "https://github.com/sarttori" >/dev/null 2>&1 & disown
	kill -9 $fish_pid
end

function wpp
	nohup zen-browser "https://web.whatsapp.com/" >/dev/null 2>&1 & disown
	kill -9 $fish_pid
end

alias dots="cd ~/Documents/GitHub/dotfiles/"

function sync-dots
    set SRC "$HOME/.config"
    set DEST "$HOME/Documents/GitHub/dotfiles"

    echo "Updating dotfiles..."

    # Fish
    mkdir -p "$DEST/fish"
    cp "$SRC/fish/config.fish" "$DEST/fish/"

    # Hypr
    mkdir -p "$DEST/hypr"
    cp -r "$SRC/hypr/." "$DEST/hypr/"

    # illogical-impulse
    mkdir -p "$DEST/illogical-impulse"
    cp "$SRC/illogical-impulse/config.json" "$DEST/illogical-impulse/"

    # Kitty
    mkdir -p "$DEST/kitty"
    cp -r "$SRC/kitty/." "$DEST/kitty/"

    # Quickshell (only the bar)
    mkdir -p "$DEST/quickshell/ii/modules/ii/bar"
    cp "$SRC/quickshell/ii/modules/ii/bar/Bar.qml" "$DEST/quickshell/ii/modules/ii/bar/"
    cp "$SRC/quickshell/ii/modules/ii/bar/BarContent.qml" "$DEST/quickshell/ii/modules/ii/bar/"
    cp "$SRC/quickshell/ii/modules/ii/bar/BarGroup.qml" "$DEST/quickshell/ii/modules/ii/bar/"

    cp "$SRC/chrome-flags.conf" "$DEST/" 2>/dev/null
    cp "$SRC/microsoft-edge-stable-flags.conf" "$DEST/" 2>/dev/null

    echo "Done!"
end

alias ic="cd ~/Projects/eta-car-photometry/"

alias fapesp="cd ~/Documents/Usp/IC/Fapesp/relatorioFAPESP/"

function fromtextogit
	unzip Relatório_FAPESP.zip
	rm -rf Relatório_FAPESP.zip
	git add .
	git commit -m "Updates"
	git push -f origin main

end

alias d0="shutdown now"
