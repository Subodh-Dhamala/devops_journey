# Linux Permissions & Ownership

## Overview

Linux uses a permission system to control who can read, modify, and execute files and directories. Understanding permissions is essential for system administration, DevOps, Docker, Kubernetes, CI/CD pipelines, and server security.

---

# Viewing Permissions

View detailed information about files and directories:

```bash
ls -l
```

Example:

```text
drwxr-xr-x 2 subodh_wsl subodh_wsl 4096 Jul 25 10:33 docs
-rw-r--r-- 1 subodh_wsl subodh_wsl    0 Jul 25 10:33 file1.txt
-rwxr-xr-x 1 subodh_wsl subodh_wsl    0 Jul 25 10:45 script.sh
```

Format:

```text
permissions  links  owner  group  size  date  filename
```

---

# File Types

The first character represents the file type.

| Symbol | Meaning |
|---------|---------|
| - | Regular File |
| d | Directory |
| l | Symbolic Link |

Example:

```text
drwxr-xr-x
```

`d` means it is a directory.

---

# Understanding Linux Permissions

Each permission has a numeric value.

| Permission | Symbol | Value |
|------------|--------|------:|
| Read | r | 4 |
| Write | w | 2 |
| Execute | x | 1 |

Permission combinations:

| Number | Permission |
|--------:|------------|
| 7 | rwx |
| 6 | rw- |
| 5 | r-x |
| 4 | r-- |
| 3 | -wx |
| 2 | -w- |
| 1 | --x |
| 0 | --- |

Example:

```text
rwxr-xr-x
```

means

```
Owner  : rwx
Group  : r-x
Others : r-x
```

---

# Hard Link Count

Example:

```bash
ls -l
```

Output:

```text
drwxr-xr-x 20 subodh_wsl subodh_wsl 4096 devops_journey
```

The number after the permissions (`20`) is the hard link count.

For directories:

```
Hard Links = 2 + Number of Subdirectories
```

The two default links are:

- `.`
- `..`

Every subdirectory increases the count by one.

---

# chmod (Change Mode)

Used to modify permissions.

Syntax:

```bash
chmod permissions filename
```

Permission targets:

| Symbol | Meaning |
|--------|---------|
| u | User (Owner) |
| g | Group |
| o | Others |
| a | All Users |

Operations:

| Symbol | Meaning |
|--------|---------|
| + | Add Permission |
| - | Remove Permission |
| = | Set Permission |

---

## Remove Owner Write Permission

```bash
chmod u-w file1.txt
```

Before:

```
rw-r--r--
```

After:

```
r--r--r--
```

---

## Add Owner Write Permission

```bash
chmod u+w file1.txt
```

---

## Add Execute Permission

```bash
chmod +x script.sh
```

Example result:

```
rwxr-xr-x
```

---

# Numeric chmod

## 644

```bash
chmod 644 file1.txt
```

Result:

```
rw-r--r--
```

---

## 755

```bash
chmod 755 script.sh
```

Result:

```
rwxr-xr-x
```

---

## 700

```bash
chmod 700 script.sh
```

Result:

```
rwx------
```

Only the owner has access.

---

# Running Shell Scripts

## Execute Directly

```bash
./script.sh
```

Requirements:

- Execute permission
- Valid shebang

Example:

```bash
#!/bin/bash

echo "Hello World"
```

---

## Execute Using Bash

```bash
bash script.sh
```

This works even if execute permission is not set because Bash reads the file directly.

---

# sudo

Run commands as the root (administrator) user.

```bash
sudo command
```

Example:

```bash
sudo ls /root
```

Check current user:

```bash
whoami
```

Become root temporarily:

```bash
sudo whoami
```

Output:

```
root
```

---

# Users and Groups

Display groups:

```bash
groups
```

Example:

```
subodh_wsl adm cdrom sudo dip plugdev users
```

Display detailed identity:

```bash
id
```

Example:

```
uid=1000(subodh_wsl)
gid=1000(subodh_wsl)
groups=1000(subodh_wsl),27(sudo)
```

---

# Home Directory vs Root

Current user's home:

```bash
ls ~
```

Equivalent to:

```
/home/subodh_wsl
```

Root user's home:

```bash
sudo ls /root
```

These are different directories.

---

# umask

`umask` controls the default permissions of newly created files and directories.

View current value:

```bash
umask
```

Example:

```
0022
```

Symbolic view:

```bash
umask -S
```

Output:

```
u=rwx,g=rx,o=rx
```

---

## Default Permissions

Files start as:

```
666
```

Directories start as:

```
777
```

The umask removes permissions.

Example:

```
666
-022
----
644
```

Result:

```
rw-r--r--
```

Directory example:

```
777
-022
----
755
```

Result:

```
rwxr-xr-x
```

Change umask:

```bash
umask 077
```

New files become:

```
600
```

---

# chown (Change Owner)

Change the owner of a file.

```bash
sudo chown root file1.txt
```

Restore ownership:

```bash
sudo chown subodh_wsl file1.txt
```

---

# chgrp (Change Group)

Change a file's group.

First create a practice group:

```bash
sudo groupadd devops
```

Verify:

```bash
grep devops /etc/group
```

Change group:

```bash
sudo chgrp devops file1.txt
```

Check:

```bash
ls -l
```

Example:

```text
-rw-r--r-- 1 subodh_wsl devops file1.txt
```

---

# Change Owner and Group Together

```bash
sudo chown root:devops file1.txt
```

Verify:

```bash
ls -l
```

Restore:

```bash
sudo chown subodh_wsl:subodh_wsl file1.txt
```

Remove the practice group:

```bash
sudo groupdel devops
```

---

# Commands Practised

```bash
ls -l
chmod
touch
mkdir
whoami
groups
id
sudo
umask
umask -S
chown
chgrp
groupadd
groupdel
grep
pwd
cd
```

---

# Mini Lab

Create a file:

```bash
touch deploy.sh
```

Make it executable:

```bash
chmod +x deploy.sh
```

Set permission:

```bash
chmod 755 deploy.sh
```

Check:

```bash
ls -l deploy.sh
```

Create a group:

```bash
sudo groupadd devops
```

Assign group:

```bash
sudo chgrp devops deploy.sh
```

Check:

```bash
ls -l deploy.sh
```

Change owner and group:

```bash
sudo chown root:devops deploy.sh
```

Restore:

```bash
sudo chown subodh_wsl:subodh_wsl deploy.sh
```

Delete the practice group:

```bash
sudo groupdel devops
```

---

# Key Takeaways

- Linux permissions follow the **Owner → Group → Others** model.
- `chmod` changes permissions.
- `chown` changes ownership.
- `chgrp` changes the group.
- `sudo` executes commands with administrator privileges.
- `umask` determines default permissions for newly created files.
- Shell scripts generally require execute permission when run using `./script.sh`.
- Proper permissions are critical for securing Linux systems and DevOps environments.

---

# Next Topic

**03 – Linux Processes, Package Management & Shell Environment**
