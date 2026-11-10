#!/bin/bash
# test_scripts.sh - regression smoke tests for the shellkit scripts
#
# Run from the repository root:
#   bash tests/test_scripts.sh
#
# These checks lock in behavior that should stay true before and after a
# typical one-file student fix. They do not grade every issue.

set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT" || exit 1

passed=0
failed=0

pass() {
  echo "PASS: $1"
  passed=$((passed + 1))
}

fail() {
  echo "FAIL: $1"
  failed=$((failed + 1))
}

assert_file() {
  local path="$1"
  if [ -f "$path" ]; then
    pass "found $path"
  else
    fail "missing $path"
  fi
}

assert_contains() {
  local haystack="$1"
  local needle="$2"
  local label="$3"
  if printf '%s' "$haystack" | grep -Fq -- "$needle"; then
    pass "$label"
  else
    fail "$label (expected to find: $needle)"
  fi
}

assert_matches() {
  local haystack="$1"
  local pattern="$2"
  local label="$3"
  if printf '%s' "$haystack" | grep -Eq -- "$pattern"; then
    pass "$label"
  else
    fail "$label (expected to match: $pattern)"
  fi
}

assert_exit_zero() {
  local status="$1"
  local label="$2"
  if [ "$status" -eq 0 ]; then
    pass "$label"
  else
    fail "$label (exit status $status)"
  fi
}

echo "Running shellkit smoke tests from $ROOT"
echo

# --- fixtures and scripts exist ------------------------------------------------

assert_file "data/sample.log"
assert_file "data/sample.txt"
assert_file "data/tasks.txt"
assert_file "data/.hidden-note.txt"
assert_file "data/blank.txt"
assert_file "data/example.txt"

if [ ! -s "data/blank.txt" ]; then
  pass "data/blank.txt is empty"
else
  fail "data/blank.txt should be empty"
fi

scripts=(
  backup.sh
  cleanup.sh
  commonwords.sh
  diskspace.sh
  emptyfiles.sh
  filecount.sh
  findlogs.sh
  greeting.sh
  hidden.sh
  largest.sh
  linecount.sh
  modified.sh
  permissions.sh
  sysinfo.sh
  wordcount.sh
)

for script in "${scripts[@]}"; do
  assert_file "scripts/$script"
done

# --- greeting.sh ---------------------------------------------------------------

greeting_out="$(USER=student bash scripts/greeting.sh)"
assert_contains "$greeting_out" "Hello, student!" "greeting.sh greets a set username"

# --- wordcount.sh --------------------------------------------------------------

expected_words="$(wc -w < data/sample.txt | tr -d '[:space:]')"
wordcount_out="$(bash scripts/wordcount.sh)"
wordcount_status=$?
assert_exit_zero "$wordcount_status" "wordcount.sh exits 0 when sample.txt has words"
assert_contains "$wordcount_out" "Words: $expected_words" "wordcount.sh reports the word count"

# --- findlogs.sh ---------------------------------------------------------------

findlogs_out="$(bash scripts/findlogs.sh)"
findlogs_status=$?
assert_exit_zero "$findlogs_status" "findlogs.sh exits 0"
assert_contains "$findlogs_out" "error: disk full" "findlogs.sh finds the lowercase error line"

# --- backup.sh -----------------------------------------------------------------

rm -rf backups
backup_out="$(bash scripts/backup.sh)"
backup_status=$?
assert_exit_zero "$backup_status" "backup.sh exits 0"
assert_contains "$backup_out" "Backup complete" "backup.sh prints Backup complete"
if [ -d backups ] && [ "$(find backups -type f | wc -l | tr -d '[:space:]')" -ge 1 ]; then
  pass "backup.sh creates a file under backups/"
else
  fail "backup.sh creates a file under backups/"
fi
rm -rf backups

# --- diskspace.sh --------------------------------------------------------------

diskspace_out="$(bash scripts/diskspace.sh)"
diskspace_status=$?
assert_exit_zero "$diskspace_status" "diskspace.sh exits 0"
assert_matches "$diskspace_out" 'Filesystem: .+' "diskspace.sh prints a Filesystem line"
assert_matches "$diskspace_out" 'Used: [0-9]+%' "diskspace.sh prints a Used percentage"

# --- filecount.sh --------------------------------------------------------------

filecount_out="$(bash scripts/filecount.sh)"
filecount_status=$?
assert_exit_zero "$filecount_status" "filecount.sh exits 0"
assert_matches "$filecount_out" '^Files: [0-9]+$' "filecount.sh prints Files: <number>"

# --- sysinfo.sh ----------------------------------------------------------------

sysinfo_out="$(bash scripts/sysinfo.sh)"
sysinfo_status=$?
assert_exit_zero "$sysinfo_status" "sysinfo.sh exits 0"
assert_matches "$sysinfo_out" 'Hostname: .+' "sysinfo.sh prints a Hostname line"
assert_matches "$sysinfo_out" 'Operating System: .+' "sysinfo.sh prints an Operating System line"

# --- permissions.sh ------------------------------------------------------------

permissions_out="$(bash scripts/permissions.sh)"
permissions_status=$?
assert_exit_zero "$permissions_status" "permissions.sh exits 0"
assert_matches "$permissions_out" 'scripts/.*\.sh: (executable|not executable)' \
  "permissions.sh reports executable status"
if printf '%s\n' "$permissions_out" | grep -Eqv 'scripts/.*\.sh: (executable|not executable)'; then
  fail "permissions.sh lines use the expected format"
else
  pass "permissions.sh lines use the expected format"
fi

# --- cleanup.sh ----------------------------------------------------------------

cleanup_out="$(./scripts/cleanup.sh 2>&1)"
cleanup_status=$?
assert_exit_zero "$cleanup_status" "cleanup.sh exits 0"
assert_contains "$cleanup_out" "Starting cleanup" "cleanup.sh prints Starting cleanup"
assert_contains "$cleanup_out" "Cleanup complete" "cleanup.sh prints Cleanup complete"

# --- largest.sh ----------------------------------------------------------------

largest_out="$(bash scripts/largest.sh)"
largest_status=$?
assert_exit_zero "$largest_status" "largest.sh exits 0"
if [ -n "$(printf '%s' "$largest_out" | tr -d '[:space:]')" ]; then
  pass "largest.sh prints at least one line"
else
  fail "largest.sh prints at least one line"
fi

# --- hidden.sh -----------------------------------------------------------------

hidden_out="$(bash scripts/hidden.sh)"
hidden_status=$?
assert_exit_zero "$hidden_status" "hidden.sh exits 0"
assert_contains "$hidden_out" "data/sample.txt" "hidden.sh lists data/sample.txt"

# --- emptyfiles.sh -------------------------------------------------------------

emptyfiles_status=0
bash scripts/emptyfiles.sh >/dev/null || emptyfiles_status=$?
assert_exit_zero "$emptyfiles_status" "emptyfiles.sh exits 0"

# --- modified.sh ---------------------------------------------------------------

modified_status=0
bash scripts/modified.sh >/dev/null || modified_status=$?
assert_exit_zero "$modified_status" "modified.sh exits 0"

# --- linecount.sh --------------------------------------------------------------

linecount_out="$(bash scripts/linecount.sh)"
linecount_status=$?
assert_exit_zero "$linecount_status" "linecount.sh exits 0"
assert_matches "$linecount_out" 'data/example\.txt: [0-9]+' \
  "linecount.sh reports a count for data/example.txt"

# --- commonwords.sh ------------------------------------------------------------

commonwords_out="$(bash scripts/commonwords.sh)"
commonwords_status=$?
assert_exit_zero "$commonwords_status" "commonwords.sh exits 0"
assert_matches "$commonwords_out" '[0-9]+[[:space:]]+[A-Za-z]+' \
  "commonwords.sh prints at least one count and word"

# --- summary -------------------------------------------------------------------

echo
echo "$passed passed, $failed failed"
if [ "$failed" -eq 0 ]; then
  exit 0
fi
exit 1
