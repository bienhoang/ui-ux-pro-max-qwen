#!/bin/sh
set -eu

# UI/UX Pro Max for Qwen Code — curl installer
# Usage: curl -fsSL https://raw.githubusercontent.com/bienhoang/ui-ux-pro-max-qwen/main/setup.sh | sh

REPO="bienhoang/ui-ux-pro-max-qwen"
BRANCH="main"
ARCHIVE_URL="https://github.com/${REPO}/archive/refs/heads/${BRANCH}.tar.gz"
INSTALL_DIR=".qwen"
VERIFY_FILE="${INSTALL_DIR}/skills/ui-ux-pro-max/SKILL.md"

# Colors (safe fallback if tput unavailable)
if command -v tput >/dev/null 2>&1 && tput colors >/dev/null 2>&1; then
  BLUE=$(tput setaf 4) GREEN=$(tput setaf 2) RED=$(tput setaf 1) RESET=$(tput sgr0)
else
  BLUE="" GREEN="" RED="" RESET=""
fi

info()    { printf '%s[info]%s %s\n' "$BLUE" "$RESET" "$1"; }
success() { printf '%s[ok]%s   %s\n' "$GREEN" "$RESET" "$1"; }
error()   { printf '%s[err]%s  %s\n' "$RED" "$RESET" "$1" >&2; exit 1; }

TMP_DIR=""
cleanup() {
  [ -n "${TMP_DIR:-}" ] && rm -rf "$TMP_DIR" || true
  # Restore backup if install failed mid-copy
  if [ -d "${INSTALL_DIR}.bak" ] && [ ! -d "$INSTALL_DIR" ]; then
    mv "${INSTALL_DIR}.bak" "$INSTALL_DIR"
  fi
}
trap cleanup EXIT

# --- Dependency checks ---
for cmd in curl tar; do
  command -v "$cmd" >/dev/null 2>&1 || error "$cmd is required but not installed."
done

if ! command -v python3 >/dev/null 2>&1; then
  printf '%s[err]%s  python3 is required but not installed.\n' "$RED" "$RESET" >&2
  echo ""
  echo "Install python3:"
  case "$(uname -s)" in
    Darwin*)  echo "  brew install python3" ;;
    Linux*)
      if [ -f /etc/debian_version ]; then
        echo "  sudo apt install python3"
      elif [ -f /etc/redhat-release ]; then
        echo "  sudo dnf install python3"
      else
        echo "  Use your package manager to install python3"
      fi ;;
    MINGW*|MSYS*|CYGWIN*) echo "  winget install Python.Python.3.12" ;;
    *) echo "  Install python3 from https://python.org" ;;
  esac
  exit 1
fi

# --- Download ---
info "Downloading UI/UX Pro Max for Qwen Code..."
TMP_DIR=$(mktemp -d)
curl -fsSL "$ARCHIVE_URL" -o "$TMP_DIR/repo.tar.gz"

# --- Extract ---
info "Extracting..."
tar xzf "$TMP_DIR/repo.tar.gz" -C "$TMP_DIR"

# Find the extracted directory (named <repo>-<branch>)
EXTRACTED=$(find "$TMP_DIR" -mindepth 1 -maxdepth 1 -type d | head -1)
[ -n "$EXTRACTED" ] || error "Archive extraction produced no directory."
[ -d "$EXTRACTED/${INSTALL_DIR}" ] || error "Archive does not contain ${INSTALL_DIR}/ directory."

# --- Install ---
if [ -d "$INSTALL_DIR" ]; then
  info "Replacing existing ${INSTALL_DIR}/..."
  mv "$INSTALL_DIR" "${INSTALL_DIR}.bak"
fi
cp -r "$EXTRACTED/${INSTALL_DIR}" "$INSTALL_DIR"
rm -rf "${INSTALL_DIR}.bak" 2>/dev/null || true

# --- Verify ---
if [ ! -f "$VERIFY_FILE" ]; then
  error "Installation verification failed: ${VERIFY_FILE} not found."
fi

# Quick search engine check
if ! python3 "${INSTALL_DIR}/skills/ui-ux-pro-max/scripts/search.py" "test" --domain style >/dev/null 2>&1; then
  printf '%s[err]%s  Search engine verification failed. Details:\n' "$RED" "$RESET" >&2
  python3 "${INSTALL_DIR}/skills/ui-ux-pro-max/scripts/search.py" "test" --domain style 2>&1 || true
  exit 1
fi

# --- Success ---
FILE_COUNT=$(find "$INSTALL_DIR" -type f | wc -l | tr -d ' ')
success "Installed ${FILE_COUNT} files to ${INSTALL_DIR}/"
echo ""
echo "Available commands:"
echo "  /design <query>      Generate a complete design system"
echo "  /ui-search <query>   Search the design database"
echo ""
echo "Restart Qwen Code to activate the skill."
