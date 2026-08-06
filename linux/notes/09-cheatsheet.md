# 09 - Linux Cheatsheet

# Navigation

| Command | Description |
|---------|-------------|
| pwd | Show current directory |
| ls | List files and folders |
| ls -l | Detailed file listing |
| ls -a | Show hidden files |
| cd folder | Change directory |
| cd .. | Go back one directory |
| mkdir folder | Create a directory |
| rmdir folder | Remove an empty directory |
| rm file | Remove a file |
| rm -r folder | Remove directory recursively |
| cp source destination | Copy files |
| mv source destination | Move or rename files |
| touch file | Create an empty file |

---

# File Viewing

| Command | Description |
|---------|-------------|
| cat file | Display file contents |
| less file | View file page by page |
| head file | Show first 10 lines |
| head -5 file | Show first 5 lines |
| tail file | Show last 10 lines |
| tail -f file | Monitor file changes in real time |

---

# Permissions

| Command | Description |
|---------|-------------|
| ls -l | View permissions |
| chmod +x file | Make executable |
| chmod 755 file | Numeric permissions |
| chown user file | Change owner |
| whoami | Current user |
| sudo command | Run as administrator |

---

# Process Management

| Command | Description |
|---------|-------------|
| ps | Running processes |
| ps aux | Detailed process list |
| top | Live process monitor |
| kill PID | Terminate process |
| kill -9 PID | Force terminate |

---

# Networking

| Command | Description |
|---------|-------------|
| ip a | Show IP address |
| ping google.com | Test connectivity |
| curl URL | Send HTTP request |
| wget URL | Download files |
| ss -tuln | List listening ports |
| hostname | Show system hostname |

---

# Package Management

| Command | Description |
|---------|-------------|
| sudo apt update | Update package list |
| sudo apt upgrade | Upgrade packages |
| sudo apt install package | Install package |
| sudo apt remove package | Remove package |
| apt list --upgradable | List updates |
| apt show package | Show package info |

---

# System Administration

| Command | Description |
|---------|-------------|
| hostname | Show hostname |
| uptime | System uptime |
| free -m | Memory usage |
| df -h | Disk usage |
| du -sh folder | Folder size |

### systemctl

| Command | Description |
|---------|-------------|
| systemctl status nginx | Service status |
| systemctl start nginx | Start service |
| systemctl stop nginx | Stop service |
| systemctl restart nginx | Restart service |
| systemctl enable nginx | Start at boot |
| systemctl disable nginx | Disable at boot |

---

# Shell Scripting

## Variables

```bash
NAME="Subodh"
echo $NAME
```

### User Input

```bash
read NAME
```

### If Statement

```bash
if [ condition ]
then
    commands
else
    commands
fi
```

### For Loop

```bash
for i in {1..5}
do
    echo $i
done
```

### While Loop

```bash
while [ condition ]
do
    commands
done
```

### Function

```bash
greet(){
    echo "Hello"
}

greet
```

### Exit Status

```bash
echo $?
```

- `0` = Success
- Non-zero = Error

---

# Text Processing

## grep

```bash
grep "ERROR" app.log
grep -i "error" app.log
grep -n "ERROR" app.log
grep -c "ERROR" app.log
grep -r "ERROR" .
```

---

## Pipes

```bash
cat app.log | grep ERROR
```

---

## Redirection

```bash
echo "Hello" > file.txt
echo "World" >> file.txt
```

---

## wc

```bash
wc -l file
wc -w file
wc -m file
```

---

## sort & uniq

```bash
sort names.txt
sort names.txt | uniq
sort names.txt | uniq -c
```

---

## cut

```bash
cut -d "," -f2 users.csv
```

---

## sed

```bash
sed 's/ERROR/SUCCESS/' file
sed 's/ERROR/SUCCESS/g' file
sed -i 's/ERROR/SUCCESS/g' file
```

---

## awk

```bash
awk '{print $1}' file
awk '{print $1,$2}' file
awk 'END {print NR}' file
```

---

# Useful Shortcuts

| Shortcut | Description |
|----------|-------------|
| Ctrl + C | Stop running command |
| Ctrl + L | Clear terminal |
| Ctrl + R | Search command history |
| Tab | Auto-complete |
| ↑ / ↓ | Previous/next command |

---

# Mini Projects

- healthcheck.sh
- backup.sh
- disk-usage.sh
- log-monitor.sh
- find-errors.sh

---

# Linux Learning Summary

- File & directory management
- Permissions & ownership
- Process management
- Networking basics
- Package management
- System administration
- Shell scripting
- Text processing
- Practical automation scripts
