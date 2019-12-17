set_icon_colors() {
  POWERLEVEL9K_OS_ICON_FOREGROUND=$1
  POWERLEVEL9K_OS_ICON_BACKGROUND=$2
}

os_uname="$(uname)"
[[ $os_uname == Linux ]] && os_uname_o="$(uname -o 2>/dev/null)"
if [[ $os_uname == Linux && $os_uname_o == Android ]]; then
  set_icon_colors 118 232
else
  case $os_uname in
    Darwin)                    set_icon_colors 7 232;;
    CYGWIN_NT-* | MSYS_NT-*)   set_icon_colors 39 15;;
    FreeBSD|OpenBSD|DragonFly) set_icon_colors 160 15;;
    Linux)
      local os_release_id
      if [[ -r /etc/os-release ]]; then
        local lines=(${(f)"$(</etc/os-release)"})
        lines=(${(@M)lines:#ID=*})
        (( $#lines == 1 )) && os_release_id=${lines[1]#ID=}
      fi
      case $os_release_id in
        *arch*)                  set_icon_colors 15 69;;
        *debian*)                set_icon_colors 161 15;;
        *raspbian*)              set_icon_colors 233 88 ;;
        *ubuntu*)                set_icon_colors 233 208;;
        *fedora*)                set_icon_colors 20 15;;
        *centos*)                set_icon_colors 54 15;;
        *linuxmint*)             set_icon_colors 15 76;;
        *)                       set_icon_colors 233 15;;
      esac
      ;;
  esac
fi
