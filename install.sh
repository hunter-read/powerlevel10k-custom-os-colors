#!/usr/bin/env zsh
if [[ -f ~/.p10k.zsh ]]; then
    source ~/.p10k.zsh
else 
    echo "p10k.zsh not found. Please configure powerlevel10k first and then run this script"
    exit 1
fi

_BASE_PATH=${ZSH_CUSTOM:-$HOME}
_CUSTOM_ICON_COLOR_FILE=$_BASE_PATH/.custom-p10k-icon-colors.zsh

#os icons
_MACOS=$'\uF179'
_WINDOWS=$'\uF17A'
_ANDROID=$'\uF17B'
_BSD=$'\UF30C'
_ARCH=$'\uF303'
_DEBIAN=$'\uF306'
_RASPBIAN=$'\uF315'
_UBUNTU=$'\uF31b'
_FEDORA=$'\uF30a'
_CENTOS=$'\uF304'
_MINT=$'\uF30e'
_LINUX=$'\uF17c'

#programming language icons
_PYTHON=$'\uE73C'

#dev tool icons
_DOCKER=$'\uF308'

#other icons
_PLEX=$'\uFBB8'

function quit() {
    print -P ""
    print -P "Exiting, no changes have been made."
    exit 0
}

function set_os_icon_colors() {
    case $1 in
        MacOS) 
            custom_foreground=7
            custom_background=232
            ;;        
        Windows)
            custom_foreground=39
            custom_background=15
            ;;        
        Android)
            custom_foreground=118
            custom_background=232
            ;;        
        BSD)
            custom_foreground=160
            custom_background=15
            ;;        
        Arch)
            custom_foreground=15
            custom_background=69
            ;;        
        Debian)
            custom_foreground=161
            custom_background=15
            ;;        
        Raspbian)
            custom_foreground=233
            custom_background=88
            ;;        
        Ubuntu)
            custom_foreground=233
            custom_background=208
            ;;        
        Fedora)
            custom_foreground=20
            custom_background=15
            ;;        
        CentOS)
            custom_foreground=54
            custom_background=15
            ;;        
        Mint)
            custom_foreground=15
            custom_background=76
            ;;        
        Linux)
            custom_foreground=233
            custom_background=15
            ;;
        *)
            exit 1
            ;;
    esac
}

function ask_custom() {
  while true; do
    clear
    print -P "Do you want to set a custom os icon option or keep the same os icon and colorize it?"
    print -P ""
    print -P "%B(1)  Just colorize the current OS Icon.%b"
    print -P ""
    print -P "%B(2)  Custom Icon. Requires Nerd Fonts.%b"
    print -P ""
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [12q]: %b"} || quit
    case $key in
      q) quit;;
      1) do_custom_icon=0; break;;
      2) do_custom_icon=1; break;;
    esac
  done
}

function handle_no_custom() {
    os_uname="$(uname)"
    [[ $os_uname == Linux ]] && os_uname_o="$(uname -o 2>/dev/null)"
    if [[ $os_uname == Linux && $os_uname_o == Android ]]; then
    set_os_icon_colors Android
    else
    case $os_uname in
        Darwin)                    set_os_icon_colors MacOS;;
        CYGWIN_NT-* | MSYS_NT-*)   set_os_icon_colors Windows;;
        FreeBSD|OpenBSD|DragonFly) set_os_icon_colors BSD;;
        Linux)
        local os_release_id
        if [[ -r /etc/os-release ]]; then
            local lines=(${(f)"$(</etc/os-release)"})
            lines=(${(@M)lines:#ID=*})
            (( $#lines == 1 )) && os_release_id=${lines[1]#ID=}
        fi
        case $os_release_id in
            *arch*)                  set_os_icon_colors Arch;;
            *debian*)                set_os_icon_colors Debian;;
            *raspbian*)              set_os_icon_colors Raspbian ;;
            *ubuntu*)                set_os_icon_colors Ubuntu;;
            *fedora*)                set_os_icon_colors Fedora;;
            *centos*)                set_os_icon_colors CentOS;;
            *linuxmint*)             set_os_icon_colors Mint;;
            *)                       set_os_icon_colors Linux;;
        esac
        ;;
    esac
    fi
}

function choose_linux_icon() {
  while true; do
    clear
    print -P "Choose an icon: "
    print -P ""
    print -P "%B(1)  Linux $_LINUX%b"
    print -P "%B(2)  Ubuntu $_UBUNTU%b"
    print -P "%B(3)  Debian $_DEBIAN%b"
    print -P "%B(4)  Raspbian $_RASPBIAN%b"
    print -P "%B(5)  Linux Mint $_MINT%b"
    print -P "%B(6)  Fedora $_FEDORA%b"
    print -P "%B(7)  CentOS $_CENTOS%b"
    print -P "%B(8)  Arch Linux $_ARCH%b"
    print -P ""
    print -P "(b)  Go back to last step."
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [12345678bq]: %b"} || quit
    case $key in
      q) quit;;
      b) 
        custom_return_success=0 
        break
        ;;
      1) 
        custom_icon=$_LINUX
        set_os_icon_colors Linux 
        ;;
      2) 
        custom_icon=$_UBUNTU
        set_os_icon_colors Ubuntu
        ;;
      3) 
        custom_icon=$_DEBIAN 
        set_os_icon_colors Debian
        ;;
      4)
        custom_icon=$_RASPBIAN
        set_os_icon_colors Raspbian
        ;;
      5)
        custom_icon=$_MINT
        set_os_icon_colors Mint
        ;;
      6)
        custom_icon=$_FEDORA
        set_os_icon_colors Fedora
        ;;
      7)
        custom_icon=$_CENTOS
        set_os_icon_colors CentOS
        ;;
      8)
        custom_icon=$_ARCH
        set_os_icon_colors Arch
        ;;
    esac
    custom_return_success=1
    break
  done
}

function choose_os_icon() {
  while true; do
    clear
    print -P "Choose an icon: "
    print -P ""
    print -P "%B(1)  MacOS $_MACOS%b"
    print -P "%B(2)  Windows $_WINDOWS%b"
    print -P "%B(3)  Android $_ANDROID%b"
    print -P "%B(4)  FreeBSD/OpenBSD $_BSD%b"
    print -P "%B(5)  Linux (Choose a distro).%b"
    print -P ""
    print -P "(b)  Go back to last step."
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [12345bq]: %b"} || quit
    case $key in
      q) quit;;
      b) 
        custom_return_success=0 
        break
        ;;
      1) 
        custom_icon=$_MACOS
        set_os_icon_colors MacOS 
        custom_return_success=1
        break
        ;;
      2) 
        custom_icon=$_WINDOWS
        set_os_icon_colors Windows
        custom_return_success=1
        break 
        ;;
      3) 
        custom_icon=$_ANDROID 
        set_os_icon_colors Android
        custom_return_success=1
        break
        ;;
      4)
        custom_icon=$_BSD 
        set_os_icon_colors BSD
        custom_return_success=1
        break
        ;;
      5)
        choose_linux_icon
        if [[ $custom_return_success == 1 ]]; then
            break
        fi
    esac
  done
}

function choose_prog_icon() {
  while true; do
    clear
    print -P "Choose an icon: "
    print -P ""
    print -P "%B(1)  Python $_PYTHON%b"
    print -P ""
    print -P "(b)  Go back to last step."
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [1bq]: %b"} || quit
    case $key in
      q) quit;;
      b) 
        custom_return_success=0 
        break
        ;;
      1) 
        custom_icon=$_PYTHON
        custom_foreground=226
        custom_background=20
        ;;
    esac
    custom_return_success=1
    break
  done
}

function choose_dev_icon() {
  while true; do
    clear
    print -P "Choose an icon: "
    print -P ""
    print -P "%B(1)  Docker $_DOCKER%b"
    print -P ""
    print -P "(b)  Go back to last step."
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [1bq]: %b"} || quit
    case $key in
      q) quit;;
      b) 
        custom_return_success=0 
        break
        ;;
      1) 
        custom_icon=$_DOCKER
        custom_foreground=27
        custom_background=255
        ;;
    esac
    custom_return_success=1
    break
  done
}

function choose_other_icon() {
  while true; do
    clear
    print -P "Choose an icon: "
    print -P ""
    print -P "%B(1)  Plex $_PLEX%b"
    print -P ""
    print -P "(b)  Go back to last step."
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [1bq]: %b"} || quit
    case $key in
      q) quit;;
      b) 
        custom_return_success=0 
        break
        ;;
      1) 
        custom_icon=$_PLEX
        custom_foreground=232
        custom_background=220
        ;;
    esac
    custom_return_success=1
    break
  done
}

function handle_custom() {
  while true; do
    clear
    print -P "Choose a group: "
    print -P ""
    print -P "%B(1)  Operating Systems%b"
    print -P "%B(2)  Programming Languages.%b"
    print -P "%B(3)  Development Tools.%b"
    print -P "%B(4)  Other.%b"
    print -P ""
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [12q]: %b"} || quit
    case $key in
      q) quit;;
      1) choose_os_icon ;;
      2) choose_prog_icon ;;
      3) choose_dev_icon ;;
      4) choose_other_icon ;;
    esac
    if [[ $custom_return_success == 1 ]]; then    
        break
    fi
  done
}

ask_custom
if [[ $do_custom_icon == 0 ]]; then
    handle_no_custom
elif [[ $do_custom_icon == 1 ]]; then
    echo $POWERLEVEL9K_MODE
    if [[ $POWERLEVEL9K_MODE == nerdfont-complete || $POWERLEVEL9K_MODE == nerdfont-fontconfig ]]; then
        handle_custom
    else
        echo "Nerd-font patched (complete) font required (https://github.com/ryanoasis/nerd-fonts)"
        exit 1
    fi
else
    exit 1
fi

#First unset any icons and colors that may be set
sed -i.os-colors.bkup "/source $(echo $_CUSTOM_ICON_COLOR_FILE | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')/d" $HOME/.zshrc
touch $_CUSTOM_ICON_COLOR_FILE
echo "#!/usr/bin/env zsh" > $_CUSTOM_ICON_COLOR_FILE
[ ! -z "$custom_icon" ] && echo "POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION=$custom_icon" >> $_CUSTOM_ICON_COLOR_FILE
echo "POWERLEVEL9K_OS_ICON_FOREGROUND=$custom_foreground" >> $_CUSTOM_ICON_COLOR_FILE
echo "POWERLEVEL9K_OS_ICON_BACKGROUND=$custom_background" >> $_CUSTOM_ICON_COLOR_FILE
clear
echo ""
echo "Saving selection to $_CUSTOM_ICON_COLOR_FILE and updating .zshrc"
echo "source $_CUSTOM_ICON_COLOR_FILE" >> $HOME/.zshrc
echo "Re-source your .zshrc with 'source ~/.zshrc'"
rm -f .zshrc.os-colors.bkup

