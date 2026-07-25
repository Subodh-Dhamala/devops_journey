# Linux Basics

## What is Linux?

Linux is a free and open-source operating system kernel used in servers, cloud platforms, embedded systems, and personal computers. Most modern DevOps tools and cloud servers run Linux, making it an essential skill for DevOps engineers.

---

## Why Learn Linux for DevOps?

- Most cloud servers run Linux.
- Docker containers are Linux-based.
- Kubernetes nodes commonly run Linux.
- CI/CD tools like Jenkins often run on Linux.
- Automation and scripting are primarily done in Linux environments.

---

## Commands Learned

### whoami
Displays the current logged-in user.

Example:
```bash
whoami
```

---

### uname
Displays system information.

Examples:

```bash
uname
uname -a
```

---

### pwd
Prints the current working directory.

```bash
pwd
```

---

### ls
Lists files and directories.

Examples:

```bash
ls
ls -la
ls *
```

---

### cd
Changes the current directory.

Examples:

```bash
cd
cd ..
cd folder_name
```

---

### mkdir
Creates directories.

```bash
mkdir test
mkdir -p parent/child
```

---

### touch
Creates empty files.

```bash
touch file.txt
```

---

### cp
Copies files or directories.

```bash
cp file1.txt file2.txt
cp -r folder1 folder2
```

---

### mv
Moves or renames files.

```bash
mv old.txt new.txt
mv file.txt folder/
```

---

### rm
Removes files.

```bash
rm file.txt
rm -i file.txt
rm -r folder
rm -rf folder
```

---

### rmdir
Removes empty directories.

```bash
rmdir folder
```

---

### cat
Displays file contents.

```bash
cat file.txt
cat > file.txt
```

Press **Ctrl + D** when finished entering text.

---

### nano
Simple terminal text editor.

```bash
nano file.txt
```

Useful shortcuts:

- Ctrl + O → Save
- Enter → Confirm
- Ctrl + X → Exit

---

### man
Displays command documentation.

```bash
man ls
man rm
```

Quit using:

```
q
```

---

### history
Displays previously executed commands.

```bash
history
```

---

### date

Displays the current date and time.

```bash
date
```

---

### cal

Displays a calendar.

```bash
cal
cal 2026
```

---

## Redirection

Overwrite a file:

```bash
echo "Hello" > file.txt
```

Append to a file:

```bash
echo "Another line" >> file.txt
```

---

## Commands Practised Today

- whoami
- uname
- pwd
- ls
- cd
- mkdir
- touch
- cp
- mv
- rm
- rmdir
- cat
- nano
- man
- history
- date
- cal
- echo
- > and >>

---

## Key Takeaways

- Linux is command-line focused.
- Everything is treated as a file.
- Commands can be combined to automate tasks.
- Reading the manual (`man`) is an important skill.
- Practising commands is more valuable than memorising them.

---

## Next Topic

Linux Permissions and Ownership
