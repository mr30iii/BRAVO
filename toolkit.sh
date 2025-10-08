#!/data/data/com.termux/files/usr/bin/bash
# Enhanced_Termux_Setup_RAJA.sh - Complete Banner, Menu, and Dynamic Prompt Script

# --- CONFIGURATION FILE ---
# User ka naam is file mein save hoga Termux home directory mein
CONFIG_FILE="$HOME/.fancy_prompt_name"

### USER CONFIG
SLEEP_CHAR=0.002       # Banner typing speed
SLEEP_LINE=0.01        # Delay after each banner line
BANNER_DELAY=0.5
CENTER_TEXT=1          # 1 = center banner horizontally
USE_PROGRESS=1         # Small loading bar before banner
GRADIENT_STYLE="rainbow"  # options: rainbow, teal, sunset, green

# Owner Info (Default fallback)
OWNER_NAME="u0_a326"
GITHUB_LINK="https://github.com/mr30iii"
WHATSAPP_CHANNEL="https://www.whatsapp.com/channel/0029VbBTcfJCHDys1Q2ltf0n"

# --- ANSI/Color Definitions ---
ESC="\e"
RESET="${ESC}[0m"
BOLD="${ESC}[1m"
DIM="${ESC}[2m"
UNDER="${ESC}[4m"
fg() { printf "%b" "${ESC}[38;5;$1m"; }
bgc() { printf "%b" "${ESC}[48;5;$1m"; }

# --- UTILITY FUNCTIONS ---
get_cols() { cols=$(tput cols 2>/dev/null || echo 80); echo $cols; }

center_line() {
  local line="$1"
  if [ "$CENTER_TEXT" -eq 1 ]; then
    local cols=$(get_cols)
    local len=${#line}
    if [ "$len" -lt "$cols" ]; then
      local pad=$(( (cols - len) / 2 ))
      printf "%*s%s\n" $pad "" "$line"
    else
      printf "%s\n" "$line"
    fi
  else
    printf "%s\n" "$line"
  fi
}

gradient_color() {
  local idx=$1
  case "$GRADIENT_STYLE" in
    rainbow) colors=(196 202 208 214 220 226 190 154 118 82 46 47 48 51 39 27 21) ;;
    teal)    colors=(30 31 36 37 43 44 50 51) ;;
    sunset)  colors=(160 166 172 178 184 220 208) ;;
    green)   colors=(22 28 34 40 46 82 118 154) ;;
    *)       colors=(82 118 154 190 226) ;;
  esac
  local n=${#colors[@]}
  echo "${colors[$(( idx % n ))]}"
}

type_line_colored() {
  local line="$1"
  local baseidx=${2:-0}
  for ((i=0;i<${#line};i++)); do
    ch="${line:i:1}"
    color=$(gradient_color $((baseidx + i)))
    printf "%b" "$(fg $color)${ch}${RESET}"
    sleep $SLEEP_CHAR
  done
  printf "\n"
  sleep $SLEEP_LINE
}

progress_bar() {
  [ "$USE_PROGRESS" -eq 1 ] || return
  local width=36
  local step=0
  printf "%b" "${DIM}Preparing environment:${RESET} "
  while [ $step -le $width ]; do
    local filled=$step
    local empty=$((width - step))
    printf "%b" "["
    for ((i=0;i<filled;i++)); do printf "%b" "$(fg 46)=${RESET}"; done
    for ((i=0;i<empty;i++)); do printf " "; done
    printf "%b" "] %3d%%\r" $(( (step * 100) / width ))
    sleep 0.008
    step=$((step + 1))
  done
  printf "\n"
  sleep 0.08
}

# --- ORIGINAL FALLBACK BANNER (Wapas Add Kiya Gaya) ---
read -r -d '' FALLBACK <<'EOF'

⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠉⠙⠛⠛⠛⠛⠛⠻⠿⠷⠶⢶⣶⣶⣤⣤⣤⣄⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠛⠛⠛⠿⠿⣿⣶⣶⣶⣶⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠻⠿⣿⣷⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣄⣀⣀⣈⣉⠛⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣴⠶⠶⠿⠿⠛⠛⠛⠛⠛⠋⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠛⠛⠛⠛⠻⠿⠧⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣤⣤⠶⠶⠟⠛⠛⠋⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣤⣤⣤⣴⣶⣶⡎⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣴⣶⣶⣿⣿⣿⠿⠿⠿⠿⠟⠛⠛⠓⠘⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣶⣶⣿⠿⠿⠛⠛⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠂⠄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣶⠿⠟⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣷⣦⣤⣤⣤⣤⣤⣄⣀⣀⠀⠀⠀⠀⠈⠑⠢⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⡶⠿⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⣿⣿⣿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣷⣶⣼⣄⠀⢠⠈⠑⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⡿⠟⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠻⢿⣿⣿⣾⣷⣄⢤⠙⢦⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠄⠊⠁⠀ _____  ___      __ ___ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⢿⣿⣷⣤⣉⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀   / __ \/   |     / /   |⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⣿⣿⣿⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀ / /_/ / /| |__  / / /| |         ⠀⠀⠀⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⢿⣿⣷⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀/ _, _/ ___ / /_/ / ___ |⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣿⣦⣄⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀/_/ |_/_/  |_\____/_/  |_|⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⠟⠉⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣷⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⠿⣿⣿⣿⣿⣿⣶⣶⣶⣶⣶⣶⣶⣶⣦⣤⣤⣤⣤⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠛⠛⠛⠛⠛⠛⠛⠻⠿⠿⢿⣿⣿⣿⣿⣿⠿⢷⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀██╗      ██╗ ███╗   ██╗ ██╗   ██╗ ██╗  ██╗                    ⠀⠀⠀⠀⠀⠀⠈⠉⠛⠿⢿⣶⣤⡉⠙⠻⢷⣦⣄⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀ ██║     ███║ ████╗  ██║ ██║   ██║ ╚██╗██╔╝⠀              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢿⣦⡄⠀⠈⠙⠿⣦⡀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀██║    ╚ ██║ ██╔██╗ ██║ ██║   ██║  ╚███╔╝                                  ⠀⠀⠀⠙⢿⣦⡀⠀⠀⠈⠻⣦⡀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀██║      ██║ ██║╚██╗██║ ██║   ██║  ██╔██╗⠀⠀⠀⠀⠀⠀                       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣷⡄⠀⠀⠀⠈⢿⡄⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀███████╗ ██║ ██║ ╚████║ ╚██████╔╝ ██╔╝ ██╗⠀⠀⠀⠀⠀⠀⠀                           ⠀⠀⠀⠀⠀⠙⣿⡄⠀⠀⠀⠀⢻⡄
⠀⠀⠀⠀⠀⠀⠀⠀⠀╚══════╝ ╚═╝ ╚═╝  ╚═══╝  ╚═════╝  ╚═╝  ╚═╝⠀⠀⠀⠀⠀⠀⠀⠀                          ⠀⠀⠀⠀⠀⠀⠘⣿⡀⠀⠀⠀⠀⢣
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠹⣇⠀⠀⠀⠀⠘
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⢻⡄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⠈⣇⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⠀⢹⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⠀⠘ 

EOF

build_banner_text() {
  local text="$1"
  if command -v toilet >/dev/null 2>&1; then
    toilet -f term -F border "$text" 2>/dev/null || toilet "$text" 2>/dev/null
  elif command -v figlet >/dev/null 2>&1; then
    figlet -f slant "$text" 2>/dev/null || figlet "$text" 2>/dev/null
  else
    echo "$FALLBACK" # Ab Fallback Banner use hoga
  fi
}

# --- USERNAME MANAGEMENT ---
get_username() {
    if [ -f "$CONFIG_FILE" ] && [ -s "$CONFIG_FILE" ]; then
        read -r SAVED_NAME < "$CONFIG_FILE"
        OWNER_NAME="$SAVED_NAME"
        printf "%b" "$(fg 46)Welcome back, ${BOLD}$OWNER_NAME!${RESET}\n"
    else
        printf "\n%b" "$(fg 220)${BOLD}👋 Hello! Please enter the name you want to see on your banner/prompt:${RESET} "
        read -r NEW_NAME
        
        if [ -n "$NEW_NAME" ]; then
            echo "$NEW_NAME" > "$CONFIG_FILE"
            OWNER_NAME="$NEW_NAME"
            printf "\n%b\n" "$(fg 82)${BOLD}✅ Name saved as '$OWNER_NAME'!${RESET} Please type 'exit' now and open Termux again to see the changes applied permanently.${RESET}"
            exit 0
        else
            printf "\n%b\n" "$(fg 196)⚠️ Name not set. Using default username ($OWNER_NAME).$RESET"
        fi
    fi
}

# --- MENU FUNCTIONS (Options ke liye) ---

install_packages() {
    local PKGS=(git curl wget python nodejs figlet toilet nano)
    printf "\n%b" "${BOLD}${UNDER}1. Installing All Packages...${RESET}\n"
    for pkg in "${PKGS[@]}"; do
        if ! dpkg -s "$pkg" >/dev/null 2>&1; then
            printf "%b\n" "-> Installing $pkg ..."
            pkg install -y "$pkg"
        else
            printf "%b\n" "-> $pkg already installed."
        fi
    done
    printf "%b\n" "${DIM}Package installation complete!${RESET}\n"
    read -r -p "Press ENTER to return to the menu..."
}

edit_shell_config() {
    printf "\n%b" "${BOLD}${UNDER}2. Editing Shell Config (.bashrc)...${RESET}\n"
    if command -v nano >/dev/null 2>&1; then
        nano ~/.bashrc
    else
        printf "%b\n" "$(fg 196)⚠️ Nano not found. Please install it first using option 1 or 'pkg install nano'.${RESET}"
        read -r -p "Press ENTER to return to the menu..."
    fi
}

edit_banner_script() {
    printf "\n%b" "${BOLD}${UNDER}3. Customizing Banner Script...${RESET}\n"
    if command -v nano >/dev/null 2>&1; then
        nano "$0" 
    else
        printf "%b\n" "$(fg 196)⚠️ Nano not found. Please install it first using option 1 or 'pkg install nano'.${RESET}"
        read -r -p "Press ENTER to return to the menu..."
    fi
}

# --- MAIN MENU FUNCTION ---
main_menu() {
    local CHOICE
    while true; do
        clear
        printf "\n%b\n" "${BOLD}=========================================${RESET}"
        printf "%b\n" "$(fg 46)Welcome, ${OWNER_NAME}! Choose an option:${RESET}"
        printf "%b\n" "${BOLD}=========================================${RESET}"
        printf "%b\n" " ${BOLD}1)${RESET} $(fg 82)Install All Packages${RESET} (Essential tools)"
        printf "%b\n" " ${BOLD}2)${RESET} $(fg 118)Edit Shell Config (.bashrc)${RESET} (Permanent startup ke liye)"
        printf "%b\n" " ${BOLD}3)${RESET} $(fg 220)Customize Banner Script${RESET} (Variables edit karein)"
        printf "%b\n" " ${BOLD}E)${RESET} $(fg 196)Exit Menu and Start Fancy Shell${RESET}"
        printf "%b\n" "${BOLD}=========================================${RESET}"
        printf "%b" "${BOLD}Enter choice (1-3 or E): ${RESET}"
        read -r CHOICE

        case "$CHOICE" in
            1) install_packages ;;
            2) edit_shell_config ;;
            3) edit_banner_script ;;
            [eE]) 
                clear
                printf "%b\n" "${DIM}Starting your personalized shell...${RESET}"
                return 0
                ;;
            *) printf "\n%b\n" "$(fg 196)Invalid choice! Please try again.${RESET}"; sleep 1 ;;
        esac
    done
}

# --- INTERACTIVE FANCY PROMPT FUNCTION (Final Shell) ---
interactive_prompt() {
  local username="$OWNER_NAME"
  local host="termux"
  local arrow_colors=(196 202 208 46) # Arrows rainbow
  local idx=0
  local typing_speed=0.005 

  # Time-Based Colors ke liye
  local colors_morning=(220 184 214) 
  local colors_afternoon=(46 51 81)  
  local colors_night=(27 21 160)     
  local hour=$(date +%H)
  local main_scheme=("${colors_afternoon[@]}") 

  if [ "$hour" -ge 06 ] && [ "$hour" -lt 12 ]; then
    main_scheme=("${colors_morning[@]}") 
  elif [ "$hour" -ge 18 ] || [ "$hour" -lt 06 ]; then
    main_scheme=("${colors_night[@]}")   
  fi

  printf "\n%b" "${BOLD}Fancy Prompt shuru ho raha hai (rukne ke liye 'exit' likhein)...${RESET}\n"

  while true; do
    local user_col=${main_scheme[$((idx % ${#main_scheme[@]}))]}
    local host_col=${main_scheme[$(( (idx + 1) % ${#main_scheme[@]} ))]}
    local arrow_col=${arrow_colors[$((idx % ${#arrow_colors[@]}))]}
    local dim_arrow_col=240
    local cwd=$(pwd | sed "s|^$HOME|~|")

    # --- PROMPT DISPLAY ---
    printf "%b" "$(fg $arrow_col)╭─["
    printf "%b" "$(fg $user_col)$username"
    printf "%b" "$(fg $dim_arrow_col)@$RESET"
    printf "%b" "$(fg $host_col)$host"
    printf "%b" "$(fg $arrow_col) ($cwd)]" # Directory display
    printf "%b" "\n"
    printf "%b" "$(fg $arrow_col)╰જ⁀➴𓂃𓆩♚𓆪▶ ${RESET}" 

    IFS= read -r input

    if [ "$input" = "exit" ]; then
        printf "\n%b\n" "${DIM}Fancy Prompt band ho raha hai...${RESET}"
        break
    fi

    # Animated typing simulation
    printf "\r"
    printf "%b" "$(fg $arrow_col)╰─▶ ${RESET}"
    for ((i=0;i<${#input};i++)); do
      ch="${input:i:1}"
      color=${arrow_colors[$(( (idx+i) % ${#arrow_colors[@]} ))]}
      printf "%b" "$(fg $color)$ch${RESET}"
      sleep $typing_speed
    done
    printf "%b" "$(fg 226)${BOLD}█${RESET}" # Final cursor
    
    # Command execution simulated output
    printf "\n"
    if [ ! -z "$input" ]; then
        printf "%b" "$(fg 245)${DIM}┌─${RESET}$(fg 250)${BOLD}Output for:${RESET} $(fg 82)${input}${RESET}\n"
        printf "%b" "$(fg 245)└─${RESET}$(fg 240)Command executed successfully (simulation).${RESET}\n"
    fi

    idx=$((idx+1))
  done
}

# ==========================================================
# === MAIN SCRIPT EXECUTION ===
# ==========================================================
clear
get_username # Step 1: Naam set ya load hoga

# Sirf tabhi aage badho jab naam save ho chuka ho (i.e. first run ke baad)
if [ -f "$CONFIG_FILE" ]; then
    progress_bar

    printf "%b" "${DIM}${BOLD}Initializing...${RESET}\n"
    sleep 0.12

    # --- BANNER DRAWING ---
    # Figlet/Toilet available nahi hone par ab FALLBACK (Original Banner) use hoga.
    BANNER="$(build_banner_text LINUX)"
    IFS=$'\n' read -rd '' -a LINES <<<"$BANNER" || true

    cols=$(get_cols)
    box_width=0
    for l in "${LINES[@]}"; do [ ${#l} -gt $box_width ] && box_width=${#l}; done
    box_pad=6
    total_width=$((box_width + box_pad))
    left_pad=0
    [ "$CENTER_TEXT" -eq 1 ] && left_pad=$(( (cols - total_width) / 2 ))
    [ $left_pad -lt 0 ] && left_pad=0

    # Draw border and banner
    printf "%b" "$(printf '%*s' $left_pad '')"; printf "%b" "$(fg 39)╔"; for ((i=0;i<total_width-2;i++)); do printf "═"; done; printf "╗${RESET}\n"
    for i in "${!LINES[@]}"; do
      line="${LINES[$i]}"
      padding_left=$(( (total_width - ${#line}) / 2 - 1 ))
      padding_right=$(( total_width - ${#line} - padding_left - 2 ))
      printf "%b" "$(printf '%*s' $left_pad '')"; printf "%b" "$(fg 240)║${RESET} "
      # Agar FALLBACK ASCII art hai toh type_line_colored use mat karo, seedha print karo
      if [ "$BANNER" = "$FALLBACK" ]; then
          printf "%b\n" "$line"
      else
          type_line_colored "$(printf '%*s' $padding_left '')${line}$(printf '%*s' $padding_right '')" $((i*2))
      fi
      printf "%b" "$(printf '%*s' $left_pad '')"; printf "%b" "$(fg 240)║${RESET}\n"
    done
    printf "%b" "$(printf '%*s' $left_pad '')"; printf "%b" "$(fg 226)╚"; for ((i=0;i<total_width-2;i++)); do printf "═"; done; printf "╝${RESET}\n"
    sleep $BANNER_DELAY

    # Footer
    footer_lines=(
      "$(fg 82)⟡${RESET} ${BOLD}Host:${RESET} Termux on Android"
      "$(fg 154)⚙${RESET} ${BOLD}Mode:${RESET} $(uname -o 2>/dev/null || echo 'Android')"
      "$(fg 39)★${RESET} ${BOLD}Owner:${RESET} $OWNER_NAME"
      "$(fg 202)🐱${RESET} ${BOLD}GitHub:${RESET} $GITHUB_LINK"
      "$(fg 46)💬${RESET} ${BOLD}WhatsApp Channel:${RESET} $WHATSAPP_CHANNEL"
      "${DIM}This is a decorative banner — use responsibly.${RESET}"
    )
    for f in "${footer_lines[@]}"; do center_line "$f"; done
    printf "\n"

    # --- SHOW MAIN MENU ---
    main_menu
    
    # --- AFTER MENU EXIT ---
    if command -v am >/dev/null 2>&1 && [ -n "$WHATSAPP_CHANNEL" ]; then
      printf "\n%b" "${BOLD}${UNDER}Opening WhatsApp channel...${RESET}\n"
      am start -a android.intent.action.VIEW -d "$WHATSAPP_CHANNEL" 2>/dev/null || true
    fi
    
    # Start the fancy prompt
    interactive_prompt
fi

# The final 'clear' at the end of the full script will still run.
clear
# Script khatam
