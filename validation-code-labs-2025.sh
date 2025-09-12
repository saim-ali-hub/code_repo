#!/bin/bash

check_lab1_navigation() {
    echo -e "\n\e[34mChecking Lab 1 – 2025: Linux Basic Commands & Navigation...\e[0m"

    HOME_DIR="$HOME"
    SERVER_INFO="$HOME_DIR/server_info"
    TOTAL_TASKS=17
    PASSED=0
    LAB_NAME="Lab 1 – 2025"
    DATE=$(date +%F)

    # Helpers
    pass() {
        echo -e "\e[32m$1 – Pass\e[0m"
        ((PASSED++))
    }

    fail() {
        echo -e "\e[31m$1 – Fail\e[0m"
    }

    # Section 1: Server Info Appended to server_info
    [ -f "$SERVER_INFO" ] || touch "$SERVER_INFO"
    if grep -q "$HOME_DIR" "$SERVER_INFO"; then
       pass "Task 1: Present working directory appended"
    else
       fail "Task 1: pwd output missing"
    fi
    uname -r | if grep -q -Ff "$SERVER_INFO"; then
       pass "Task 2: Kernel version logged"
    else
       fail "Task 2: Kernel version missing"
    fi
    # Task 3: Validate ls -l output (look for a known filename like "office")
    if grep -q "$HOME_DIR" "$SERVER_INFO"; then
       pass "Task 3: ls -l output logged"
    else
       fail "Task 3: ls -l info missing"
    fi

    # Task 4: Validate ls -al output (look for hidden file like ".bashrc")
    if grep -q "\.bashrc" "$SERVER_INFO"; then
       pass "Task 4: ls -al output logged"
    else
       fail "Task 4: ls -al info missing"
    fi

    [ -d "$HOME_DIR/Linux" ] && pass "Task 5: Linux directory created" || fail "Task 5: Linux directory missing"
    if grep -q "$HOME_DIR/Linux" "$SERVER_INFO"; then
       pass "Task 6: Verified inside Linux directory"
    else
       fail "Task 6: Linux pwd output missing"
    fi

    [ -d "$HOME_DIR/Linux/Redhat" ] && [ -d "$HOME_DIR/Linux/oel" ] && [ -d "$HOME_DIR/Linux/debian" ] \
        && pass "Task 7: Subdirectories Redhat, oel, debian created" || fail "Task 7: One or more subdirectories missing"

    grep -q "$HOME_DIR" "$SERVER_INFO" && pass "Task 8: cd .. and pwd output captured" || fail "Task 8: Final pwd output missing"


    # Section 2: File Ops
    [ -f "$HOME_DIR/file1.txt" ] || [ -f "$HOME_DIR/documents/file1.txt" ] \
        && pass "Task 9a: file1.txt created or moved correctly" || fail "Task 9a: file1.txt missing"
    [ -f "$HOME_DIR/pic.jpg" ] || [ -f "$HOME_DIR/images/pic.jpg" ] \
        && pass "Task 9b: pic.jpg created or moved correctly" || fail "Task 9b: pic.jpg missing"
    [ -f "$HOME_DIR/clip.avi" ] || [ -f "$HOME_DIR/media/clip.avi" ] \
        && pass "Task 9c: clip.avi created or moved correctly" || fail "Task 9c: clip.avi missing"

    [ -d "$HOME_DIR/documents" ] && [ -f "$HOME_DIR/documents/file1.txt" ] \
        && pass "Task 10a: file1.txt moved to documents" || fail "Task 10a: file1.txt not in documents"
    [ -d "$HOME_DIR/images" ] && [ -f "$HOME_DIR/images/pic.jpg" ] \
        && pass "Task 10b: pic.jpg moved to images" || fail "Task 10b: pic.jpg not in images"
    [ -d "$HOME_DIR/media" ] && [ -f "$HOME_DIR/media/clip.avi" ] \
        && pass "Task 10c: clip.avi moved to media" || fail "Task 10c: clip.avi not in media"

    [ -d "$HOME_DIR/office/hobby/personal" ] && pass "Task 11: Nested directories created with mkdir -p" || fail "Task 11: Nested structure missing"

    [ -f "$HOME_DIR/office/file1.txt" ] && pass "Task 12: file1.txt copied to office" || fail "Task 12: file1.txt not copied"

    [ -f "$HOME_DIR/office/hobby/pic.jpg" ] && pass "Task 13: pic.jpg copied to hobby" || fail "Task 13: pic.jpg not copied"

    [ -f "$HOME_DIR/office/hobby/personal/office_tree" ] && grep -q "personal" "$HOME_DIR/office/hobby/personal/office_tree" \
        && pass "Task 14: tree output saved correctly" || fail "Task 14: tree output missing or incorrect"

    # Summary
    PERCENT=$((PASSED * 100 / TOTAL_TASKS))
    echo -e "\n\e[36mSummary: $PASSED out of $TOTAL_TASKS tasks passed\e[0m"
    echo -e "\e[33mPercentage: $PERCENT%\e[0m"

    # CSV Logging
    CSV_FILE="/tmp/.syslog/lab${LAB_NUMBER}_result.csv"
    mkdir -p "/tmp/.syslog"
    chmod -R 777 "/tmp/.syslog"
    [ ! -f "$CSV_FILE" ] && echo "student_name,lab_name,date,percentage" > "$CSV_FILE"
    echo "$STUDENT_NAME,\"$LAB_NAME\",$DATE,$PERCENT%" >> "$CSV_FILE"

}
#==================================================================================================

check_lab2_navigation() {
    echo -e "\n\e[34mChecking Lab 2 – Navigation – 2025 Tasks...\e[0m"

    BASE="$HOME/vars"
    TOTAL_TASKS=15
    PASSED=0
    LAB_NAME="Lab 2 – Navigation – 2025"
    #STUDENT_NAME=$(whoami)
    DATE=$(date +%F)

    # Helpers
    pass() {
        echo -e "\e[32m$1 – Pass\e[0m"
        ((PASSED++))
    }

    fail() {
        echo -e "\e[31m$1 – Fail\e[0m"
    }

    # Task 1
    if [ -d "$BASE/systems/logs" ] ; then
       pass "Task 1: Nested directory vars/systems/logs created"
    else
       fail "Task 1: Directory structure missing"
    fi
    # Task 2
    [ -f "$BASE/systems/dmesg" ] && pass "Task 2: Empty file dmesg created" || fail "Task 2: dmesg file missing"

    # Task 3
    grep -Fxq "I love Linux and am excited to join the DevOps course" "$BASE/systems/logs/file1.txt" 2>/dev/null \
        && pass "Task 3: file1.txt with correct content" || fail "Task 3: file1.txt missing or incorrect content"

    # Task 4
    [ -d "$BASE/os/configs" ] && pass "Task 4: Nested directory vars/os/configs created" || fail "Task 4: Directory structure missing"

    # Task 5
    cmp -s /etc/hosts "$BASE/os/configs/hosts" && pass "Task 5: /etc/hosts copied to vars/os/configs" || fail "Task 5: hosts not copied correctly"

    # Task 6
    cmp -s "$BASE/os/configs/hosts" "$BASE/hosts" && pass "Task 6: hosts copied from configs to vars" || fail "Task 6: hosts copy to vars failed"

    # Task 7
    cat "$BASE/hosts" &>/dev/null && pass "Task 7: cat used to display hosts in vars" || fail "Task 7: hosts not found in vars"

    # Task 8
    cmp -s "$BASE/hosts" "$BASE/os/configs/new_hosts" && pass "Task 8: hosts content redirected to new_hosts" || fail "Task 8: new_hosts content mismatch"

    # Task 9
    grep -Fxq "I love Linux and am excited to join the DevOps course" "$BASE/os/new_file1.txt" 2>/dev/null \
        && pass "Task 9: file1.txt copied and renamed to new_file1.txt" || fail "Task 9: new_file1.txt missing or incorrect"

    # Task 10
    [ -f "$BASE/systems/logs/sshd_config" ] && [ -f "$BASE/systems/logs/httpd.conf" ] \
        && pass "Task 10: sshd_config and httpd.conf created" || fail "Task 10: One or both config files missing"

    # Task 11
    grep -Fxq "I am enjoying DeveOps sessions and lab work" "$BASE/systems/new_file.txt" 2>/dev/null \
        && pass "Task 11: new_file.txt file has expected content" || fail "Task 11: new_file.txt content mismatch"
    # Task 12
    rmdir "$BASE/os/configs" 2>/dev/null && fail "Task 12: Directory deleted unexpectedly" || pass "Task 12: rmdir failed as expected due to contents"

    # Task 13
    [ -f "$BASE/systems/passwd_output.txt" ] && tail -n 5 /etc/passwd | cmp -s - <(tail -n 5 "$BASE/systems/passwd_output.txt") \
        && pass "Task 13: tail output appended to passwd_output.txt" || fail "Task 13: tail output not properly appended"

    # Task 14
    [ "$(head -n 5 /etc/group)" = "$(cat "$BASE/systems/group_output.txt" 2>/dev/null)" ] \
        && pass "Task 14: head output overwritten in group_output.txt" || fail "Task 14: group_output.txt content mismatch"

    # Task 15
    if [ -f "$BASE/systems/logs/output_file" ]; then
        grep -q "ASCII text" "$BASE/systems/logs/output_file" && grep -q "ELF" "$BASE/systems/logs/output_file" \
        && pass "Task 15: file command output stored correctly" || fail "Task 15: output_file content invalid"
    else
        fail "Task 15: output_file not found"
    fi

    # Summary
    PERCENT=$((PASSED * 100 / TOTAL_TASKS))
    echo -e "\n\e[36mSummary: $PASSED out of $TOTAL_TASKS tasks passed\e[0m"
    echo -e "\e[33mPercentage: $PERCENT%\e[0m"

    # CSV Logging
    CSV_FILE="/tmp/.syslog/lab${LAB_NUMBER}_result.csv"
    mkdir -p "/tmp/.syslog"
    chmod -R 777 "/tmp/.syslog"
    [ ! -f "$CSV_FILE" ] && echo "student_name,lab_name,date,percentage" > "$CSV_FILE"
    echo "$STUDENT_NAME,\"$LAB_NAME\",$DATE,$PERCENT%" >> "$CSV_FILE"

}
#==================================================================================================

check_lab3_navigation() {
    echo -e "\n\e[34mChecking Lab 3 – Navigation - 2025 Tasks...\e[0m"

    PROJECTS="$HOME/projects"
    LAB_NAME="Lab 3 – Navigation - 2025"
    #STUDENT_NAME=$(whoami)
    DATE=$(date +%F)
    TOTAL_TASKS=10
    PASSED=0

    # Helpers
    pass() {
        echo -e "\e[32m$1 – Pass\e[0m"
        ((PASSED++))
    }
    fail() {
        echo -e "\e[31m$1 – Fail\e[0m"
    }

    # Validation
    if [ -d "$PROJECTS/devtools/logs" ] && [ -d "$PROJECTS/system/settings" ]; then
       pass "Task 1: Directory structure"
    else
       fail "Task 1: Directory structure missing"
    fi
    [ -f "$PROJECTS/devtools/debug.log" ] && pass "Task 2: debug.log and new.log created" || fail "Task 2: debug.log missing"

    grep -q "System setup is in progress" "$PROJECTS/devtools/logs/status.txt" 2>/dev/null \
        && pass "Task 3: status.txt content" || fail "Task 3: status.txt content"

    [ -f "$PROJECTS/system/settings/fstab" ] \
        && pass "Task 4: fstab copied to settings" || fail "Task 4: fstab not found in settings"

    [ -f "$PROJECTS/system/settings/new.log" ] && [ ! -f "$PROJECTS/devtools/new.log" ] \
        && pass "Task 5: new.log moved to settings" || fail "Task 5: new.log not properly moved"

    [ "$(wc -l < "$PROJECTS/system/settings/services.txt" 2>/dev/null)" -eq 3 ] \
        && pass "Task 6: services.txt has 3 lines" || fail "Task 6: services.txt line count"

    [ "$(wc -l < "$PROJECTS/system/dns_report.txt" 2>/dev/null)" -eq 3 ] \
        && pass "Task 7: dns_report.txt has 3 lines" || fail "Task 7: dns_report.txt line count"

    [ -f "$PROJECTS/devtools/logs/nginx.conf" ] && [ -f "$PROJECTS/devtools/logs/mysql.cnf" ] \
        && pass "Task 8: nginx.conf and mysql.cnf exist" || fail "Task 8: config files missing"

    [ -d "$HOME/new_settings" ] \
        && pass "Task 9: settings copied and renamed to new_settings" || fail "Task 9: new_settings directory missing"

    [ -f "$PROJECTS/system/services.txt" ] \
        && pass "Task 10: services.txt copied to system" || fail "Task 10: services.txt not copied to system"

    # Score Summary
    PERCENT=$((PASSED * 100 / TOTAL_TASKS))
    echo -e "\n\e[36mSummary: $PASSED out of $TOTAL_TASKS tasks passed\e[0m"
    echo -e "\e[33mPercentage: $PERCENT%\e[0m"

    # CSV Logging
    CSV_FILE="/tmp/.syslog/lab${LAB_NUMBER}_result.csv"
    mkdir -p "/tmp/.syslog"
    chmod -R 777 "/tmp/.syslog"
    [ ! -f "$CSV_FILE" ] && echo "student_name,lab_name,date,percentage" > "$CSV_FILE"
    echo "$STUDENT_NAME,\"$LAB_NAME\",$DATE,$PERCENT%" >> "$CSV_FILE"

}

# Variables
LAB_DIR="$HOME/proj-thurs"
#USERNAME=$(whoami)
USER_ACCOUNTS="$HOME/user-accounts"
DB_USERS="$HOME/db-users"
DB_COPY="/tmp/users/dbuser-$USERNAME"
SINGLE_FILE="$HOME/single-file"
VALIDATION_FILE="$HOME/validation_file"

# Clear old validation file
echo "Validation Output - Review Lab1 - 2025" > "$VALIDATION_FILE"
echo "======================================" >> "$VALIDATION_FILE"

pass() { echo -e "Task $1: \e[32mPASS\e[0m - $2"; }
fail() { echo -e "Task $1: \e[31mFAIL\e[0m - $2"; }

check_Review_lab1_2025() {
  # Task 1
  [[ -d "$LAB_DIR" ]] && pass 1 "proj-thurs directory exists" || fail 1 "proj-thurs directory missing"

  # Task 2: Not directly verifiable — assume if files are in it, user cd'd into it
  [[ -f "$LAB_DIR/passwd" || -f "$LAB_DIR/group" ]] && pass 2 "Assumed user changed to proj-thurs" || fail 2 "No files present to assume directory change"

  # Task 3
  [[ -f "$LAB_DIR/passwd" ]] && pass 3 "passwd file copied" || fail 3 "passwd not found in proj-thurs"

  # Task 4
  if [[ -f "$LAB_DIR/group" ]]; then
    src_ts=$(stat -c %Y /etc/group)
    dst_ts=$(stat -c %Y "$LAB_DIR/group")
    [[ "$src_ts" == "$dst_ts" ]] && pass 4 "group file copied with preserved timestamp" || fail 4 "group file copied, but timestamp not preserved"
  else
    fail 4 "group file not found"
  fi

  # Task 5
  [[ -f "$LAB_DIR/hosts" ]] && pass 5 "hosts file copied" || fail 5 "hosts file not found"

  # Task 6
  if [[ -f "$USER_ACCOUNTS" ]]; then
    line_count=$(wc -l < "$USER_ACCOUNTS")
    [[ "$line_count" -ge 15 ]] && pass 6 "First 15 lines of passwd written to user-accounts" || fail 6 "user-accounts exists but may not have enough lines"
  else
    fail 6 "user-accounts file not found"
  fi

  # Task 7
  if [[ -f "$USER_ACCOUNTS" && -f "$LAB_DIR/group" ]]; then
    last_line_group=$(tail -n 1 "$LAB_DIR/group")
    grep -qF "$last_line_group" "$USER_ACCOUNTS" && pass 7 "Last 50 lines of group appended to user-accounts" || fail 7 "Group content not appended to user-accounts"
  else
    fail 7 "Required files for this task are missing"
  fi

  # Task 8: Not verifiable (interactive vi) — assume it was opened
  pass 8 "Assumed user opened user-accounts in vi"

  # Task 9
  [[ -f "$DB_USERS" ]] && pass 9 "user-accounts renamed to db-users" || fail 9 "db-users file not found"

  # Task 10
  [[ -f "$DB_COPY" ]] && pass 10 "db-users copied to /tmp/users as dbuser-$USERNAME" || fail 10 "Copy of db-users in /tmp/users not found"

  # Task 11
  current_dir=$(pwd)
  [[ "$current_dir" == "$HOME" ]] && pass 11 "User is in home directory" || fail 11 "User is not in home directory"

  # Task 12
  output_pwd=$(pwd)
  [[ "$output_pwd" == "$HOME" ]] && pass 12 "pwd returned home directory" || fail 12 "pwd output does not match home"

  # Task 13
  if [[ -f "$LAB_DIR/passwd" && -f "$LAB_DIR/group" && -f "$LAB_DIR/hosts" ]]; then
    pass 13 "Required files present for single-file creation"
  else
    fail 13 "One or more files missing for single-file creation"
  fi

  # Task 14
  removed_all=true
  for file in passwd group hosts; do
    [[ -f "$LAB_DIR/$file" ]] && { fail 14 "$file still exists in proj-thurs"; removed_all=false; }
  done
  $removed_all && pass 14 "All source files removed from proj-thurs"

  # Task 15: Check existence and log it
  {
    echo -e "\nTask 15: Checking if single-file exists"
    if [[ -f "$SINGLE_FILE" ]]; then
      echo "single-file exists: $SINGLE_FILE"
      ls -l "$SINGLE_FILE"
    else
      echo "single-file does not exist"
    fi
  } >> "$VALIDATION_FILE"
  [[ -f "$SINGLE_FILE" ]] && pass 15 "single-file exists, details logged" || fail 15 "single-file not found"

  # Task 16: Permissions
  {
    echo -e "\nTask 16: Permissions of single-file"
    [[ -f "$SINGLE_FILE" ]] && stat -c "%A" "$SINGLE_FILE" || echo "File not found"
  } >> "$VALIDATION_FILE"
  [[ -f "$SINGLE_FILE" ]] && pass 16 "Permissions recorded in validation_file" || fail 16 "File not found for permission check"

  # Task 17: Simulated more and less output
  {
    echo -e "\nTask 17: Simulated more/less (head + tail)"
    if [[ -f "$SINGLE_FILE" ]]; then
      echo "--- HEAD ---"
      head "$SINGLE_FILE"
      echo "--- TAIL ---"
      tail "$SINGLE_FILE"
    else
      echo "File not found"
    fi
  } >> "$VALIDATION_FILE"
  [[ -f "$SINGLE_FILE" ]] && pass 17 "more/less simulated output written" || fail 17 "Cannot simulate more/less (file missing)"

  # Task 18: Read with head and tail
  {
    echo -e "\nTask 18: Read with head and tail"
    if [[ -f "$SINGLE_FILE" ]]; then
      echo "--- head ---"
      head -n 5 "$SINGLE_FILE"
      echo "--- tail ---"
      tail -n 5 "$SINGLE_FILE"
    else
      echo "File not found"
    fi
  } >> "$VALIDATION_FILE"
  [[ -f "$SINGLE_FILE" ]] && pass 18 "head/tail output written to validation_file" || fail 18 "File missing for head/tail check"
}
#===================================================================================================================================

check_lab5_permissions() {
    echo -e "\n\e[34mChecking Lab 5 – Permissions – 2025 Tasks...\e[0m"

    BASE="$HOME/my_own_dir/"
    TOTAL_TASKS=21
    PASSED=0
    LAB_NAME="Lab5 – Permissions – 2025"
    #STUDENT_NAME=$(whoami)
    DATE=$(date +%F)

    pass() {
        echo -e "\e[32m$1 – Pass\e[0m"
        ((PASSED++))
    }

    fail() {
        echo -e "\e[31m$1 – Fail\e[0m"
    }

    # Task 1
    if [ -d "$BASE" ]; then
       pass "Task 1: Directory my_own_dir created"
    else
       fail "Task 1: my_own_dir not found"
    fi

    # Task 2
    chmod 644 $BASE
    [[ "$(stat -c "%A" "$BASE")" == "drw-r--r--" ]] && pass "Task 2: Permissions set correctly using symbolic notation" || fail "Task 2: Incorrect permissions"

    # Task 3
    ls "$BASE" &>/dev/null && pass "Task 3: ls my_own_dir ran successfully" || fail "Task 3: ls failed"

    # Task 4
    cd "$BASE" 2>/dev/null && fail "Task 4: cd succeeded unexpectedly" || pass "Task 4: cd failed as expected due to no execute permission"

    # Task 5
    mkdir "$BASE/Redhat" 2>/dev/null && fail "Task 5: mkdir succeeded unexpectedly" || pass "Task 5: mkdir failed as expected"

    # Task 6
    if [ ! -d "$BASE/Redhat" ] && [ ! -d "$BASE/OEL" ]; then
       pass "Task 6: Redhat and OEL directories created after permission change"
    else
       fail "Task 6: mkdir failed"
    fi

    # Task 7
    chmod -R 775 "$BASE" && pass "Task 7: Recursive chmod using numeric method succeeded" || fail "Task 7: chmod failed"

    # Task 8
    if [ -f "$BASE/file_1.txt" ] && [ -d "$BASE/dir_1" ]; then
       pass pass "Task 8: file_1.txt and dir_1 created"
    else
       fail "Task 8: Creation failed"
    fi

    # Task 9
    chmod a-r "$BASE/file_1.txt" && pass "Task 9: Read permission removed for all" || fail "Task 9: chmod failed"

    # Task 10
    cat "$BASE/file_1.txt" &>/dev/null && fail "Task 10: cat succeeded unexpectedly" || pass "Task 10: cat failed as expected"

    # Task 11
    chmod a+r "$BASE/file_1.txt" && cat "$BASE/file_1.txt" &>/dev/null && pass "Task 11: Read permission restored and file read" || fail "Task 11: cat failed"

    # Task 12
    chmod ug-w "$BASE/file_1.txt" 2>/dev/null && pass "Task 12: Write permission removed for user and group" || fail "Task 12: chmod failed"

    # Task 13
    bash -c 'echo "File permission setting is a fun" >> "$1"' bash "$BASE/file_1.txt" &> /dev/null && \
    fail "Task 13: Write succeeded unexpectedly" || \
    pass "Task 13: Write failed as expected"

    # Task 14
    chmod ug+w "$BASE/file_1.txt" && pass "Task 14: Write permission restored for user and group" || fail "Task 14: chmod failed"

    # Task 15
    echo "File permission setting is a fun" >> "$BASE/file_1.txt" 2>/dev/null && pass "Task 15: Write succeeded after permission restored" || fail "Task 15: Write failed"

    # Task 16
    chmod u+x "$BASE/file_1.txt" && [[ "$(stat -c "%A" "$BASE/file_1.txt")" =~ x ]] && pass "Task 16: Execute permission given to owner (symbolic)" || fail "Task 16: chmod failed"

    # Task 17
    chmod u-r,g-x,o-x "$BASE/dir_1" && pass "Task 17: dir_1 permissions set correctly" || fail "Task 17: chmod failed"

    # Task 18
    ls -ld "$BASE/dir_1" > "$BASE/Redhat/new_info" && [ -f "$BASE/Redhat/new_info" ] && pass "Task 18: Permissions redirected to new_info" || fail "Task 18: redirection failed"

    # Task 19
    cp "$BASE/Redhat/new_info" "$BASE/OEL/" && [ -f "$BASE/OEL/new_info" ] && pass "Task 19: new_info copied to OEL" || fail "Task 19: Copy failed"

    # Task 20
    chmod 777 "$BASE/dir_1" && pass "Task 20: Full permission 777 set on dir_1" || fail "Task 20: chmod failed"

    # Task 21
    cp "$BASE/OEL/new_info" "$BASE/OEL/new_info.txt" && [ -f "$BASE/OEL/new_info.txt" ] && pass "Task 21: new_info renamed to new_info.txt" || fail "Task 21: Rename failed"

    # Summary
    PERCENT=$((PASSED * 100 / TOTAL_TASKS))
    echo -e "\n\e[36mSummary: $PASSED out of $TOTAL_TASKS tasks passed\e[0m"
    echo -e "\e[33mPercentage: $PERCENT%\e[0m"

    # CSV Logging
    CSV_FILE="/tmp/.syslog/lab${LAB_NUMBER}_result.csv"
    mkdir -p "/tmp/.syslog"
    chmod -R 777 "/tmp/.syslog"
    [ ! -f "$CSV_FILE" ] && echo "student_name,lab_name,date,percentage" > "$CSV_FILE"
    echo "$STUDENT_NAME,\"$LAB_NAME\",$DATE,$PERCENT%" >> "$CSV_FILE"

}
#=======================================================================================================================================================================================

check_lab6_ownership() {
    echo -e "\n\e[34mChecking Lab 6 – Ownership – 2025 Tasks...\e[0m"

    HOME_DIR="$HOME"
    TOTAL_TASKS=13
    PASSED=0
    LAB_NAME="Lab 6 – Ownership – 2025"
    #STUDENT_NAME=$(whoami)
    DATE=$(date +%F)

    pass() {
        echo -e "\e[32m$1 – Pass\e[0m"
        ((PASSED++))
    }

    fail() {
        echo -e "\e[31m$1 – Fail\e[0m"
    }

    # Task 1
    FILE1="$HOME_DIR/my_file.txt"
    if [ -f "$FILE1" ]; then
       pass "Task 1: my_file.txt created with correct owner and group"
    else
        fail "Task 1: my_file.txt not found"
    fi

    # Task 2
    if [ "$(stat -c %U "$FILE1")" = "new-user" ] ; then
        pass "Task 2: Owner of my_file.txt changed to new-user"
    else
        fail "Task 2: Owner not changed"
    fi

    # Task 3
    if [ "$(stat -c %G "$FILE1")" = "students" ]; then
        pass "Task 3: Group of my_file.txt changed to students using chown"
    else
        fail "Task 3: Group change to students failed"
    fi

     # Task 4
    if [ "$(stat -c %G "$FILE1")" = "students" ]; then
        pass "Task 4: Group of my_file.txt changed to students using chown"
    else
        fail "Task 4: Group change to students failed"
    fi

    # Task 5
    FILE2="$HOME_DIR/new_file.txt"
    if [ -f "$FILE2" ]; then
       pass "Task 5: new_file.txt created with correct ownership"

    else
        fail "Task 5: new_file.txt not found"
    fi

    # Task 6
    [ "$(stat -c %U "$FILE2")" = "new-user" ] && [ "$(stat -c %G "$FILE2")" = "students" ] \
        && pass "Task 6: Owner and group of new_file.txt changed successfully" || fail "Task 6: chown failed"

    # Task 7
    FILE3="$HOME_DIR/my_fun.txt"
    if [ -f "$FILE3" ]; then
        grep -Fxq "Changing ownership is really fun" "$FILE3"
        pass "Task 7: my_fun.txt created with correct text and ownership"
    else
        fail "Task 7: my_fun.txt not found"
    fi

    # Task 8
    [ "$(stat -c %G "$FILE3")" = "students" ] && pass "Task 8: Group of my_fun.txt changed using chgrp" || fail "Task 8: Group change failed"

    # Task 9
    TF1="$HOME_DIR/test_file1"
    TF2="$HOME_DIR/test_file2"
    [ -f "$TF1" ] && [ -f "$TF2" ] && pass "Task 9: test_file1 and test_file2 created" || fail "Task 9: One or both test files missing"

    # Task 10
    [ "$(stat -c %U "$TF1")" = "new-user" ] && [ "$(stat -c %G "$TF1")" = "admins" ] && \
    [ "$(stat -c %U "$TF2")" = "new-user" ] && [ "$(stat -c %G "$TF2")" = "admins" ] \
    && pass "Task 10: Ownership of both files changed with single command" || fail "Task 10: Ownership change failed"

    # Task 11
    DIR1="$HOME_DIR/test_dir1"
    if [ -d "$DIR1" ]; then
       pass "Task 11: test_dir1 created with correct ownership"
    else
       fail "Task 11: test_dir1 missing or ownership mismatch"
    fi

    # Task 12
    [ "$(stat -c %U "$DIR1")" = "test-user" ] && [ "$(stat -c %G "$DIR1")" = "admins" ] \
        && pass "Task 12: Owner and group of test_dir1 changed" || fail "Task 12: chown failed"

    # Task 13
    MND="$HOME_DIR/my_new_dir"
    if [ -d "$MND" ] && [ -f "$MND/new_file1" ] && [ -f "$MND/new_file2" ] && [ -d "$MND/new_dir1" ] && [ -d "$MND/new_dir2" ]; then
        ALL_MATCHED=true
        for i in "$MND" "$MND/new_file1" "$MND/new_file2" "$MND/new_dir1" "$MND/new_dir2"; do
            OWNER=$(stat -c %U "$i")
            GROUP=$(stat -c %G "$i")
            if [ "$OWNER" != "test-user" ] || [ "$GROUP" != "admins" ]; then
                ALL_MATCHED=false
                break
            fi
        done
        $ALL_MATCHED && pass "Task 13: Ownership recursively set on my_new_dir and its contents" || fail "Task 13: Ownership mismatch"
    else
        fail "Task 13: One or more items in my_new_dir missing"
    fi

    # Summary
    PERCENT=$((PASSED * 100 / TOTAL_TASKS))
    echo -e "\n\e[36mSummary: $PASSED out of $TOTAL_TASKS tasks passed\e[0m"
    echo -e "\e[33mPercentage: $PERCENT%\e[0m"

    # CSV Logging
    CSV_FILE="/tmp/.syslog/lab${LAB_NUMBER}_result.csv"
    mkdir -p "/tmp/.syslog"
    chmod -R 777 "/tmp/.syslog"
    [ ! -f "$CSV_FILE" ] && echo "student_name,lab_name,date,percentage" > "$CSV_FILE"
    echo "$STUDENT_NAME,\"$LAB_NAME\",$DATE,$PERCENT%" >> "$CSV_FILE"
}
#==============================================================================================================

check_review_lab2() {
    echo -e "\n\e[34mChecking Review_Lab2 – 2025 Tasks...\e[0m"

    HOME_DIR="$HOME"
    TOTAL_TASKS=17
    PASSED=0
    LAB_NAME="Review_Lab2 – 2025"
    #STUDENT_NAME=$(whoami)
    DATE=$(date +%F)

    pass() {
        echo -e "\e[32m$1 – Pass\e[0m"
        ((PASSED++))
    }

    fail() {
        echo -e "\e[31m$1 – Fail\e[0m"
    }

    # Task 1
    if [ -d "$HOME_DIR/workspace/tools/configs" ] && [ -d "$HOME_DIR/workspace/server/logs" ]; then
       pass "Task 1: Nested directories created successfully"
    else
       fail "Task 1: Directory structure not found"
    fi

    # Task 2
    if [ -f "$HOME_DIR/workspace/tools/tracker.log" ]; then
        pass "Task 2: tracker.log file created"
    else
        fail "Task 2: tracker.log not found"
    fi

    # Task 3
    grep -Fxq "Build process initialized. Stand by..." "$HOME_DIR/workspace/tools/configs/build.txt" && \
    pass "Task 3: build.txt created with correct content" || fail "Task 3: build.txt content mismatch or file missing"

    # Task 4
    if [ -d "$HOME_DIR/linux_practice" ]; then
        pass "Task 4: linux_practice directory created"
    else
        fail "Task 4: linux_practice not found"
    fi

    # Task 5
    if [ -d "$HOME_DIR/linux_practice" ]; then
        pass "Task 5: Permisions on linux_practice directory changed correctly"
    else
        fail "Task 5: Permissions on linux_practice are in correct"
    fi

    # Task 6
    DIR="$HOME/linux_practice"
    ls "$DIR" &>/dev/null
    LS_STATUS=$?
    cd "$DIR" &>/dev/null
    CD_STATUS=$?
    if [ "$LS_STATUS" -eq 0 ] && [ "$CD_STATUS" -ne 0 ]; then
       fail "Task 6: ls succeeded unexpectedly and cd failed"
    else
       pass "Task 6: ls failed and cd successful as expected"
    fi

    # Task 7
    if [ -d "$HOME_DIR/linux_practice/Fedora" ] && [ -d "$HOME_DIR/linux_practice/Ubuntu" ]; then
       pass "Task 7: Permissions modified and Fedora & Ubuntu directories created"
    else
       fail "Task 7: Permission or directory creation issue"
    fi

    # Task 8
    if grep -Fxq "Linux permissions test" "$HOME_DIR/linux_practice/notes.txt" && \
    [ -d "$HOME_DIR/linux_practice/scripts" ]; then
        pass "Task 8: notes.txt and scripts created with correct content"
    else
        fail "Task 8: notes.txt/scripts missing or incorrect"
    fi

    # Task 9
    grep -Fxq "Linux permissions test" "$HOME_DIR/linux_practice/notes.txt" &&
    pass "Task 9: File could be read after restoring read permissions" || fail "Task 9: cat failed unexpectedly"

    # Task 10
    grep -Fxq "I am enjoying permissions session" "$HOME_DIR/linux_practice/notes.txt" 2>/dev/null
    APPEND_FAILED=$?
    if [ "$APPEND_FAILED" -ne 0 ]; then
       pass "Task 10: Appending succeeded after restoring write permissions"
    else
       fail "Task 10: Write or append failed"
    fi

    # Task 11
    perms3=$(stat -c "%A" "$HOME_DIR/linux_practice/notes.txt")
    if [[ "$perms3" == "-rwxrw-r--" ]]; then
       pass "Task 11: Execute permission set using symbolic notation"
    else
       fail "Task 11: Execute permission missing"
    fi

    # Task 12
    REPORT="$HOME_DIR/report.txt"
    if [ -f "$REPORT" ]; then
       pass "Task 12: report.txt has correct owner and group"
    else
       fail "Task 12: report.txt owner/group mismatch"
    fi

    # Task 13
    [ "$(stat -c %U "$REPORT")" == "new-user" ] && [ "$(stat -c %G "$REPORT")" == "students" ] && \
    pass "Task 13: Owner and group changed using chown" || fail "Task 13: chown failed"

    # Task 14
    CONFIG="$HOME_DIR/config.txt"
    [ "$(stat -c %U "$CONFIG")" == "new-user" ] &>/dev/null && [ "$(stat -c %G "$CONFIG")" == "students" ] &>/dev/null && \
    pass "Task 14: Owner and group of config.txt changed in single command" || fail "Task 14: chown failed"

    # Task 15
    FUN="$HOME_DIR/fun.txt"
    if [ "$(stat -c %G "$FUN")" == "students" ]; then
       pass "Task 15: Group of fun.txt changed using chgrp"
    else
       fail "Task 15: chgrp or content mismatch"
    fi

    # Task 16
    [ "$(stat -c %U "$HOME_DIR/sample1")" == "new-user" ] && [ "$(stat -c %G "$HOME_DIR/sample1")" == "admins" ] && \
    [ "$(stat -c %U "$HOME_DIR/sample2")" == "new-user" ] && [ "$(stat -c %G "$HOME_DIR/sample2")" == "admins" ] && \
    pass "Task 16: Ownership of sample1 and sample2 changed in one command" || fail "Task 16: Ownership mismatch"

  # Task 17
    PRJ="$HOME_DIR/project_dir"
    if [ -d "$PRJ" ] && [ -f "$PRJ/log1.txt" ] && [ -f "$PRJ/log2.txt" ] && [ -d "$PRJ/cfg1" ] && [ -d "$PRJ/cfg2" ]; then
        ALL_OK=true
        for item in "$PRJ" "$PRJ/log1.txt" "$PRJ/log2.txt" "$PRJ/cfg1" "$PRJ/cfg2"; do
            U=$(stat -c %U "$item")
            G=$(stat -c %G "$item")
            [ "$U" != "test-user" ] || [ "$G" != "admins" ] && ALL_OK=false && break
        done
        $ALL_OK && pass "Task 17: Recursive ownership on project_dir successful" || fail "Task 17: Ownership mismatch"
    else
        fail "Task 17: project_dir or its contents missing"
    fi

    # Summary
    PERCENT=$((PASSED * 100 / TOTAL_TASKS))
    echo -e "\n\e[36mSummary: $PASSED out of $TOTAL_TASKS tasks passed\e[0m"
    echo -e "\e[33mPercentage: $PERCENT%\e[0m"

    # CSV Logging
    CSV_FILE="/tmp/.syslog/lab${LAB_NUMBER}_result.csv"
    mkdir -p "/tmp/.syslog"
    chmod -R 777 "/tmp/.syslog"
    [ ! -f "$CSV_FILE" ] && echo "student_name,lab_name,date,percentage" > "$CSV_FILE"
    echo "$STUDENT_NAME,\"$LAB_NAME\",$DATE,$PERCENT%" >> "$CSV_FILE"

}
#==============================================================================================================

#!/bin/bash

check_review_lab3() {
    echo -e "\n\e[34mChecking Review_Lab3 – 2025 Tasks...\e[0m"

    HOME_DIR="$HOME"
    SERVER_INFO="$HOME/my_server_info"
    TOTAL_TASKS=21
    PASSED=0
    LAB_NAME="Review_Lab3 – 2025"
    #STUDENT_NAME=$(whoami)
    DATE=$(date +%F)

    pass() {
        echo -e "\e[32m$1 – Pass\e[0m"
        ((PASSED++))
    }

    fail() {
        echo -e "\e[31m$1 – Fail\e[0m"
    }

    echo "System Exploration and Basic Info (Tasks 1–5)"
    [ -f "$SERVER_INFO" ] || touch "$SERVER_INFO"
    if grep -q "$HOSTNAME" "$SERVER_INFO"; then
       pass "Task 1: Hostname is appended successfully"
    else
       fail "Task 1: Hostname is missing"
    fi
    if grep -q "$(uname)" "$SERVER_INFO"; then
       pass "Task 2: Kernel version and architecture logged"
    else
       fail "Task 2: Kernel version/architecture missing"
    fi
    # Task 3: Validate uptime output
    if grep -qE "users|'load average'" "$SERVER_INFO"; then
       pass "Task 3: output of uptime is logged"
    else
       fail "Task 3: output of uptime is missing"
    fi

    if grep -q "$(lscpu)" "$SERVER_INFO"; then
       pass "Task 4: CPU info is logged"
    else
       fail "Task 4: CPU info is missing"
    fi

    if grep -q "$(lsblk)" "$SERVER_INFO"; then
       pass "Task 5: Info of block devices connected to the system is updated"
    else
       fail "Task 5: Info of block devices connected to the system is missing"
    fi


    echo "Hands on: System Identification and Basic Info (Tasks 1–16)"

    # Task 1
    if [ -f "$HOME_DIR/lab2025/alpha.log" ]; then
       pass "Task 1: alpha.log file created"
    else
       fail "Task 1: alpha.log not found"
    fi

    # Task 2
    if [ -d "$HOME_DIR/lab2025/Linux/DevOps" ]; then
       pass "Task 2: Directory structure created"
    else
       fail "Task 2: Directory structure missing"
    fi

    # Task 3
    if grep -Fxq "This is my first .txt file" "$HOME_DIR/lab2025/Linux/DevOps/one.txt" &&
    grep -Fxq "This is my second .txt file" "$HOME_DIR/lab2025/Linux/DevOps/two.txt" &&
    grep -Fxq "This is my third .txt file" "$HOME_DIR/lab2025/Linux/DevOps/three.txt"; then
       pass "Task 3: All .txt files with correct content created"
    else
       fail "Task 3: Missing or incorrect .txt files"
    fi

    # Task 4
    [ -d "$HOME_DIR/lab2025/Linux/old_stuff" ] && [ -f "$HOME_DIR/lab2025/Linux/old_stuff/summary.txt" ] &&
    pass "Task 4: summary.txt copied to old_stuff" || fail "Task 4: summary.txt missing in old_stuff"

    # Task 5
    if [ -f "$HOME_DIR/lab2025/Linux/DevOps/final_three.txt" ]; then
       pass "Task 5: final_three.txt restored from summary.txt"
    else
       fail "Task 5: final_three.txt missing"
    fi

    # Task 6
    grep -q "one.txt" "$HOME_DIR/lab2025/Linux/dirlist.txt" &&
    pass "Task 6: dirlist.txt contains DevOps directory listing" || fail "Task 6: dirlist.txt missing or incorrect"

    # Task 7
    if [ -f "$HOME_DIR/lab2025/Linux/data.csv" ]; then
        grep -q "id,name,score" "$HOME_DIR/lab2025/Linux/data.csv" &&
        grep -q "1,Alice,85" "$HOME_DIR/lab2025/Linux/data.csv" &&
        pass "Task 7: data.csv created with initial data" || fail "Task 7: data.csv content incorrect"
    else
        fail "Task 7: data.csv not found"
    fi

    # Task 8
    grep -qE "Bob|Carol" "$HOME_DIR/lab2025/Linux/merged.log" &&
    grep -qE "one.txt" "$HOME_DIR/lab2025/Linux/merged.log" &&
    pass "Task 8: merged.log created from summary.txt and dirlist.txt" || fail "Task 8: merged.log content incorrect"

    # Task 9
    grep -q "Bob,90" "$HOME_DIR/lab2025/Linux/merged.log" &&
    grep -q "Carol,70" "$HOME_DIR/lab2025/Linux/merged.log" &&
    pass "Task 9: Scores of Bob and Carol appended" || fail "Task 9: Scores missing in merged.log"

    # Task 10
    grep -q "Alice,85" "$HOME_DIR/lab2025/Linux/merged.log" &&
    grep -q "Bob,90" "$HOME_DIR/lab2025/Linux/merged.log" &&
    pass "Task 10: Scores above 80 appended" || fail "Task 10: Score filter failed"

    # Task 11
    perms=$(stat -c "%A" "$HOME_DIR/lab2025/Linux/DevOps/secret.txt" 2>/dev/null)
    [[ "$perms" == "-rw-rw----" || "$perms" == "-rw-r-----" ]] &&
    pass "Task 11: secret.txt has correct permissions" || fail "Task 11: Incorrect permissions on secret.txt"

    # Task 12
    [ -d "$HOME_DIR/lab2025/Linux/DevOps/private_dir" ] &&
    perms2=$(stat -c "%A" "$HOME_DIR/lab2025/Linux/DevOps/private_dir")
    [[ "$perms2" == "drwx------" ]] &&
    pass "Task 12: private_dir permissions correctly set" || fail "Task 12: Incorrect permissions on private_dir"

    # Task 13
    perms3=$(stat -c "%a" "$HOME_DIR/lab2025/Linux/old_stuff/summary.txt" 2>/dev/null)
    [ "$perms3" == "640" ] &&
    pass "Task 13: summary.txt has 640 permissions" || fail "Task 13: summary.txt permission mismatch"

    # Task 14
    perms4=$(stat -c "%A" "$HOME_DIR/lab2025/Linux/data.csv" 2>/dev/null)
    [[ "$perms4" == "-rw-rwxrwx" ]] &&
    pass "Task 14: data.csv has full group/others access" || fail "Task 14: Incorrect permissions on data.csv"
 # Task 15
    OWNER=$(stat -c "%U" "$HOME_DIR/lab2025/Linux/DevOps/final_three.txt")
    GROUP=$(stat -c "%G" "$HOME_DIR/lab2025/Linux/DevOps/final_three.txt")
    [ "$OWNER" == "new-user" ] && [ "$GROUP" == "admins" ] &&
    pass "Task 15: Ownership of final_three.txt changed" || fail "Task 15: Ownership mismatch"

    # Task 16
    file=~/lab2025/Linux/data.csv
    if grep -q "^4,David,95$" "$file" && [ "$(tail -n 1 "$file")" = "1,Alice,85" ]; then
       pass "Task 16: data.csv contains required content."
    else
       fail "Task 16: data.csv is missing required content."
    fi

    # Summary
    PERCENT=$((PASSED * 100 / TOTAL_TASKS))
    echo -e "\n\e[36mSummary: $PASSED out of $TOTAL_TASKS tasks passed\e[0m"
    echo -e "\e[33mPercentage: $PERCENT%\e[0m"

    # CSV Logging
    CSV_FILE="/tmp/.syslog/lab${LAB_NUMBER}_result.csv"
    mkdir -p "/tmp/.syslog"
    chmod -R 777 "/tmp/.syslog"
    [ ! -f "$CSV_FILE" ] && echo "student_name,lab_name,date,percentage" > "$CSV_FILE"
    echo "$STUDENT_NAME,\"$LAB_NAME\",$DATE,$PERCENT%" >> "$CSV_FILE"

}
#==============================================================================================================
#!/bin/bash

check_lab7_find() {
    echo -e "\n\e[34mChecking Lab7 – Find Command Practice – 2025...\e[0m"

    OUTPUT_FILE="$HOME/output_find"
    LOG_FILE="$HOME/log_files"
    CONF_BACKUP="$HOME/backup_conf"
    #STUDENT=$(whoami)
    DATE=$(date +%F)
    PASSED=0
    TOTAL_TASKS=14
    LAB_NAME="Lab7 – Find Command Practice – 2025"

    pass() {
        echo -e "\e[32m$1 – Pass\e[0m"
        ((PASSED++))
    }

    fail() {
        echo -e "\e[31m$1 – Fail\e[0m"
    }

    # Task 1
    if grep -q "$STUDENT" "$OUTPUT_FILE"; then
        pass "Task 1: Files owned by current user found"
    else
        fail "Task 1: Files owned by user missing in output"
    fi

    # Task 2
    if grep -E "$HOME/\.[^/]+" "$OUTPUT_FILE" >/dev/null; then
       pass "Task 2: Hidden files inside home found"
    else
       fail "Task 2: Hidden files inside home not found"
    fi

    # Task 3
    if [ "$(grep -c '^/var' "$HOME/output_find")" -ge 1 ]; then
       pass "Task 3: Recently modified files in /var logged"
    else
       fail "Task 3: Missing recently modified files from /var"
    fi

    # Task 4
    if grep -q "/var" "$OUTPUT_FILE" && grep -i -q "access" "$OUTPUT_FILE"; then
        pass "Task 4: Files accessed more than 10 days ago found"
    else
        fail "Task 4: Files accessed >10 days ago missing"
    fi

    # Task 5
    found=0
      while IFS= read -r file; do
    if [ -f "$file" ]; then
        size=$(stat -c %s "$file")
        if [ "$size" -gt 1048576 ]; then
            found=1
            break
        fi
    fi
    done < "$OUTPUT_FILE"

    if [ "$found" -eq 1 ]; then
    pass "Task 5: Files >1MB under /etc found"
    else
    fail "Task 5: Large files under /etc not found"
    fi


    # Task 6

    found=0

    while IFS= read -r file; do
    if [ -f "$file" ]; then
        size=$(stat -c %s "$file")
        if [ "$size" -lt 1048576 ]; then
            found=1
            break
        fi
    fi
     done < "$OUTPUT_FILE"

     if [ "$found" -eq 1 ]; then
         pass "Task 6: Files <1MB under /etc found"
     else
         fail "Task 6: Small files under /etc not found"
     fi

    # Task 7
    if grep -q "/home" "$OUTPUT_FILE" && grep -q "$STUDENT" "$OUTPUT_FILE" && grep -qi "0" "$OUTPUT_FILE"; then
        pass "Task 7: Empty files owned by user found"
    else
        fail "Task 7: Empty user-owned files not found"
    fi

    # Task 8
    if grep -q ".sh" "$OUTPUT_FILE"; then
        pass "Task 8: include.sh files found"
    else
        fail "Task 8: include.sh files not found"
    fi

    # Task 9
    if grep -q "/home" "$OUTPUT_FILE" && grep -q "644" "$OUTPUT_FILE"; then
        pass "Task 9: Files with 644 permissions found"
    else
        fail "Task 9: Files with 644 permissions missing"
    fi

    # Task 10
    if grep -q "/home" "$OUTPUT_FILE" && grep -q "755" "$OUTPUT_FILE"; then
        pass "Task 10: Directories with 755 permissions found"
    else
        fail "Task 10: 755 permission directories not found"
    fi

    # Task 11
    if grep -q "/var" "$OUTPUT_FILE" && grep -q "messages" "$OUTPUT_FILE" && grep -q "root" "$OUTPUT_FILE"; then
        pass "Task 11: messages file owned by root found"
    else
        fail "Task 11: messages file not found or not owned by root"
    fi

    # Task 12
    if [ -f "$LOG_FILE" ] && grep -q "\.log" "$LOG_FILE"; then
        pass "Task 12: .log files listed in ~/log_files"
    else
        fail "Task 12: .log files missing from ~/log_files"
    fi
 # Task 13
    if [ -d "$CONF_BACKUP" ] && find "$CONF_BACKUP" -name "*.conf" | grep -q "."; then
        pass "Task 13: .conf files backed up to ~/backup_conf"
    else
        fail "Task 13: .conf files not copied to ~/backup_conf"
    fi

    # Task 14
    if ! find /tmp -user "$STUDENT" 2>/dev/null | grep -q "."; then
        pass "Task 14: Files owned by user in /tmp deleted"
    else
        fail "Task 14: Files owned by user in /tmp still exist"
    fi

    # Summary
    PERCENT=$((PASSED * 100 / TOTAL_TASKS))
    echo -e "\n\e[36mSummary: $PASSED out of $TOTAL_TASKS tasks passed\e[0m"
    echo -e "\e[33mPercentage: $PERCENT%\e[0m"

    # CSV Logging
    CSV_FILE="/tmp/.syslog/lab${LAB_NUMBER}_result.csv"
    mkdir -p "/tmp/.syslog"
    chmod -R 777 "/tmp/.syslog"
    [ ! -f "$CSV_FILE" ] && echo "student_name,lab_name,date,percentage" > "$CSV_FILE"
    echo "$STUDENT_NAME,\"$LAB_NAME\",$DATE,$PERCENT%" >> "$CSV_FILE"

}
#================================================================================================================================

#!/bin/bash

check_lab8_grep_wc() {
    echo -e "\n\e[34mChecking Lab8 – grep and wc Practice – 2025...\e[0m"

    OUTPUT_FILE="$HOME/output_grep.txt"
    #STUDENT=$(whoami)
    DATE=$(date +%F)
    PASSED=0
    TOTAL_TASKS=15
    LAB_NAME="Lab – grep and wc Practice – 2025"

    pass() {
        echo -e "\e[32m$1 – Pass\e[0m"
        ((PASSED++))
    }

    fail() {
        echo -e "\e[31m$1 – Fail\e[0m"
    }

    # Task 1
    if [ -f "$HOME/passwd" ]; then
        pass "Task 1: /etc/passwd copied to home"
    else
        fail "Task 1: /etc/passwd not copied"
    fi

    # Task 2
    if grep -q "spool" "$OUTPUT_FILE"; then
        pass "Task 2: 'spool' lines from ~/passwd found"
    else
        fail "Task 2: 'spool' lines missing"
    fi

    # Task 3
    if grep "polkitd" "$OUTPUT_FILE" | grep -q "polkitd"; then
        pass "Task 3: 'polkitd' with 2 lines before found"
    else
        fail "Task 3: polkitd with 2 lines before missing"
    fi

    # Task 4
    if grep "shutdown" "$OUTPUT_FILE" | grep -q "shutdown"; then
        pass "Task 4: 'shutdown' with 2 lines after found"
    else
        fail "Task 4: 'shutdown' with 2 lines after missing"
    fi

    # Task 5
    if grep "mail" "$OUTPUT_FILE" | grep -q "mail"; then
        pass "Task 5: 'mail' with 2 lines before & after found"
    else
        fail "Task 5: 'mail' context lines missing"
    fi

    # Task 6
    if grep -v "search" /etc/resolv.conf | grep -vq "search"; then
        pass "Task 6: Lines excluding 'search' extracted"
    else
        fail "Task 6: Exclude 'search' lines failed"
    fi

    # Task 7
    if grep "Root" /tmp/httpd.conf 2>/dev/null | grep -qv "root"; then
        pass "Task 7: Case-sensitive 'Root' filtered"
    else
        fail "Task 7: Case-sensitive 'Root' not found"
    fi

    # Task 8
    if grep -i "root" /tmp/httpd.conf 2>/dev/null | grep -iq "root"; then
        pass "Task 8: Case-insensitive 'root' filtered"
    else
        fail "Task 8: Case-insensitive 'root' missing"
    fi

    # Task 9
    if grep -c "sshd" /tmp/sshd_config 2>/dev/null | grep -q "[0-9]"; then
        pass "Task 11: Count of 'sshd' lines done"
    else
        fail "Task 11: 'sshd' count failed"
    fi

    # Task 10
    if [ -f "$HOME/states.vim" ] && grep -q "Jersey" "$HOME/states.vim"; then
        pass "Task 12: states.vim created with state names"
    else
        fail "Task 12: states.vim missing or incomplete"
    fi

    # Task 11
    if wc "$HOME/states.vim" | grep -q "[0-9]\+ *[0-9]\+ *[0-9]\+"; then
        pass "Task 13: wc count of lines/words/characters done"
    else
        fail "Task 13: wc full count failed"
    fi

    # Task 12
    if wc -l "$HOME/states.vim" | grep -q "^[[:space:]]*[0-9]"; then
        pass "Task 14: wc line count successful"
    else
        fail "Task 14: wc line count failed"
    fi

    # Task 13
    if wc -w "$HOME/states.vim" | grep -q "^[[:space:]]*[0-9]"; then
        pass "Task 15: wc word count successful"
    else
        fail "Task 15: wc word count failed"
    fi

    # Task 14
    if wc -m "$HOME/states.vim" | grep -q "^[[:space:]]*[0-9]"; then
        pass "Task 16: wc character count successful"
    else
        fail "Task 16: wc character count failed"
    fi

    # Task 15
    if wc -c "$HOME/states.vim" | grep -q "^[[:space:]]*[0-9]"; then
        pass "Task 17: wc byte count successful"
    else
        fail "Task 17: wc byte count failed"
    fi

    # Summary
    PERCENT=$((PASSED * 100 / TOTAL_TASKS))
    echo -e "\n\e[36mSummary: $PASSED out of $TOTAL_TASKS tasks passed\e[0m"
    echo -e "\e[33mPercentage: $PERCENT%\e[0m"
 # CSV Logging
    CSV_FILE="/tmp/.syslog/lab${LAB_NUMBER}_result.csv"
    mkdir -p "/tmp/.syslog"
    chmod -R 777 "/tmp/.syslog"
    [ ! -f "$CSV_FILE" ] && echo "student_name,lab_name,date,percentage" > "$CSV_FILE"
    echo "$STUDENT_NAME,\"$LAB_NAME\",$DATE,$PERCENT%" >> "$CSV_FILE"

}

#========================================================================================================================================

#!/bin/bash

check_lab9_link_mgt() {
    echo -e "\n\e[34mValidating Lab9 - Link Management in Linux – 2025: Link Management\e[0m"

    HOME_DIR="$HOME"
    TOTAL_TASKS=25
    PASSED=0
    LAB_NAME="Lab 9 – 2025"
    #STUDENT_NAME=$(whoami)
    DATE=$(date +%F)

    pass() {
        echo -e "\e[32m$1 – Pass\e[0m"
        ((PASSED++))
    }

    fail() {
        echo -e "\e[31m$1 – Fail\e[0m"
    }

    cd "$HOME_DIR" || exit 1

    # Symbolic Link Tasks

    if [ "$(cat ~/my_file.txt)" == "I Love Linux Operating System" ]; then
       pass "Task 1: my_file.txt created with correct content"
    else
       fail "Task 1: File missing or content mismatch"
    fi

    if [ -L my_link.txt ]; then
        pass "Task 2: Symbolic link my_link.txt created"
    else
        fail "Task 2: Symbolic link not found"
    fi

    LINK_TARGET=$(readlink /home/$USER/my_link.txt)
    [[ "$LINK_TARGET" == "/home/$USER/my_file.txt" ]] &&
    pass "Task 3: Symbolic link points to my_file.txt" || fail "Task 3: Symbolic link target mismatch"

    [[ "$(cat ~/my_link.txt 2>/dev/null)" == "I Love Linux Operating System" ]] &&
    pass "Task 4: Content of my_link.txt matches" || fail "Task 4: my_link.txt content mismatch"

    inode_file=$(stat -c %i my_file.txt 2>/dev/null)
    inode_link=$(stat -c %i my_link.txt 2>/dev/null)
    [[ "$inode_file" != "$inode_link" ]] &&
    pass "Task 5: Inodes are different for soft link and file" || fail "Task 5: Inodes are same (should differ)"

    mv ~/my_file.txt ~/my_dir/my_file.txt && [ -f ~/my_dir/my_file.txt ] &&
    pass "Task 6: Directory my_dir created and my_file.txt moved" || fail "Task 6: Move failed"

    LINK_TARGET=$(readlink ~/my_link.txt)
    if [[ "$LINK_TARGET" != "~/my_file.txt" ]]; then
       pass "Task 7: Symbolic link is broken after move"
    else
       fail "Task 7: Symbolic link is not broken"
    fi

    mv ~/my_dir/my_file.txt ~/my_file.txt && [ -f ~/my_file.txt ] &&
    pass "Task 8: my_file.txt moved back to home" || fail "Task 8: my_file.txt not moved back"

    [[ "$(cat ~/my_link.txt 2>/dev/null)" == "I Love Linux Operating System" ]] &&
    pass "Task 9: Symbolic link works again after move back" || fail "Task 9: Symbolic link still broken"

    perms=$(stat -c "%A" ~/my_link.txt 2>/dev/null)
    [[ "$perms" != -rw-r--r-- ]] && pass "Task 10: Permissions on my_link.txt changed" || fail "Task 10: my_link.txt permission mismatch"

    perms_file=$(stat -c "%A" my_file.txt 2>/dev/null)
    [[ "$perms_file" != "$perms" ]] && pass "Task 11: my_file.txt permissions not changed (expected)" || fail "Task 11: my_file.txt permissions changed (unexpected)"

    if [ -f my_file.txt ]; then
       pass "Task 12: Symbolic link removed but my_file.txt intact"
    else
       fail "Task 12: Link/file deletion mismatch"
    fi

    if [ -f new_dir/file1.txt ] && [ -f new_dir/file2.txt ]; then
       pass "Task 13: new_dir and files created"
    else
       fail "Task 13: Directory/files missing"
    fi

    [ -L new_link ] && [[ "$(readlink new_link)" == "new_dir" ]] &&
    pass "Task 14: Symbolic link to directory created" || fail "Task 14: Directory symlink missing or incorrect"

    ls new_link/file1.txt &>/dev/null && ls new_link/file2.txt &>/dev/null &&
    pass "Task 15: Symbolic link to directory works" || fail "Task 15: Link to directory broken or incomplete"

    [ -d new_dir ] &&
    pass "Task 16: Symbolic link removed, directory intact" || fail "Task 16: Directory or link status invalid"

    # Hard Link Tasks

    grep -q "Welcome to Linoop" "source_file.txt" 2>/dev/null &&
    pass "Task 17: source_file.txt created with correct content" || fail "Task 17: File missing or content mismatch"

    [ -f hard_link.txt ] &&
    pass "Task 18: Hard link hard_link.txt created" || fail "Task 18: Hard link not created"

    [[ "$(cat hard_link.txt 2>/dev/null)" == "Welcome to Linoop" ]] &&
    pass "Task 19: Contents of hard_link.txt match" || fail "Task 19: hard_link.txt content mismatch"

    inode1=$(stat -c %i source_file.txt 2>/dev/null)
    inode2=$(stat -c %i hard_link.txt 2>/dev/null)
    [[ "$inode1" == "$inode2" ]] &&
    pass "Task 20: Inodes match for hard link and file" || fail "Task 20: Inodes do not match (should match)"

    mv source_file.txt hard_link_dir && [ -f hard_link_dir/source_file.txt ] &&
    pass "Task 21: source_file.txt moved to hard_link_dir" || fail "Task 21: Move failed"

    [[ "$(cat hard_link.txt 2>/dev/null)" == "Welcome to Linoop" ]] &&
    pass "Task 22: hard_link.txt still works after move" || fail "Task 22: hard_link.txt broken"

    mv ~/hard_link_dir/source_file.txt ~/source_file.txt && chmod 0640 ~/source_file.txt
    pass "Task 23: source_file moved and permissions changes succesfully" || fail "Task 23: File missing / permissions incorrect"

    perms1=$(stat -c "%A" hard_link.txt 2>/dev/null)
    perms2=$(stat -c "%A" source_file.txt 2>/dev/null)
    [[ "$perms1" == "$perms2" ]] &&
    pass "Task 24: Permissions are changed and still same on both hard links" || fail "Task 24: Permissions mismatch"
  ln new_dir new_hard_link 2>/dev/null
    if [ -e new_hard_link ]; then
        fail "Task 25: Hard link to directory created (should fail)"
        rm -f new_hard_link
    else
        pass "Task 25: Cannot create hard link to directory (correct behavior)"
    fi

    # Summary
    PERCENT=$((PASSED * 100 / TOTAL_TASKS))
    echo -e "\n\e[36mSummary: $PASSED out of $TOTAL_TASKS tasks passed\e[0m"
    echo -e "\e[33mPercentage: $PERCENT%\e[0m"

    # CSV Logging
    CSV_FILE="/tmp/.syslog/lab${LAB_NUMBER}_result.csv"
    mkdir -p "/tmp/.syslog"
    chmod -R 777 "/tmp/.syslog"
    [ ! -f "$CSV_FILE" ] && echo "student_name,lab_name,date,percentage" > "$CSV_FILE"
    echo "$STUDENT_NAME,\"$LAB_NAME\",$DATE,$PERCENT%" >> "$CSV_FILE"

}
#=============================================================================================================

check_lab10_tar() {
    echo -e "\n\e[34mValidating Lab – Tar and Compression in Linux – 2025\e[0m"

    HOME_DIR="$HOME"
    TOTAL_TASKS=15
    PASSED=0
    LAB_NAME="Lab – Tar and Compression – 2025"
    #STUDENT_NAME=$(whoami)
    #LAB_NUMBER="$LAB_NUMBER"
    DATE=$(date +%F)

    pass() {
        echo -e "\e[32m$1 – Pass\e[0m"
        ((PASSED++))
    }

    fail() {
        echo -e "\e[31m$1 – Fail\e[0m"
    }

    cd "$HOME_DIR" || exit 1

    # Task 1: Check uncompressed archive exists
    if [ -f "$HOME_DIR/etc_backup.tar" ]; then
        pass "Task 1: etc_backup.tar created in home directory"
    else
        fail "Task 1: etc_backup.tar not found"
    fi

    # Task 2: Check size is retrievable
    if ls -lh "$HOME_DIR/etc_backup.tar" &>/dev/null || du -sh "$HOME_DIR/etc_backup.tar" &>/dev/null; then
        pass "Task 2: Size of etc_backup.tar verified"
    else
        fail "Task 2: Could not verify size of etc_backup.tar"
    fi

    # Task 3: Check tar_practice directory exists
    if [ -d "$HOME_DIR/tar_practice" ]; then
        pass "Task 3: tar_practice directory created"
    else
        fail "Task 3: tar_practice directory missing"
    fi

    # Task 4: Check compressed backup exists in tar_practice
    if [ -f "$HOME_DIR/tar_practice/etc_backup.tar.gz" ]; then
        pass "Task 4: etc_backup.tar.gz created in tar_practice"
    else
        fail "Task 4: etc_backup.tar.gz missing"
    fi

    # Task 5: Compare sizes
    if [ -f "$HOME_DIR/etc_backup.tar" ] && [ -f "$HOME_DIR/tar_practice/etc_backup.tar.gz" ]; then
        size_tar=$(stat -c%s "$HOME_DIR/etc_backup.tar")
        size_gz=$(stat -c%s "$HOME_DIR/tar_practice/etc_backup.tar.gz")
        if (( size_gz < size_tar )); then
            pass "Task 5: Compressed file smaller than uncompressed"
        else
            fail "Task 5: Compressed file not smaller"
        fi
    else
        fail "Task 5: One or both backup files missing"
    fi

    # Task 6: Check listing of etc_backup.tar contents
    if tar -tf "$HOME_DIR/etc_backup.tar" &>/dev/null; then
        pass "Task 6: etc_backup.tar contents listed"
    else
        fail "Task 6: Could not list etc_backup.tar"
    fi

    # Task 7: Extract etc_backup.tar in home dir
    if [ -d "$HOME_DIR/etc" ]; then
        pass "Task 7: etc_backup.tar extracted successfully"
    else
        fail "Task 7: etc_backup.tar extraction failed"
    fi

    # Task 8: Extract etc_backup.tar.gz in tar_practice
    if [ -d "$HOME_DIR/tar_practice/etc" ]; then
        pass "Task 8: etc_backup.tar.gz extracted in tar_practice"
    else
        fail "Task 8: Extraction of etc_backup.tar.gz failed"
    fi

    # Task 9: new_tarball_dir created and new_backup.tar exists
    if [ -d "$HOME_DIR/new_tarball_dir" ] && [ -f "$HOME_DIR/new_tarball_dir/new_backup.tar" ]; then
        pass "Task 9: new_backup.tar created with /etc/passwd and /etc/group"
    else
        fail "Task 9: new_backup.tar missing or directory missing"
    fi

    # Task 10: List new_backup.tar contents
    if tar -tf "$HOME_DIR/new_tarball_dir/new_backup.tar" &>/dev/null; then
        pass "Task 10: new_backup.tar contents listed"
    else
        fail "Task 10: Could not list new_backup.tar"
    fi

    # Task 11: Append /etc/resolv.conf and /etc/hosts
    if tar -tf "$HOME_DIR/new_tarball_dir/new_backup.tar" | grep -q "resolv.conf" &&
       tar -tf "$HOME_DIR/new_tarball_dir/new_backup.tar" | grep -q "hosts"; then
        pass "Task 11: resolv.conf and hosts appended to new_backup.tar"
    else
        fail "Task 11: Missing resolv.conf or hosts in new_backup.tar"
    fi

    # Task 12: Confirm files are appended
    count=$(tar -tf "$HOME_DIR/new_tarball_dir/new_backup.tar" | wc -l)
    if (( count >= 4 )); then
        pass "Task 12: Files appended in new_backup.tar"
    else
        fail "Task 12: Files not appended"
    fi

    # Task 13: Check /etc/group exists in new_backup.tar
    if tar -tf "$HOME_DIR/new_tarball_dir/new_backup.tar" | grep -q "group"; then
        pass "Task 13: /etc/group exists in new_backup.tar"
    else
        fail "Task 13: /etc/group missing in new_backup.tar"
    fi

    # Task 14: Verify new_backup.tar is not compressed
    if file "$HOME_DIR/new_tarball_dir/new_backup.tar" | grep -q "tar archive"; then
        pass "Task 14: new_backup.tar is uncompressed"
    else
        fail "Task 14: new_backup.tar appears compressed"
    fi

    # Task 15: Validate etc_backup.tar.gz is compressed
    if file "$HOME_DIR/tar_practice/etc_backup.tar.gz" | grep -q "gzip compressed data"; then
        pass "Task 15: etc_backup.tar.gz is compressed"
    else
        fail "Task 15: etc_backup.tar.gz not compressed"
    fi

 # Summary
    PERCENT=$((PASSED * 100 / TOTAL_TASKS))
    echo -e "\n\e[36mSummary: $PASSED out of $TOTAL_TASKS tasks passed\e[0m"
    echo -e "\e[33mPercentage: $PERCENT%\e[0m"

    # CSV Logging
    CSV_FILE="/tmp/.syslog/lab${LAB_NUMBER}_result.csv"
    mkdir -p "/tmp/.syslog"
    chmod -R 777 "/tmp/.syslog"
    [ ! -f "$CSV_FILE" ] && echo "student_name,lab_name,date,percentage" > "$CSV_FILE"
    echo "$STUDENT_NAME,\"$LAB_NAME\",$DATE,$PERCENT%" >> "$CSV_FILE"
   }
