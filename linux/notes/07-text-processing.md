# 07 - Linux Text Processing

## Overview

Text processing is one of the most important Linux skills for DevOps engineers. It is used to search logs, filter output, extract information, replace text, count records, and automate repetitive tasks.

---

# grep

Searches for text inside files.

### Syntax

```bash
grep "text" filename
```

### Example

```bash
grep "ERROR" app.log
```

Output

```
ERROR Database connection failed
ERROR User not found
```

---

## Common grep Options

### Ignore case

```bash
grep -i "error" app.log
```

Matches `error`, `ERROR`, `Error`, etc.

---

### Show line numbers

```bash
grep -n "ERROR" app.log
```

Output

```
3:ERROR Database connection failed
6:ERROR User not found
```

---

### Count matches

```bash
grep -c "ERROR" app.log
```

Output

```
2
```

---

### Search recursively

```bash
grep -r "ERROR" .
```

Searches every file inside the current directory.

---

# Pipes (`|`)

Pipes send the output of one command to another.

### Syntax

```bash
command1 | command2
```

### Example

```bash
cat app.log | grep ERROR
```

The output of `cat` becomes the input of `grep`.

---

# Redirection

## Overwrite a file

```bash
echo "Hello" > notes.txt
```

Creates the file or replaces its contents.

---

## Append to a file

```bash
echo "World" >> notes.txt
```

Adds new content without deleting existing data.

---

# head

Displays the beginning of a file.

```bash
head app.log
```

First 10 lines.

Show only first 3 lines.

```bash
head -3 app.log
```

---

# tail

Displays the end of a file.

```bash
tail app.log
```

Last 10 lines.

Show last 3 lines.

```bash
tail -3 app.log
```

Monitor a file continuously.

```bash
tail -f app.log
```

Useful for watching logs in real time.

---

# wc (Word Count)

Counts lines, words, and characters.

Count words

```bash
wc -w app.log
```

Count lines

```bash
wc -l app.log
```

Count characters

```bash
wc -m app.log
```

---

# sort

Sorts file contents alphabetically.

```bash
sort names.txt
```

---

# uniq

Removes duplicate consecutive lines.

```bash
sort names.txt | uniq
```

Count duplicates.

```bash
sort names.txt | uniq -c
```

---

# cut

Extracts specific columns from delimited files.

Example CSV

```
Subodh,21,Nepal
Alice,25,USA
Bob,30,Canada
```

Display ages.

```bash
cut -d "," -f2 users.csv
```

Display countries.

```bash
cut -d "," -f3 users.csv
```

---

# sed

Searches and replaces text.

Replace first occurrence.

```bash
sed 's/ERROR/SUCCESS/' app.log
```

Replace all occurrences.

```bash
sed 's/ERROR/SUCCESS/g' app.log
```

Ignore case.

```bash
sed 's/error/SUCCESS/I' app.log
```

Modify the original file.

```bash
sed -i 's/ERROR/SUCCESS/g' app.log
```

---

# awk

Processes text column by column.

Print first column.

```bash
awk '{print $1}' app.log
```

Print first and second columns.

```bash
awk '{print $1,$2}' app.log
```

Count total lines.

```bash
awk 'END {print NR}' app.log
```

---

# Practical Script

Create a script to search for errors recursively.

**find-errors.sh**

```bash
#!/bin/bash

grep -r "ERROR" ..
```

Make executable.

```bash
chmod +x find-errors.sh
```

Run.

```bash
./find-errors.sh
```

---

# Real DevOps Use Cases

- Searching application logs for errors
- Monitoring server logs
- Filtering command output
- Extracting fields from CSV files
- Replacing configuration values
- Counting log entries
- Finding duplicate records
- Parsing system logs
- Preparing data for automation scripts

---

# Commands Learned

| Command | Purpose |
|---------|---------|
| grep | Search text |
| grep -i | Ignore case |
| grep -n | Show line numbers |
| grep -c | Count matches |
| grep -r | Recursive search |
| \| | Pipe output |
| > | Overwrite file |
| >> | Append to file |
| head | Show first lines |
| tail | Show last lines |
| tail -f | Monitor logs live |
| wc | Count words, lines, characters |
| sort | Sort data |
| uniq | Remove duplicate lines |
| cut | Extract columns |
| sed | Replace text |
| awk | Process columns and records |

---

## Summary

Linux text processing tools are essential for every DevOps engineer. Commands like `grep`, `sed`, `awk`, `cut`, `sort`, and `wc` help analyze logs, manipulate files, automate repetitive tasks, and troubleshoot systems efficiently.
