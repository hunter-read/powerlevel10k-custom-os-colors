#!/usr/bin/env zsh

_P10K_FILE=~/.p10k.zsh
if [[ -f $_P10K_FILE ]]; then
    source $_P10K_FILE
else 
    echo "p10k.zsh not found. Please configure powerlevel10k first and then run this script"
    exit 1
fi

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
_JAVA=$'\ue738'
_CPP=$'\ufb71'
_SWIFT=$'\uE755'
_JAVASCRIPT=$'\ue74e'
_RUBY=$'\uF219'
_ANGULAR=$'\ue753'
_VUE=$'\ufd42'
_EMBER=$'\ue71b'
_ELECTRON=$'\ue62e'
_REACT=$'\ufc06'
_GO=$'\ue724'

#dev tool icons
_DOCKER=$'\uF308'
_GIT=$'\ue702'
_GITHUB=$'\uf09b'
_BITBUCKET=$'\ue703'
_GITLAB=$'\uf296'
_AWS=$'\ue7ad'
_DIGITAL_OCEAN=$'\ue7ae'
_AZURE=$'\ufd03'


#other icons
_PLEX=$'\uFBB8'
_CHROME=$'\ue743'
_FIREFOX=$'\ue745'


custom_foreground=232
custom_background=7

function quit() {
    print -P ""
    print -P "Exiting, no changes have been made."
    exit 0
}

#can take args:
#os
function _set_icon_colors() {
  custom_foreground=$1
  custom_background=$2
  [[ ! -z "$3" ]] && custom_icon=$3
}

function set_icon_colors() {
  custom_return_success=1
  case $1 in
    [0-9]*)       _set_icon_colors $1 $2 $3;;
    Android)      _set_icon_colors 118 232 $2;;        
    Angular)      custom_icon=$_ANGULAR;;
    Arch)         _set_icon_colors 15 69 $2;;        
    Aws)          custom_icon=$_AWS;;
    Azure)        custom_icon=$_AZURE;;
    Bitbucket)    _set_icon_colors 26 251 $_BITBUCKET;;
    BSD)          _set_icon_colors 160 15 $2;;        
    CentOS)       _set_icon_colors 54 15 $2;;        
    Cpp)          custom_icon=$_CPP;;
    Debian)       _set_icon_colors 161 15 $2;;        
    DigitalOcean) custom_icon=$_DIGITAL_OCEAN;;
    Docker)       _set_icon_colors 27 225 $_DOCKER;;
    Electron)     custom_icon=$_ELECTRON;;
    Ember)        custom_icon=$_EMBER;; 
    Fedora)       _set_icon_colors 20 15 $2;;        
    Firefox)      _set_icon_colors 166 92 $_FIREFOX;;
    Git)          custom_icon=$_GIT;;
    Github)       _set_icon_colors 16 253 $_GITHUB;;
    Gitlab)       _set_icon_colors 172 53 $_GITLAB;;
    Go)           custom_icon=$_GO;;
    Java)         custom_icon=$_JAVA;;
    Javascript)   custom_icon=$_JAVASCRIPT;; 
    Linux)        _set_icon_colors 233 15 $2;;
    MacOS)        _set_icon_colors 7 232 $2;;     
    Mint)         _set_icon_colors 15 76 $2;;        
    Plex)         _set_icon_colors 232 220 $_PLEX;;
    Python)       _set_icon_colors 226 20 $_PYTHON;;
    Raspbian)     _set_icon_colors 233 88 $2;;      
    React)        custom_icon=$_REACT;; 
    Ruby)         custom_icon=$_RUBY;;
    Swift)        custom_icon=$_SWIFT;;
    Ubuntu)       _set_icon_colors 233 208 $2;;       
    Vue)          _set_icon_colors 34 232 $_VUE;;
    Windows)      _set_icon_colors 39 15 $2;;        
    *)            _set_icon_colors 232 7;;
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
    set_icon_colors Android
    else
    case $os_uname in
        Darwin)                    set_icon_colors MacOS;;
        CYGWIN_NT-* | MSYS_NT-*)   set_icon_colors Windows;;
        FreeBSD|OpenBSD|DragonFly) set_icon_colors BSD;;
        Linux)
        local os_release_id
        if [[ -r /etc/os-release ]]; then
            local lines=(${(f)"$(</etc/os-release)"})
            lines=(${(@M)lines:#ID=*})
            (( $#lines == 1 )) && os_release_id=${lines[1]#ID=}
        fi
        case $os_release_id in
            *arch*)                  set_icon_colors Arch;;
            *debian*)                set_icon_colors Debian;;
            *raspbian*)              set_icon_colors Raspbian ;;
            *ubuntu*)                set_icon_colors Ubuntu;;
            *fedora*)                set_icon_colors Fedora;;
            *centos*)                set_icon_colors CentOS;;
            *linuxmint*)             set_icon_colors Mint;;
            *)                       set_icon_colors Linux;;
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
    print -P "(r)  Return to previous step."
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [12345678rq]: %b"} || quit
    case $key in
      q) quit;;
      r) custom_return_success=0; break;;
      1) set_icon_colors Linux $_LINUX;       break;;
      2) set_icon_colors Ubuntu $_UBUNTU;     break;;
      3) set_icon_colors Debian $_DEBIAN;     break;;
      4) set_icon_colors Raspbian $_RASPBIAN; break;;
      5) set_icon_colors Mint $_MINT;         break;;
      6) set_icon_colors Fedora $_FEDORA;     break;;
      7) set_icon_colors CentOS $_CENTOS;     break;;
      8) set_icon_colors Arch $_ARCH;         break;;
    esac
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
    print -P "(r)  Return to previous step."
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [12345rq]: %b"} || quit
    case $key in
      q) quit;;
      r) custom_return_success=0; break;;
      1) set_icon_colors MacOS $_MACOS;     break;;
      2) set_icon_colors Windows $_WINDOWS; break;;
      3) set_icon_colors Android $_ANDROID; break;;
      5) choose_linux_icon; [[ $custom_return_success == 1 ]] && break;;
    esac
  done
}

function choose_js_icon() {
  while true; do
    clear
    print -P "Choose an icon: "
    print -P ""
    print -P "%B(1)  Javascript $_JAVASCRIPT%b"
    print -P "%B(2)  Angular $_ANGULAR%b"
    print -P "%B(3)  VueJS $_VUE%b"
    print -P "%B(4)  React $_REACT%b"
    print -P "%B(5)  Ember $_EMBER%b"
    print -P "%B(6)  Electron $_ELECTRON%b"
    print -P ""
    print -P "(r)  Return to previous step."
    print -P "(q)  Quit and do nothing."
    print -P ""


    local key=
    read -k key${(%):-"?%BChoice [123456rq]: %b"} || quit
    case $key in
      q) quit;;
      r) custom_return_success=0;    break;;
      1) set_icon_colors Javascript; break;; 
      2) set_icon_colors Angular;    break;; 
      3) set_icon_colors Vue;        break;; 
      4) set_icon_colors React;      break;; 
      5) set_icon_colors Ember;      break;; 
      6) set_icon_colors Electron;   break;; 
    esac
  done
}

function choose_prog_icon() {
  while true; do
    clear
    print -P "Choose an icon: "
    print -P ""
    print -P "%B(1)  Python $_PYTHON%b"
    print -P "%B(2)  Java $_JAVA%b"
    print -P "%B(3)  C++ $_CPP%b"
    print -P "%B(4)  Swift $_SWIFT%b"
    print -P "%B(5)  Ruby $_RUBY%b"
    print -P "%B(6)  Go $_GO%b"
    print -P "%B(7)  Javascript (Choose a framework)%b"
    print -P ""
    print -P "(r)  Return to previous step."
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [1234567rq]: %b"} || quit
    case $key in
      q) quit;;
      r) custom_return_success=0; break;;
      1) set_icon_colors Python; break;;
      2) set_icon_colors Java; break;;
      3) set_icon_colors Cpp; break;;
      4) set_icon_colors Swift; break;;
      5) set_icon_colors Ruby; break;;
      6) set_icon_colors Go; break;;
      7) choose_js_icon; [[ $custom_return_success == 1 ]] && break;;
    esac
  done
}

function choose_dev_icon() {
  while true; do
    clear
    print -P "Choose an icon: "
    print -P ""
    print -P "%B(1)  Docker $_DOCKER%b"
    print -P "%B(2)  Git $_GIT%b"
    print -P "%B(3)  Github $_GITHUB%b"
    print -P "%B(4)  Gitlab $_GITLAB%b"
    print -P "%B(5)  Bitbucket $_BITBUCKET%b"
    print -P "%B(6)  AWS $_AWS%b"
    print -P "%B(7)  Azure $_AZURE%b"
    print -P "%B(8)  Digital Ocean $_DIGITAL_OCEAN%b"
    print -P ""
    print -P "(r)  Return to previous step."
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [12345678rq]: %b"} || quit
    case $key in
      q) quit;;
      r) custom_return_success=0; break;;
      1) set_icon_colors Docker; break;;
      2) set_icon_colors Git; break;;
      3) set_icon_colors Github; break;;
      4) set_icon_colors Gitlab; break;;
      5) set_icon_colors Bitbucket; break;;
      6) set_icon_colors Aws; break;;
      7) set_icon_colors Azure; break;;
      8) set_icon_colors DigitalOcean; break;;
    esac
  done
}

function choose_other_icon() {
  while true; do
    clear
    print -P "Choose an icon: "
    print -P ""
    print -P "%B(1)  Plex $_PLEX%b"
    print -P "%B(2)  Firefox $_FIREFOX%b"
    print -P ""
    print -P "(r)  Return to previous step."
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [12rq]: %b"} || quit
    case $key in
      q) quit;;
      r) custom_return_success=0; break;;
      1) set_icon_colors Plex; break;;
      2) set_icon_colors Firefox;  break;;
    esac
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
    read -k key${(%):-"?%BChoice [1234q]: %b"} || quit
    case $key in
      q) quit;;
      1) choose_os_icon ;;
      2) choose_prog_icon ;;
      3) choose_dev_icon ;;
      4) choose_other_icon ;;
    esac
    [[ $custom_return_success == 1 ]] && break  
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


# Add custom icon
result=$(grep -F "POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION" $_P10K_FILE)
if [[ -n $result ]]; then
  sed -i.os-colors.bkup "/.*POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION.*/d" $_P10K_FILE
fi
if [[ ! -z "$custom_icon" ]]; then
  sed -i.os-colors-bkup -e"/.*os_icon:.*/a\ 
  typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION=$custom_icon" $_P10K_FILE
else
  #Restore default
  sed -i.os-colors-bkup -e'/.*os_icon:.*/a\
  typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='\''%B${P9K_CONTENT}'\''' $_P10K_FILE
fi

#set icon colour
result=$(grep -F "POWERLEVEL9K_OS_ICON_FOREGROUND" $_P10K_FILE)
if [[ -n $result ]]; then
  sed -i.os-colors.bkup -e"/.*POWERLEVEL9K_OS_ICON_FOREGROUND.*/d" $_P10K_FILE
fi
sed -i.os-colors-bkup -e"/.*os_icon:.*/a\ 
  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=$custom_foreground" $_P10K_FILE

#set icon background colour
result=$(grep -F "POWERLEVEL9K_OS_ICON_BACKGROUND" $_P10K_FILE)
if [[ -n $result ]]; then
  sed -i.os-colors.bkup -e"/.*POWERLEVEL9K_OS_ICON_BACKGROUND.*/d" $_P10K_FILE
fi
sed -i.os-colors-bkup -e"/.*os_icon:.*/a\ 
 typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=$custom_background" $_P10K_FILE

clear
echo ""
echo "Updating ~/.p10k.zsh"
echo "Reload your zsh with 'source ~/.zshrc'"
rm -f $_P10K_FILE.os-colors-bkup


