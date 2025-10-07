#!/data/data/com.termux/files/usr/bin/bash
# ===============================
# RAJA Termux Toolkit with BRAVO banner & styling
# ===============================
DB="$HOME/.termux_toolkit_db"

# -------------------
# Create DB with 20 entries if not exists
# -------------------
if ! [[ -f "$DB" ]]; then
cat > "$DB" <<'DB'
1|Lazymux|url|https://github.com/Gameye98/Lazymux.git|GIFTED BY RAJA FOR BRAVO
2|Termux API|url|https://github.com/termux/termux-api|GIFTED BY RAJA FOR BRAVO
3|Termux Widget|url|https://github.com/termux/termux-widget|GIFTED BY RAJA FOR BRAVO
4|Termux Tasker|url|https://github.com/termux/termux-tasker|GIFTED BY RAJA FOR BRAVO
5|Termux Boot|url|https://github.com/termux/termux-boot|GIFTED BY RAJA FOR BRAVO
6|Termux Styling|url|https://github.com/termux/termux-styling|GIFTED BY RAJA FOR BRAVO
7|Termux API|url|https://github.com/termux/termux-api|GIFTED BY RAJA FOR BRAVO
8|Termux Widget|url|https://github.com/termux/termux-widget|GIFTED BY RAJA FOR BRAVO
9|Termux Tasker|url|https://github.com/termux/termux-tasker|GIFTED BY RAJA FOR BRAVO
10|Termux Boot|url|https://github.com/termux/termux-boot|GIFTED BY RAJA FOR BRAVO
11|Termux Styling|url|https://github.com/termux/termux-styling|GIFTED BY RAJA FOR BRAVO
12|Termux API|url|https://github.com/termux/termux-api|GIFTED BY RAJA FOR BRAVO
13|Termux Widget|url|https://github.com/termux/termux-widget|GIFTED BY RAJA FOR BRAVO
14|Termux Tasker|url|https://github.com/termux/termux-tasker|GIFTED BY RAJA FOR BRAVO
15|Termux Boot|url|https://github.com/termux/termux-boot|GIFTED BY RAJA FOR BRAVO
16|Termux Styling|url|https://github.com/termux/termux-styling|GIFTED BY RAJA FOR BRAVO
17|Termux API|url|https://github.com/termux/termux-api|GIFTED BY RAJA FOR BRAVO
18|Termux Widget|url|https://github.com/termux/termux-widget|GIFTED BY RAJA FOR BRAVO
19|Termux Tasker|url|https://github.com/termux/termux-tasker|GIFTED BY RAJA FOR BRAVO
20|Termux Boot|url|https://github.com/termux/termux-boot|GIFTED BY RAJA FOR BRAVO
DB
fi

# -------------------
# Colors
# -------------------
RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLUE="\e[94m"
MAGENTA="\e[95m"
CYAN="\e[96m"
RESET="\e[0m"
BOLD="\e[1m"

# -------------------
# Animated Loading
# -------------------
loading() {
    echo -ne "$CYAN$1"
    for i in {1..3}; do
        echo -ne "."
        sleep 0.3
    done
    echo -e "$RESET"
}

# -------------------
# BRAVO Banner Function (Rainbow effect)
# -------------------
show_banner() {
clear
echo -e "${CYAN}██████╗ ██████╗  █████╗ ██╗   ██╗ ██████╗ "
echo -e "${BLUE}██╔══██╗██╔══██╗██╔══██╗██║   ██║██╔═══██╗"
echo -e "${MAGENTA}██████╔╝██████╔╝███████║██║   ██║██║   ██║"
echo -e "${YELLOW}██╔══██╗██╔══██╗██╔══██║╚██╗ ██╔╝██║   ██║"
echo -e "${GREEN}██████╔╝██║  ██║██║  ██║ ╚████╔╝ ╚██████╔╝"
echo -e "${RED}╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝   ╚═════╝ "
echo -e "${BOLD}${CYAN}         WELCOME TO RAJA TOOLKIT          ${RESET}"
echo -e "${BOLD}${MAGENTA}             GIFT FOR BRAVO               ${RESET}"
echo -e "${CYAN}===========================================${RESET}"
echo
}

# -------------------
# List Entries (ID + Label only)
# -------------------
list_entries() {
    show_banner
    echo -e "${YELLOW}${BOLD}ID | LABEL${RESET}"
    echo -e "${CYAN}----------------------${RESET}"
    tail -n +2 "$DB" | while IFS='|' read -r id label type payload notes; do
        printf "${GREEN}%2s${RESET} | ${MAGENTA}%-20s${RESET}\n" "$id" "$label"
    done
    echo -e "${CYAN}----------------------${RESET}"
    read -p "Press ENTER to continue..."
}

# -------------------
# Open Entry by ID (show link after selection)
# -------------------
open_entry() {
    show_banner
    read -p "Enter ID to view/run: " id
    line=$(awk -F'|' -v id="$id" '$1==id {print; exit}' "$DB")
    if [[ -z "$line" ]]; then
        echo -e "${RED}ID not found.${RESET}"
        read -p "Press ENTER..."
        return
    fi
    IFS='|' read -r i label type payload notes <<< "$line"
    echo -e "${CYAN}Selected: ${BOLD}$label${RESET}"
    echo -e "${YELLOW}Link/Command: ${BLUE}$payload${RESET}"
    
    if [[ "$type" == "url" ]]; then
        read -p "Press ENTER to open this URL..." 
        loading "Opening URL"
        termux-open-url "$payload" 2>/dev/null || echo -e "${RED}Could not open URL${RESET}"
    else
        echo -e "${RED}Type '$type' not supported${RESET}"
    fi
    read -p "Press ENTER to return..."
}

# -------------------
# Add Entry
# -------------------
add_entry() {
    show_banner
    read -p "Enter label (name): " label
    echo -e "${YELLOW}Type 1=url${RESET}"
    read -p "Choose type: " t
    if [[ "$t" == "1" ]]; then type="url"; fi
    read -p "Enter payload (link/path/command): " payload
    nid=$(tail -n +2 "$DB" | awk -F'|' 'NF{print $1}' | sort -n | tail -1)
    nid=$((nid+1))
    printf "%s|%s|%s|%s|%s\n" "$nid" "$label" "$type" "$payload" "" >> "$DB"
    echo -e "${GREEN}Added entry ID=$nid${RESET}"
    read -p "Press ENTER..."
}

# -------------------
# Main Menu
# -------------------
while true; do
    show_banner
    echo -e "${MAGENTA}==== MENU ====${RESET}"
    echo -e "${CYAN}1) GIFTS LIST${RESET}"
    echo -e "${CYAN}2) Open entry by ID${RESET}"
    echo -e "${CYAN}3) Add entry${RESET}"
    echo -e "${CYAN}4) Quit${RESET}"
    echo -e "${MAGENTA}==============${RESET}"
    read -p "Choose: " choice
    case "$choice" in
        1) list_entries ;;
        2) open_entry ;;
        3) add_entry ;;
        4) echo -e "${RED}Goodbye!${RESET}"; exit 0 ;;
        *) echo -e "${RED}Invalid choice${RESET}"; sleep 1 ;;
    esac
done
