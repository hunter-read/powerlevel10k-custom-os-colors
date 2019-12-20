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

function set_icon_colors() {
    case $1 in
        [0-9]*)   custom_foreground=$1;  custom_background=$2  ;;
        MacOS)    custom_foreground=7;   custom_background=232 ;;     
        Windows)  custom_foreground=39;  custom_background=15  ;;        
        Android)  custom_foreground=118; custom_background=232 ;;        
        BSD)      custom_foreground=160; custom_background=15  ;;        
        Arch)     custom_foreground=15;  custom_background=69  ;;        
        Debian)   custom_foreground=161; custom_background=15  ;;        
        Raspbian) custom_foreground=233; custom_background=88  ;;      
        Ubuntu)   custom_foreground=233; custom_background=208 ;;       
        Fedora)   custom_foreground=20;  custom_background=15  ;;        
        CentOS)   custom_foreground=54;  custom_background=15  ;;        
        Mint)     custom_foreground=15;  custom_background=76  ;;        
        Linux)    custom_foreground=233; custom_background=15  ;;
        *)        custom_foreground=232; custom_background=7   ;; #default
    esac
    custom_return_success=1;
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
    read -k key${(%):-"?%BChoice [12345678bq]: %b"} || quit
    case $key in
      q) quit;;
      r) custom_return_success=0; break;;
      1) custom_icon=$_LINUX;    set_icon_colors Linux;     break;;
      2) custom_icon=$_UBUNTU;   set_icon_colors Ubuntu;    break;;
      3) custom_icon=$_DEBIAN;   set_icon_colors Debian;    break;;
      4) custom_icon=$_RASPBIAN; set_icon_colors Raspbian;  break;;
      5) custom_icon=$_MINT;     set_icon_colors Mint;      break;;
      6) custom_icon=$_FEDORA;   set_icon_colors Fedora;    break;;
      7) custom_icon=$_CENTOS;   set_icon_colors CentOS;    break;;
      8) custom_icon=$_ARCH;     set_icon_colors Arch;      break;;
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
    read -k key${(%):-"?%BChoice [12345bq]: %b"} || quit
    case $key in
      q) quit;;
      r) custom_return_success=0; break;;
      1) custom_icon=$_MACOS;   set_icon_colors MacOS;    break;;
      2) custom_icon=$_WINDOWS; set_icon_colors Windows;  break;;
      3) custom_icon=$_ANDROID; set_icon_colors Android;  break;;
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
    read -k key${(%):-"?%BChoice [123456bq]: %b"} || quit
    case $key in
      q) quit;;
      r) custom_return_success=0; break;;
      1) custom_icon=$_JAVASCRIPT; set_icon_colors; break;; 
      2) custom_icon=$_ANGULAR;    set_icon_colors; break;; 
      3) custom_icon=$_VUE;        set_icon_colors; break;; 
      4) custom_icon=$_REACT;      set_icon_colors; break;; 
      5) custom_icon=$_EMBER;      set_icon_colors; break;; 
      6) custom_icon=$_ELECTRON;   set_icon_colors; break;; 
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
    read -k key${(%):-"?%BChoice [1234567bq]: %b"} || quit
    case $key in
      q) quit;;
      r) custom_return_success=0; break;;
      1) custom_icon=$_PYTHON; set_icon_colors 226 20; break;;
      2) custom_icon=$_JAVA;   set_icon_colors ; break;;
      3) custom_icon=$_CPP;    set_icon_colors ; break;;
      4) custom_icon=$_SWIFT;  set_icon_colors ; break;;
      5) custom_icon=$_RUBY;   set_icon_colors ; break;;
      6) custom_icon=$_GO;     set_icon_colors ; break;;
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
    read -k key${(%):-"?%BChoice [1234567bq]: %b"} || quit
    case $key in
      q) quit;;
      r) custom_return_success=0; break;;
      1) custom_icon=$_DOCKER; set_icon_colors 27 225; break;;
      2) custom_icon=$_GIT; set_icon_colors ; break;;
      3) custom_icon=$_GITHUB; set_icon_colors ; break;;
      4) custom_icon=$_GITLAB; set_icon_colors ; break;;
      5) custom_icon=$_BITBUCKET; set_icon_colors ; break;;
      6) custom_icon=$_AWS; set_icon_colors ; break;;
      7) custom_icon=$_AZURE; set_icon_colors ; break;;
      8) custom_icon=$_DIGITAL_OCEAN; set_icon_colors ; break;;
    esac
  done
}

function choose_other_icon() {
  while true; do
    clear
    print -P "Choose an icon: "
    print -P ""
    print -P "%B(1)  Plex $_PLEX%b"
    print -P "%B(2)  Chrome $_CHROME%b"
    print -P "%B(3)  Firefox $_FIREFOX%b"
    print -P ""
    print -P "(r)  Return to previous step."
    print -P "(q)  Quit and do nothing."
    print -P ""

    local key=
    read -k key${(%):-"?%BChoice [1bq]: %b"} || quit
    case $key in
      q) quit;;
      r) custom_return_success=0; break;;
      1) custom_icon=$_PLEX;    set_icon_colors 232 220; break;;
      2) custom_icon=$_CHROME;  set_icon_colors; break;;
      3) custom_icon=$_FIREFOX; set_icon_colors 166 92;  break;;
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
    read -k key${(%):-"?%BChoice [12q]: %b"} || quit
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

