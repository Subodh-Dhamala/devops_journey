# Git & GitHub

> A practical guide to using Git and GitHub for version control, collaboration, and software development.

---

# Table of Contents

* What is Git?
* What is GitHub?
* Git vs GitHub
* Why We Use Git
* Installing Git
* Initial Git Configuration
* Creating Repositories
* Cloning Existing Repositories
* Basic Git Workflow
* Understanding Git Areas
* Checking Repository Status
* Viewing Commit History
* Working with Branches
* Merging Branches
* Merge Conflicts
* Working with Remote Repositories
* GitHub Collaboration Workflow
* Pull Requests
* Conventional Commits
* Tags & Releases
* Best Practices
* Undoing Changes
* Useful Git Commands
* Daily Workflow
* Common Problems

---

# What is Git?

Git is a distributed version control system used to track changes in source code. It allows us to save project history, collaborate with others, create different development branches, and restore previous versions whenever needed.

### Features

* Tracks every change
* Maintains complete project history
* Supports multiple developers
* Fast and lightweight
* Works offline
* Easy rollback

---

# What is GitHub?

GitHub is a cloud platform that hosts Git repositories.

It allows us to:

* Store repositories online
* Collaborate with developers
* Review code using Pull Requests
* Track issues
* Manage releases
* Run CI/CD pipelines

---

# Git vs GitHub

| Git                    | GitHub                        |
| ---------------------- | ----------------------------- |
| Version Control System | Hosting Platform              |
| Installed locally      | Cloud based                   |
| Tracks code history    | Stores repositories online    |
| Works without internet | Requires internet for syncing |

---

# Why We Use Git

* Keep project history
* Collaborate with teams
* Recover previous versions
* Manage multiple features
* Experiment safely
* Release software confidently

---

# Installing Git

Ubuntu

```bash
sudo apt update
sudo apt install git
```

Windows

Download from:

https://git-scm.com/

---

# Initial Git Configuration

```bash
git config --global user.name "Subodh Dhamala"

git config --global user.email "example@email.com"

git config --global init.defaultBranch main
```

Verify

```bash
git config --list
```

---

# Creating a Repository

```bash
mkdir project

cd project

git init
```

Git creates a hidden `.git` directory which stores all repository information.

---

# Cloning an Existing Repository

```bash
git clone https://github.com/user/project.git
```

Move inside repository

```bash
cd project
```

---

# Basic Git Workflow

```
Create/Edit File

↓

git status

↓

git add

↓

git commit

↓

git push
```

---

# Understanding Git Areas

```
Working Directory

↓

Staging Area

↓

Local Repository

↓

Remote Repository
```

### Working Directory

Current project files.

### Staging Area

Files prepared for the next commit.

### Local Repository

Commits stored on our computer.

### Remote Repository

Repository hosted on GitHub.

---

# Checking Repository Status

```bash
git status
```

Shows

* Modified files
* Untracked files
* Staged files
* Current branch

---

# Adding Files

Single file

```bash
git add file.txt
```

All files

```bash
git add .
```

---

# Commit Changes

```bash
git commit -m "feat: add authentication"
```

A commit saves a snapshot of the project.

---

# Viewing History

Compact

```bash
git log --oneline
```

Detailed

```bash
git log
```

Graph

```bash
git log --graph --oneline --all
```

---

# Working with Branches

List branches

```bash
git branch
```

Create branch

```bash
git branch feature/login
```

Switch branch

```bash
git checkout feature/login
```

Create and switch

```bash
git checkout -b feature/login
```

Delete

```bash
git branch -d feature/login
```

---

# Merging Branches

Switch to main

```bash
git checkout main
```

Merge

```bash
git merge feature/login
```

---

# Merge Conflicts

Conflicts occur when two branches modify the same lines.

Resolve by

* Editing conflicting code
* Removing conflict markers
* Saving file
* Adding resolved file

```bash
git add .

git commit
```

---

# Remote Repositories

View remotes

```bash
git remote -v
```

Add remote

```bash
git remote add origin URL
```

Push first time

```bash
git push -u origin main
```

Push later

```bash
git push
```

Fetch

```bash
git fetch
```

Pull

```bash
git pull
```

---

# GitHub Collaboration Workflow

1. Clone repository

```bash
git clone URL
```

2. Create feature branch

```bash
git checkout -b feature/profile
```

3. Make changes

4. Stage files

```bash
git add .
```

5. Commit

```bash
git commit -m "feat(profile): update avatar"
```

6. Push

```bash
git push origin feature/profile
```

7. Open Pull Request

8. Review code

9. Merge into main

10. Delete branch

---

# Pull Requests

A Pull Request (PR) is a request to merge one branch into another.

Typical workflow

Feature Branch

↓

Push

↓

Open Pull Request

↓

Code Review

↓

Approve

↓

Merge

↓

Delete Branch

---

# Conventional Commits

Using consistent commit messages makes project history easier to understand.

### Common Types

```
feat
```

New feature

Example

```bash
feat: add payment gateway
```

---

```
fix
```

Bug fix

```bash
fix: resolve login validation
```

---

```
docs
```

Documentation

```bash
docs: update README
```

---

```
style
```

Formatting only

```bash
style: format code
```

---

```
refactor
```

Improve code without changing behavior

```bash
refactor: simplify auth service
```

---

```
test
```

Testing

```bash
test: add user service tests
```

---

```
chore
```

Maintenance

```bash
chore: update dependencies
```

---

```
ci
```

CI/CD

```bash
ci: add GitHub Actions workflow
```

---

```
perf
```

Performance improvements

```bash
perf: optimize search query
```

---

# Tags

Create tag

```bash
git tag v1.0.0
```

Push tags

```bash
git push origin --tags
```

List tags

```bash
git tag
```

Tags are commonly used for software releases.

---

# Best Practices

## Keep Commits Small

Each commit should represent one logical change.

---

## Write Meaningful Commit Messages

Good

```
fix(auth): validate expired tokens
```

Bad

```
updated
```

---

## One Branch Per Feature

Each feature should have its own branch.

Examples

```
feature/login

feature/payment

bugfix/profile

hotfix/token
```

---

## Pull Frequently

```bash
git pull
```

This reduces merge conflicts.

---

## Never Commit Broken Code

Always verify the project builds and tests successfully before committing.

---

## Review Code Before Merging

Use Pull Requests to review code before it reaches the main branch.

---

## Avoid Committing Dependencies

Do not commit folders like:

```
node_modules/

vendor/

dist/

build/
```

Use package managers instead.

---

## Use Tags for Releases

Examples

```
v1.0.0

v1.1.0

v2.0.0
```

---

# Undoing Changes

Discard file changes

```bash
git restore file.txt
```

Unstage

```bash
git restore --staged file.txt
```

Undo last commit

```bash
git reset --soft HEAD~1
```

Reset completely

```bash
git reset --hard HEAD~1
```

Temporarily save work

```bash
git stash
```

Restore stash

```bash
git stash pop
```

---

# Useful Git Commands

| Command       | Purpose             |
| ------------- | ------------------- |
| git init      | Create repository   |
| git clone     | Copy repository     |
| git status    | Check status        |
| git add       | Stage files         |
| git commit    | Save snapshot       |
| git log       | View history        |
| git branch    | Manage branches     |
| git checkout  | Switch branch       |
| git merge     | Merge branches      |
| git fetch     | Download updates    |
| git pull      | Fetch + Merge       |
| git push      | Upload commits      |
| git remote -v | View remotes        |
| git stash     | Save temporary work |
| git tag       | Create release tags |

---

# Daily Workflow

```text
Pull latest code

↓

Create feature branch

↓

Write code

↓

git status

↓

git add .

↓

git commit

↓

git push

↓

Open Pull Request

↓

Review

↓

Merge

↓

Delete feature branch
```

---

# Common Problems

## Wrong Branch

```bash
git checkout correct-branch
```

---

## Forgot to Stage

```bash
git add .
git commit
```

---

## Forgot Last Commit Message

```bash
git commit --amend
```

---

## Pull Before Push

```bash
git pull origin main
```

---

## Merge Conflict

Resolve the conflicting code manually, then:

```bash
git add .

git commit
```

---

# Summary

Git is used to track changes locally, while GitHub allows us to collaborate and store repositories online. By following consistent branching strategies, writing meaningful commit messages, reviewing code through Pull Requests, and using tags for releases, we can keep projects organized, maintainable, and easy to collaborate on.
