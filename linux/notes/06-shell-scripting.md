# Shell Scripting

## What is Shell Scripting?

A shell script is a text file containing Linux commands that are executed by the shell. It is used to automate repetitive tasks, system administration, and DevOps workflows.

---

# Shebang

The first line of a script tells Linux which interpreter should execute it.

```bash
#!/bin/bash
```

---

# Making a Script Executable

```bash
chmod +x hello.sh
./hello.sh
```

---

# Printing Output

Use `echo` to display text.

```bash
echo "Hello, DevOps!"
```

---

# Variables

Variables store values.

```bash
#!/bin/bash

name="Subodh"

echo "Hello $name"
```

---

# User Input

Read input from the keyboard.

```bash
read -p "Enter your name: " name

echo "Hello $name"
```

Hide password input:

```bash
read -sp "Enter password: " password
echo
```

---

# Command Substitution

Store command output in a variable.

```bash
current_user=$(whoami)

echo "$current_user"
```

---

# If Statement

Execute code based on a condition.

```bash
if [ "$password" = "admin" ]
then
    echo "Access Granted"
else
    echo "Access Denied"
fi
```

---

# For Loop

Repeat commands over a list or range.

```bash
for i in {1..5}
do
    echo "$i"
done
```

Loop through files:

```bash
for file in *.sh
do
    echo "$file"
done
```

---

# While Loop

Repeat while a condition is true.

```bash
count=1

while [ $count -le 5 ]
do
    echo "$count"
    ((count++))
done
```

---

# Functions

Functions group reusable commands.

```bash
greet() {
    echo "Hello $1"
}

greet "Subodh"
```

---

# Script Arguments

Arguments are values passed when running a script.

```bash
./script.sh apple banana
```

Special variables:

| Variable | Description |
|----------|-------------|
| `$0` | Script name |
| `$1` | First argument |
| `$2` | Second argument |
| `$#` | Number of arguments |
| `$@` | All arguments |

Example:

```bash
for arg in "$@"
do
    echo "$arg"
done
```

---

# Arithmetic Operations

Use arithmetic expansion.

```bash
num1=5
num2=10

echo $((num1 + num2))
echo $((num1 * num2))
```

---

# Exit Codes

Every Linux command returns an exit status.

- `0` → Success
- Non-zero → Error

Exit manually:

```bash
exit 0
```

Check the last command's exit status:

```bash
echo $?
```

---

# Common Bash Scripts

- hello.sh
- variables.sh
- user-info.sh
- input.sh
- if-demo.sh
- test.sh
- for-loop.sh
- while-loop.sh
- functions.sh
- exit-demo.sh

---

# Common Commands

| Command | Purpose |
|---------|---------|
| `echo` | Print output |
| `read` | Read user input |
| `chmod +x` | Make script executable |
| `./script.sh` | Run script |
| `exit` | Exit script |
| `$?` | Last command exit status |
| `$1` | First argument |
| `$@` | All arguments |
| `$#` | Number of arguments |

---

# Summary

Shell scripting is used to automate Linux tasks. Bash scripts can read user input, use variables, perform calculations, make decisions with conditions, repeat tasks using loops, organize code with functions, accept command-line arguments, and return exit codes. These concepts form the foundation for writing automation scripts used in DevOps.
