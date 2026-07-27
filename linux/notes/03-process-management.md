# Linux Processes, Package Management & Shell Environment

## Overview

A process is a program that is currently running. Every command executed in Linux creates a process. Linux provides tools to view, monitor, control, prioritize, and terminate processes. Process management is one of the core skills required for Linux administration, DevOps, Docker, Kubernetes, and server troubleshooting.

---

# What is a Process?

A process is an instance of a running program.

Example:

```bash
sleep 300
```

This starts the `sleep` program as a running process for 300 seconds.

Every process has a unique **Process ID (PID)** assigned by the operating system.

---

# Viewing Running Processes

## ps

Displays processes running in the current terminal.

```bash
ps
```

Example:

```text
PID   TTY      TIME     CMD
351   pts/0    0:00     bash
554   pts/0    0:00     ps
```

Columns:

| Column | Meaning |
|---------|---------|
| PID | Process ID |
| TTY | Terminal |
| TIME | CPU time used |
| CMD | Running command |

---

## ps aux

Displays every running process on the system.

```bash
ps aux
```

Important columns:

| Column | Meaning |
|---------|---------|
| USER | Process owner |
| PID | Process ID |
| %CPU | CPU usage |
| %MEM | Memory usage |
| VSZ | Virtual memory |
| RSS | Physical memory used |
| STAT | Process state |
| COMMAND | Executed command |

---

# Filtering Processes

Use `grep` to search process output.

Example:

```bash
ps aux | grep firefox
```

Example:

```text
subodh_wsl 559 ... grep --color=auto firefox
```

If Firefox is not running, only the `grep` process appears.

---

# Monitoring Processes

## top

Displays real-time information about the system.

```bash
top
```

Shows:

- CPU usage
- Memory usage
- Running processes
- Load average
- Process states

Exit:

```
q
```

---

## htop

An interactive version of `top` with a more user-friendly interface.

Update package list:

```bash
sudo apt update
```

Install:

```bash
sudo apt install htop
```

Run:

```bash
htop
```

Exit:

```
F10
```

---

# Package Management

Ubuntu uses the **APT (Advanced Package Tool)** package manager.

Update package information:

```bash
sudo apt update
```

Install software:

```bash
sudo apt install package-name
```

Example:

```bash
sudo apt install htop
```

APT downloads software from Ubuntu repositories and installs all required dependencies automatically.

---

# Foreground and Background Processes

By default, processes run in the foreground.

Example:

```bash
sleep 300
```

The terminal waits until the process finishes.

---

## Suspend a Process

Press:

```
Ctrl + Z
```

The process becomes **Stopped**.

Example:

```
[1]+ Stopped sleep 300
```

---

## jobs

Displays jobs started from the current terminal.

```bash
jobs
```

Example:

```text
[1]+ Stopped sleep 300
```

---

## bg

Continues a stopped job in the background.

```bash
bg
```

Example:

```text
[1]+ sleep 300 &
```

The terminal becomes available for other commands.

---

## fg

Moves a background job back to the foreground.

```bash
fg
```

Example:

```text
sleep 300
```

---

## Run Directly in Background

Append `&` to a command.

```bash
sleep 300 &
```

Example output:

```text
[1] 944
```

The number `944` is the process ID.

---

# Finding Processes

## pgrep

Finds the PID of a running process.

```bash
pgrep sleep
```

Example:

```
944
```

---

# Stopping Processes

## kill

Terminates a process using its PID.

```bash
kill 944
```

Verify:

```bash
jobs
```

---

## kill -9

Forcefully terminates a process.

```bash
kill -9 952
```

This sends the **SIGKILL** signal, immediately stopping the process.

---

## killall

Stops all processes with the same name.

```bash
killall sleep
```

Useful when multiple instances of a program are running.

---

# Process Priority

Linux schedules CPU time based on process priority.

Lower priority processes receive CPU time after higher priority processes.

---

## nice

Starts a new process with a specified priority.

```bash
nice -n 10 sleep 100
```

- Default nice value: `0`
- Higher nice value = Lower priority
- Lower nice value = Higher priority

---

## renice

Changes the priority of an already running process.

Syntax:

```bash
sudo renice priority -p PID
```

Example:

```bash
sudo renice 5 -p 952
```

---

# Process States

Common process states:

| State | Meaning |
|--------|---------|
| R | Running |
| S | Sleeping |
| T | Stopped |
| Z | Zombie |

These states can be viewed using:

```bash
ps aux
```

or

```bash
top
```

---

# Viewing Detailed Process Information

Use:

```bash
ps -l
```

Example:

```text
F S UID PID PPID C PRI NI CMD
```

Important columns:

| Column | Meaning |
|---------|---------|
| PID | Process ID |
| PPID | Parent Process ID |
| PRI | Priority |
| NI | Nice value |
| CMD | Running command |

---

# Commands Practised

```bash
ps
ps aux
ps -l
grep
top
htop
jobs
bg
fg
sleep
pgrep
kill
kill -9
killall
nice
renice
sudo apt update
sudo apt install
pwd
cd
ls
```

---

# Key Takeaways

- Every running program is a process.
- Every process has a unique PID.
- `ps` displays running processes.
- `ps aux` displays all processes in the system.
- `top` and `htop` monitor system resources in real time.
- `jobs`, `bg`, `fg`, and `Ctrl + Z` manage terminal jobs.
- `pgrep` finds the PID of a running process.
- `kill` stops a process gracefully.
- `kill -9` forcefully terminates a process.
- `killall` stops all processes with the same name.
- `nice` starts a process with a different priority.
- `renice` changes the priority of an existing process.
- `apt` is Ubuntu's package manager used to install and update software.

---

# Next Topic

**04 – Linux Networking Basics**
