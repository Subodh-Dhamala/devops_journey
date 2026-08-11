# GitHub Actions CI/CD with Docker and SSH

Complete guide for deploying a Dockerized application automatically using GitHub Actions, SSH, and Docker Compose.

## 1. What We Are Building

The goal is:

```text
Developer
   |
   | git push
   v
GitHub Repository
   |
   | triggers workflow
   v
GitHub Actions
   |
   | SSH
   v
Linux Server
   |
   | git pull
   v
Docker Compose
   |
   v
Docker Containers
   |
   v
Running Application
```

Instead of manually connecting to the server and running:

```bash
git pull
docker compose up -d --build
```

GitHub Actions will do it automatically.

---

# 2. Technologies

We use:

* Git
* GitHub
* GitHub Actions
* YAML
* Linux
* SSH
* Docker
* Docker Compose
* GitHub Secrets
* Node.js/Express example application

---

# 3. Project Structure

Example project:

```text
my-app/
├── backend/
│   ├── package.json
│   ├── package-lock.json
│   ├── src/
│   │   └── server.js
│   └── Dockerfile
│
├── docker-compose.yml
│
└── .github/
    └── workflows/
        └── deploy.yml
```

---

# 4. Create a Small Application

Create the project:

```bash
mkdir my-app
cd my-app
mkdir backend
cd backend
npm init -y
npm install express
```

Create:

```text
backend/src/server.js
```

Example:

```javascript
const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.send("Hello from Docker CI/CD!");
});

app.listen(3000, "0.0.0.0", () => {
  console.log("Server running on port 3000");
});
```

Update `package.json`:

```json
{
  "scripts": {
    "start": "node src/server.js"
  }
}
```

---

# 5. Create the Dockerfile

Create:

```text
backend/Dockerfile
```

```dockerfile
FROM node:22-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
```

Meaning:

```text
FROM
→ choose base image

WORKDIR
→ working directory inside container

COPY
→ copy files into image

RUN
→ execute command while building image

EXPOSE
→ document application port

CMD
→ command executed when container starts
```

---

# 6. Create Docker Compose

At the project root:

```text
docker-compose.yml
```

```yaml
services:

  backend:
    build: ./backend
    ports:
      - "3000:3000"
```

This means:

```text
Host port 3000
      |
      v
Container port 3000
```

Run locally:

```bash
docker compose up --build
```

Check:

```text
http://localhost:3000
```

Stop:

```bash
docker compose down
```

---

# 7. Test the Application Locally

Before CI/CD, make sure the application itself works.

Run:

```bash
docker compose up --build
```

Check:

```text
http://localhost:3000
```

You should see:

```text
Hello from Docker CI/CD!
```

Stop it:

```bash
docker compose down
```

Only continue when the application works locally.

---

# 8. Create the Git Repository

From the project root:

```bash
git init
```

Create `.gitignore`:

```text
node_modules/
.env
```

Then:

```bash
git add .
git commit -m "feat: initial app"
```

Create a repository on GitHub.

Connect it:

```bash
git remote add origin https://github.com/YOUR_USERNAME/my-app.git
```

Push:

```bash
git branch -M main
git push -u origin main
```

---

# 9. Create the Server

For the real deployment we need a Linux server.

A small Ubuntu server is enough.

The server needs:

```text
Ubuntu
Docker
Docker Compose
Git
SSH
```

The server architecture is:

```text
Internet
   |
   v
Ubuntu Server
   |
   +-- Git
   +-- Docker
   +-- Docker Compose
   |
   v
Application Containers
```

For learning without a paid VPS, the server-side commands can first be practiced in WSL.

A real public server is needed later for GitHub Actions to SSH into it directly.

---

# 10. Connect to the Server with SSH

From your computer:

```bash
ssh username@SERVER_IP
```

Example:

```bash
ssh ubuntu@203.0.113.10
```

Meaning:

```text
ssh
 ↓
connect using SSH

ubuntu
 ↓
server user

203.0.113.10
 ↓
server IP
```

After successful login:

```text
Your Computer
      |
      | SSH
      v
Ubuntu Server
```

---

# 11. Update the Server

On Ubuntu:

```bash
sudo apt update
sudo apt upgrade -y
```

---

# 12. Install Git

```bash
sudo apt install git -y
```

Check:

```bash
git --version
```

---

# 13. Install Docker

Install Docker using the official Docker installation method.

Verify:

```bash
docker --version
```

Check Compose:

```bash
docker compose version
```

---

# 14. Clone the Project on the Server

On the server:

```bash
git clone https://github.com/YOUR_USERNAME/my-app.git
```

Enter the project:

```bash
cd my-app
```

Test it manually:

```bash
docker compose up -d --build
```

Check:

```bash
docker compose ps
```

If everything works, the application is running on the server.

---

# 15. Why Do We Need SSH for CI/CD?

Normally we manually do:

```text
Computer
   |
   | SSH
   v
Server
   |
   | git pull
   | docker compose up -d --build
   v
Application
```

We want GitHub Actions to perform those commands automatically.

So:

```text
GitHub Actions
      |
      | SSH
      v
Server
      |
      | git pull
      | docker compose up -d --build
      v
Application
```

---

# 16. Create an SSH Key for GitHub Actions

We should not give GitHub our personal SSH password.

Instead, create a dedicated SSH key pair.

On your computer:

```bash
ssh-keygen -t ed25519 -C "github-actions"
```

This creates:

```text
Private key
Public key
```

The important rule is:

```text
PRIVATE KEY
→ GitHub Secret

PUBLIC KEY
→ Server
```

Never commit the private key to Git.

---

# 17. Put the Public Key on the Server

The public key looks like:

```text
ssh-ed25519 AAAA... github-actions
```

Add it to:

```text
~/.ssh/authorized_keys
```

For example:

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys
```

Paste the public key.

Then:

```bash
chmod 600 ~/.ssh/authorized_keys
```

Now the server trusts that key.

---

# 18. Test SSH Using the Key

From your computer:

```bash
ssh -i path/to/private-key username@SERVER_IP
```

If it works without asking for the server password, the key authentication is working.

This is important before creating the GitHub Actions workflow.

---

# 19. GitHub Secrets

Never put these directly into:

```text
deploy.yml
```

Do NOT do:

```yaml
server_ip: 203.0.113.10
password: mypassword
private_key: my-private-key
```

Instead use GitHub Secrets.

Go to:

```text
GitHub Repository
→ Settings
→ Secrets and variables
→ Actions
→ New repository secret
```

Create:

```text
SERVER_HOST
SERVER_USER
SERVER_SSH_KEY
```

Example:

```text
SERVER_HOST
203.0.113.10

SERVER_USER
ubuntu

SERVER_SSH_KEY
-----BEGIN OPENSSH PRIVATE KEY-----
...
-----END OPENSSH PRIVATE KEY-----
```

Secrets are accessed using:

```yaml
${{ secrets.SERVER_HOST }}
```

---

# 20. What Is a GitHub Actions Workflow?

A workflow is a YAML file that tells GitHub Actions what to do.

Location:

```text
.github/workflows/deploy.yml
```

Basic structure:

```yaml
name: Deploy

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Deploy
        run: echo "Deploying..."
```

---

# 21. Important GitHub Actions Keywords

## `name`

Names the workflow:

```yaml
name: Deploy
```

---

## `on`

Defines the trigger:

```yaml
on:
  push:
    branches:
      - main
```

Meaning:

```text
push to main
      ↓
run workflow
```

---

## `jobs`

Defines jobs:

```yaml
jobs:
  deploy:
```

`deploy` is our job ID.

---

## `runs-on`

Defines the runner:

```yaml
runs-on: ubuntu-latest
```

GitHub provides a temporary Ubuntu machine.

---

## `steps`

Defines tasks:

```yaml
steps:
```

---

## `uses`

Uses an existing GitHub Action:

```yaml
uses: actions/checkout@v4
```

---

## `run`

Runs a shell command:

```yaml
run: npm test
```

---

## `with`

Provides inputs to an Action:

```yaml
with:
  node-version: 22
```

---

## `env`

Defines environment variables:

```yaml
env:
  NODE_ENV: production
```

---

## `needs`

Makes a job depend on another:

```yaml
needs: build
```

---

## `if`

Runs something conditionally:

```yaml
if: github.ref == 'refs/heads/main'
```

---

# 22. First Simple Workflow

Create:

```text
.github/workflows/test.yml
```

```yaml
name: Test

on:
  push:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Show files
        run: ls

      - name: Show message
        run: echo "GitHub Actions is working!"
```

Commit:

```bash
git add .
git commit -m "ci: add github actions"
git push
```

Go to:

```text
GitHub
→ Actions
```

You should see the workflow running.

---

# 23. How GitHub Actions Actually Works

When you push:

```text
git push
    |
    v
GitHub
    |
    | detects push to main
    v
Workflow starts
    |
    v
GitHub creates runner
    |
    v
Checkout repository
    |
    v
Execute steps
    |
    v
Workflow succeeds/fails
```

The runner is temporary.

It is not your server.

This distinction is important:

```text
GitHub Actions Runner
        ≠
Your Deployment Server
```

---

# 24. Build the Real Deployment Workflow

Now create:

```text
.github/workflows/deploy.yml
```

Example:

```yaml
name: Deploy

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Connect and deploy
        uses: appleboy/ssh-action@v1.2.2
        with:
          host: ${{ secrets.SERVER_HOST }}
          username: ${{ secrets.SERVER_USER }}
          key: ${{ secrets.SERVER_SSH_KEY }}
          script: |
            cd ~/my-app
            git pull origin main
            docker compose up -d --build
```

The workflow means:

```text
Push to main
     |
     v
GitHub Actions
     |
     v
Start Ubuntu runner
     |
     v
SSH into server
     |
     v
cd ~/my-app
     |
     v
git pull
     |
     v
docker compose up -d --build
     |
     v
New version running
```

---

# 25. What Happens on the Server?

Suppose we change:

```javascript
res.send("Version 2");
```

Then:

```bash
git add .
git commit -m "feat: update message"
git push
```

GitHub detects the push.

Then:

```text
GitHub Actions
      |
      v
SSH server
      |
      v
git pull
      |
      v
docker compose up -d --build
      |
      v
Docker rebuilds image
      |
      v
Container recreated
      |
      v
Version 2 is live
```

No manual deployment is required.

---

# 26. Why `git pull`?

The server has an older copy:

```text
Server
Version 1
```

GitHub has:

```text
Version 2
```

So:

```bash
git pull origin main
```

updates the server's working directory.

Then:

```bash
docker compose up -d --build
```

builds the new Docker image and starts the updated container.

---

# 27. Why `--build`?

Without:

```bash
docker compose up -d
```

Docker may reuse an existing image.

With:

```bash
docker compose up -d --build
```

Docker rebuilds the image from the updated Dockerfile/application files.

So:

```text
new source code
      |
      v
docker compose --build
      |
      v
new image
      |
      v
new container
```

---

# 28. Why `-d`?

```bash
-d
```

means:

```text
detached mode
```

The container continues running in the background.

Without it, the command stays attached to the terminal.

---

# 29. Deployment Flow

The complete flow is:

```text
Developer
   |
   | edit code
   v
Git
   |
   | git push
   v
GitHub
   |
   | trigger
   v
GitHub Actions
   |
   | SSH
   v
Linux Server
   |
   | git pull
   v
Updated source
   |
   | docker compose up -d --build
   v
Docker image
   |
   v
Docker container
   |
   v
Live application
```

---

# 30. GitHub Actions vs Server

This is extremely important.

## GitHub Actions Runner

Used for automation:

```text
checkout
test
build
security scans
Docker build
SSH deployment
```

## Deployment Server

Runs the actual application:

```text
Docker
Docker Compose
Application
Database
Redis
etc.
```

They are different machines.

```text
GitHub Actions Runner
        |
        | SSH
        v
Deployment Server
```

---

# 31. GitHub Actions Secrets

Secrets should contain sensitive information such as:

```text
SERVER_SSH_KEY
SERVER_PASSWORD
API_TOKEN
DOCKER_USERNAME
DOCKER_PASSWORD
```

Never commit:

```text
.env
private keys
passwords
API keys
tokens
```

Use:

```yaml
${{ secrets.NAME }}
```

---

# 32. Environment Variables

Example:

```yaml
env:
  NODE_ENV: production
```

Inside commands:

```bash
echo $NODE_ENV
```

For sensitive values:

```yaml
env:
  DATABASE_URL: ${{ secrets.DATABASE_URL }}
```

---

# 33. Docker Hub Integration

Instead of building only on the server, we can build an image in GitHub Actions.

Flow:

```text
GitHub
   |
   v
GitHub Actions
   |
   v
docker build
   |
   v
Docker image
   |
   v
Docker Hub
```

Then the server can pull the image:

```bash
docker pull USERNAME/my-app:latest
```

and run it.

---

# 34. Docker Hub Login

GitHub Actions can authenticate using secrets.

Example secrets:

```text
DOCKER_USERNAME
DOCKER_PASSWORD
```

A workflow can use Docker's login Action.

Conceptually:

```text
GitHub Actions
      |
      | login
      v
Docker Hub
      |
      | push
      v
my-app:latest
```

---

# 35. Image-Based Deployment

Another deployment model is:

```text
Developer
   |
   v
GitHub
   |
   v
GitHub Actions
   |
   v
Docker build
   |
   v
Docker Hub
   |
   v
Server
   |
   v
docker pull
   |
   v
docker compose up
```

This is often cleaner because the server doesn't need to build the image itself.

---

# 36. GitHub Actions CI + CD

CI means:

```text
Continuous Integration
```

Typical CI:

```text
push
 ↓
checkout
 ↓
install
 ↓
test
 ↓
build
```

CD means:

```text
Continuous Delivery / Deployment
```

Typical CD:

```text
successful CI
      ↓
Docker image
      ↓
deployment
      ↓
live application
```

Combined:

```text
git push
   |
   v
CI
 ├── test
 ├── build
 └── security
   |
   v
CD
 ├── Docker
 ├── push image
 └── deploy
```

---

# 37. Adding a Test Job

A better workflow separates testing from deployment:

```yaml
name: CI/CD

on:
  push:
    branches:
      - main

jobs:

  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: 22

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test

  deploy:
    needs: test
    runs-on: ubuntu-latest

    steps:
      - name: Deploy
        uses: appleboy/ssh-action@v1.2.2
        with:
          host: ${{ secrets.SERVER_HOST }}
          username: ${{ secrets.SERVER_USER }}
          key: ${{ secrets.SERVER_SSH_KEY }}
          script: |
            cd ~/my-app
            git pull origin main
            docker compose up -d --build
```

The important part:

```yaml
needs: test
```

means:

```text
test
  |
  | success
  v
deploy
```

If testing fails:

```text
test
  |
  X
deploy does NOT run
```

This is a fundamental CI/CD idea.

---

# 38. Complete Pipeline

Our final conceptual pipeline becomes:

```text
                    git push
                       |
                       v
                    GitHub
                       |
                       v
               GitHub Actions
                       |
              ┌────────┴────────┐
              |                 |
              v                 v
             Test            Security
              |                 |
              └────────┬────────┘
                       |
                    success
                       |
                       v
                 Docker Build
                       |
                       v
                  Docker Hub
                       |
                       v
                 Deploy Server
                       |
                       v
                Docker Compose
                       |
                       v
                 Live Application
```

---

# 39. Rollback

Suppose:

```text
Version 1 → working
Version 2 → broken
```

Git history still contains Version 1.

We can identify the previous commit:

```bash
git log --oneline
```

Example:

```text
abc1234 version 2
def5678 version 1
```

Rollback can mean returning the deployment to a known good version.

One approach is:

```bash
git checkout def5678
docker compose up -d --build
```

In production, rollback should be designed carefully rather than casually changing the server's branch.

With Docker images, an even cleaner strategy is to deploy versioned image tags:

```text
my-app:1.0
my-app:1.1
my-app:1.2
```

Then you can redeploy:

```text
my-app:1.1
```

instead of:

```text
my-app:latest
```

---

# 40. Health Checks

A deployment should not only say:

```text
docker compose up
```

and assume everything works.

We can check:

```bash
docker compose ps
```

and:

```bash
curl http://localhost:3000
```

A better deployment pipeline verifies that the application actually responds.

Concept:

```text
Deploy
  |
  v
Container starts
  |
  v
Health check
  |
  +---- success → deployment successful
  |
  +---- failure → deployment failed
```

---

# 41. What We Learn from the VPS Video

The video uses:

```text
Hostinger
SSH
Docker
Docker Compose
GitHub Actions
```

Our learning version is:

```text
Linux/WSL
SSH concepts
Docker
Docker Compose
GitHub Actions
Render/Docker Hub when a public deployment is needed
```

The major thing a local WSL environment cannot perfectly reproduce is:

```text
GitHub Actions
      |
      | public internet
      v
your private WSL machine
```

A real public server has a public network endpoint.

---

# 42. WSL Practice

We can practice server commands in WSL:

```bash
sudo apt update
```

```bash
docker --version
```

```bash
docker compose version
```

```bash
git clone ...
```

```bash
docker compose up -d --build
```

```bash
docker compose ps
```

```bash
docker compose logs
```

```bash
docker compose down
```

This teaches the actual Linux/Docker deployment commands.

For a real GitHub Actions → SSH deployment, use a publicly reachable Linux server.

---

# 43. Render Alternative

If a public server is unavailable, Render can provide a public deployment without requiring a paid VPS.

Concept:

```text
GitHub
   |
   v
GitHub Actions
   |
   v
Docker image
   |
   v
Render
   |
   v
Public application
```

This does not teach the VPS/SSH part because Render manages the server infrastructure for you.

Therefore:

```text
Render
→ public deployment practice

WSL
→ Linux/server/Docker practice

Real VPS
→ SSH + real server deployment
```

---

# 44. Security: SAST

SAST means:

```text
Static Application Security Testing
```

It examines source code.

Example:

```text
Source code
     |
     v
SonarQube
     |
     v
security/code findings
```

Think:

```text
SAST = inspect the code
```

---

# 45. Security: DAST

DAST means:

```text
Dynamic Application Security Testing
```

It tests the running application.

Example:

```text
Running application
       ^
       |
    OWASP ZAP
```

Think:

```text
DAST = test the running application
```

---

# 46. Final CI/CD Architecture

```text
                         Developer
                             |
                             | git push
                             v
                          GitHub
                             |
                             v
                    GitHub Actions
                             |
             ┌───────────────┼────────────────┐
             |               |                |
             v               v                v
           Tests           SAST             Build
             |           SonarQube        Docker image
             |               |                |
             └───────────────┴────────────────┘
                             |
                          Success
                             |
                             v
                       Docker Hub
                             |
                             v
                     Deployment Server
                             |
                       SSH / Pull
                             |
                             v
                      Docker Compose
                             |
                             v
                       Application
                             |
                             v
                         DAST
                       OWASP ZAP
```

---

# 47. Commands to Remember

## Git

```bash
git add .
git commit -m "message"
git push
git log --oneline
```

## Docker

```bash
docker build -t my-app .
docker images
docker ps
docker logs CONTAINER
```

## Docker Compose

```bash
docker compose up -d --build
docker compose down
docker compose ps
docker compose logs
```

## SSH

```bash
ssh user@SERVER_IP
```

## GitHub Actions

Main workflow location:

```text
.github/workflows/deploy.yml
```

---

# 48. The Most Important Mental Model

Remember this:

```text
GitHub Actions
=
automation machine
```

```text
Server
=
machine running the application
```

```text
Docker
=
packages the application
```

```text
Docker Compose
=
defines/runs multiple containers
```

```text
SSH
=
secure connection to the server
```

```text
GitHub Secrets
=
secure storage for sensitive deployment values
```

```text
CI
=
test/build before deployment
```

```text
CD
=
automatically deliver/deploy the application
```

---

# 49. Final One-Line Flow

The entire project can be remembered as:

```text
git push → GitHub Actions → test → build → Docker → Docker Hub → SSH/server → Docker Compose → live app
```

And with security:

```text
git push
→ CI
→ SAST
→ Docker
→ deployment
→ DAST
→ live application
```

This is the foundation we will use before moving into more advanced DevOps topics such as Kubernetes, monitoring, and infrastructure automation.
# SAST and DAST — Security in GitHub Actions CI/CD

## 44. Security Testing in CI/CD

Security testing can be integrated directly into our GitHub Actions pipeline.

We use two important approaches:

```text
SAST
→ Static Application Security Testing
→ SonarQube
→ examines source code

DAST
→ Dynamic Application Security Testing
→ OWASP ZAP
→ examines the running application
```

The key difference:

```text
SAST
Source code
    ↓
SonarQube
    ↓
Find code/security problems
```

```text
DAST
Running application
    ↓
OWASP ZAP
    ↓
Find web/application vulnerabilities
```

---

# 45. Where They Fit in CI/CD

A complete pipeline can look like:

```text
Developer
    |
    | git push
    v
GitHub
    |
    v
GitHub Actions
    |
    v
SAST - SonarQube
    |
    v
Tests
    |
    v
Docker Build
    |
    v
Docker Hub
    |
    v
Deploy Application
    |
    v
Running Application
    |
    v
DAST - OWASP ZAP
    |
    v
Security Result
```

So:

```text
SonarQube
→ before/during build

OWASP ZAP
→ after the application is running
```

---

# 46. SAST

SAST stands for:

```text
Static Application Security Testing
```

Static means that the application does **not need to be running**.

SAST examines source code and related project files.

Example:

```text
JavaScript source
      ↓
SonarQube
      ↓
Analysis
      ↓
Issues
```

It can identify things such as:

* Bugs
* Vulnerabilities
* Security hotspots
* Code smells
* Duplicated code
* Maintainability problems
* Some insecure coding patterns

---

# 47. Why SAST?

Imagine we write:

```javascript
const query =
  "SELECT * FROM users WHERE id=" + req.query.id;
```

A static analyzer may recognize a potentially dangerous pattern.

The important idea is:

```text
Bad code
   ↓
detect early
   ↓
before deployment
```

This is much better than discovering a security problem after the application is already deployed.

---

# 48. SonarQube

SonarQube is a code quality and security analysis platform.

It analyzes our project and produces results such as:

```text
Bugs
Vulnerabilities
Security Hotspots
Code Smells
Duplications
Coverage
Quality Gate
```

Conceptually:

```text
Source Code
     |
     v
SonarQube Scanner
     |
     v
SonarQube
     |
     v
Analysis Results
```

---

# 49. SonarQube Server vs Scanner

This distinction is important.

SonarQube has two parts in our setup:

```text
SonarQube Server
→ receives/stores/displays analysis

SonarQube Scanner
→ analyzes the project and sends results
```

So:

```text
GitHub Actions
      |
      | scanner
      v
SonarQube Server
      |
      v
Dashboard
```

We don't necessarily need to install SonarQube directly on our operating system.

For learning, we can run the SonarQube server using Docker.

Conceptually:

```text
Your Computer
      |
      v
Docker
      |
      v
SonarQube Container
```

---

# 50. Running SonarQube with Docker

For local learning, SonarQube can be run as a Docker container.

The general idea is:

```text
Docker
   |
   v
SonarQube
   |
   v
Browser
```

After starting it, we can access its web interface locally.

The exact Docker configuration depends on the SonarQube version we choose.

The important architecture is:

```text
Project
   |
   v
Scanner
   |
   v
SonarQube Server
```

---

# 51. SonarQube Project

Our application becomes a SonarQube project.

Example:

```text
Project:
my-app
```

SonarQube analyzes:

```text
backend/
src/
package.json
etc.
```

and generates analysis results.

---

# 52. SonarQube Token

GitHub Actions needs permission to send analysis results to SonarQube.

Instead of putting a token directly in:

```text
deploy.yml
```

we store it in GitHub Secrets.

Example:

```text
SONAR_TOKEN
```

Access it using:

```yaml
${{ secrets.SONAR_TOKEN }}
```

Never commit the actual token into Git.

---

# 53. SonarQube URL

GitHub Actions also needs to know where the SonarQube server is.

For example:

```text
SONAR_HOST_URL
```

Conceptually:

```text
SONAR_HOST_URL
        |
        v
SonarQube Server
```

If SonarQube is running locally, the networking setup is different from a public SonarQube server.

This matters because a GitHub-hosted runner cannot automatically access:

```text
localhost
```

on your personal computer.

Remember:

```text
GitHub Actions runner
localhost
    ↓
GitHub's runner
```

not:

```text
your computer
```

Therefore, for GitHub Actions to access a SonarQube server, that server must be reachable from the runner, or we must use an appropriate hosted SonarQube service/setup.

---

# 54. SonarQube in GitHub Actions

A workflow can run a SonarQube scan.

Conceptually:

```yaml
- name: SonarQube Scan
  uses: SonarSource/sonarqube-scan-action@v6
```

The workflow provides the required configuration and authentication through environment variables/secrets.

Conceptually:

```text
GitHub Actions
      |
      v
SonarQube Scanner
      |
      | source analysis
      v
SonarQube Server
      |
      v
Security/quality results
```

---

# 55. Quality Gate

One of the important SonarQube concepts is the:

```text
Quality Gate
```

It determines whether the analyzed project meets defined quality/security conditions.

Conceptually:

```text
Analysis
   |
   v
Quality Gate
   |
   +---- PASS → continue pipeline
   |
   +---- FAIL → stop/reject pipeline
```

This allows security and quality checks to become part of CI rather than something developers remember to run manually.

---

# 56. SAST Summary

Remember:

```text
SAST
=
analyze source code
```

```text
SonarQube
=
tool/platform used for code quality and security analysis
```

```text
Scanner
=
performs analysis and sends results
```

```text
Quality Gate
=
decides whether the project meets configured conditions
```

---

# 57. DAST

DAST stands for:

```text
Dynamic Application Security Testing
```

Dynamic means that the application is **running**.

Instead of reading source code, DAST interacts with the application like an external attacker/tester.

Conceptually:

```text
Running Application
        ↑
        |
     DAST Tool
        |
        v
Security Testing
```

---

# 58. OWASP ZAP

OWASP ZAP is a web application security testing tool.

ZAP stands for:

```text
Zed Attack Proxy
```

It can be used to test running web applications for security issues.

Conceptually:

```text
Internet/Web
     |
     v
OWASP ZAP
     |
     v
Running Application
```

---

# 59. What Does ZAP Test?

Depending on configuration, ZAP can identify issues related to things such as:

* Cross-site scripting (XSS)
* SQL injection indicators
* Missing security headers
* Insecure cookies
* Authentication/session issues
* Exposed resources
* Other common web application vulnerabilities

DAST is especially useful because it sees the application from the outside.

---

# 60. SAST vs DAST

This distinction is extremely important.

|                   | SAST                                | DAST                                 |
| ----------------- | ----------------------------------- | ------------------------------------ |
| Full name         | Static Application Security Testing | Dynamic Application Security Testing |
| Tool              | SonarQube                           | OWASP ZAP                            |
| Looks at          | Source code                         | Running application                  |
| App running?      | No                                  | Yes                                  |
| Perspective       | Inside/code                         | Outside/attacker-like                |
| Finds             | Code-level issues                   | Runtime/web vulnerabilities          |
| Pipeline position | Before deployment/build             | After application is running         |

Easy memory:

```text
SAST
S = Static
→ Source code
```

```text
DAST
D = Dynamic
→ Deployed/running application
```

---

# 61. Why DAST Needs a Running Application

Suppose our application runs on:

```text
http://localhost:3000
```

ZAP needs something to attack/test.

So:

```text
Docker Compose
      |
      v
Application starts
      |
      v
http://localhost:3000
      |
      v
OWASP ZAP
      |
      v
Security scan
```

If the application is not running:

```text
ZAP
 ↓
nothing to test
```

---

# 62. Running OWASP ZAP with Docker

We can run ZAP using Docker.

Conceptually:

```text
Docker
   |
   +-- Application container
   |
   +-- ZAP container
```

The two containers need to be able to communicate.

This is where Docker networking becomes important.

For example:

```text
Docker network
      |
      +---- backend
      |
      +---- zap
```

ZAP can access the application using the Docker service/container networking setup.

---

# 63. Why `localhost` Can Become a Problem

Inside a container:

```text
localhost
```

means:

```text
this container
```

It does NOT automatically mean:

```text
another container
```

For example:

```text
ZAP container
localhost:3000
```

means port 3000 inside the ZAP container.

It does not necessarily mean the backend container.

With Docker Compose, services can communicate using their service names.

Example:

```yaml
services:

  backend:
    ...

  zap:
    ...
```

The ZAP container can communicate with the backend using:

```text
http://backend:3000
```

instead of:

```text
http://localhost:3000
```

This is an important Docker networking concept.

---

# 64. ZAP Scan Types

ZAP can be used in different ways.

A basic scan may discover the application and identify common security issues.

More aggressive scanning can actively attack endpoints.

This distinction matters because active security testing can have side effects.

For our learning project, we should start with a safe, controlled scan against our own application.

---

# 65. ZAP in GitHub Actions

The workflow can run ZAP after the application is available.

Conceptually:

```text
Build
  ↓
Start application
  ↓
ZAP scan
  ↓
Security report
```

A GitHub Action or Docker-based ZAP invocation can be used.

Conceptually:

```yaml
- name: OWASP ZAP Scan
  ...
```

The exact action/configuration depends on whether the application is:

```text
localhost on GitHub runner
```

or:

```text
public deployment URL
```

---

# 66. DAST Against a Deployed Application

After deployment:

```text
GitHub Actions
      |
      v
Deploy
      |
      v
Production/Staging App
      |
      v
OWASP ZAP
      |
      v
Security Scan
```

For example:

```text
https://staging.example.com
```

ZAP tests that URL.

A staging environment is often preferable to attacking production during automated testing.

---

# 67. DAST Against a Local Container

For our learning environment:

```text
GitHub Actions runner
       |
       +---- Docker
       |       |
       |       +---- backend
       |       |
       |       +---- zap
       |
       v
security scan
```

The application can be started temporarily for the scan.

Then the workflow can stop the containers after testing.

---

# 68. SAST and DAST Together

Now combine both:

```text
                 git push
                    |
                    v
             GitHub Actions
                    |
                    v
          ┌──────────────────┐
          │ SAST             │
          │ SonarQube        │
          │                  │
          │ Source code      │
          └────────┬─────────┘
                   |
                 PASS
                   |
                   v
                Tests
                   |
                   v
             Docker Build
                   |
                   v
              Deployment
                   |
                   v
          Running Application
                   |
                   v
          ┌──────────────────┐
          │ DAST             │
          │ OWASP ZAP        │
          │                  │
          │ Running app      │
          └────────┬─────────┘
                   |
                 PASS
                   |
                   v
             Deployment OK
```

---

# 69. What Gets Installed?

For our learning setup:

### SonarQube

We can run:

```text
SonarQube Server
→ Docker container
```

GitHub Actions uses:

```text
SonarQube Scanner/Action
```

### OWASP ZAP

We can run:

```text
OWASP ZAP
→ Docker container or GitHub Action
```

We don't need to install every tool directly into Windows.

---

# 70. What We Store as GitHub Secrets?

For SonarQube:

```text
SONAR_TOKEN
SONAR_HOST_URL
```

For deployment:

```text
SERVER_HOST
SERVER_USER
SERVER_SSH_KEY
```

For Docker Hub:

```text
DOCKER_USERNAME
DOCKER_PASSWORD
```

The exact secrets depend on our final architecture.

Never put sensitive values directly into:

```text
deploy.yml
```

---

# 71. Complete Security-Aware CI/CD Pipeline

Our final learning architecture becomes:

```text
Developer
    |
    | git push
    v
GitHub
    |
    v
GitHub Actions
    |
    v
Checkout
    |
    v
SonarQube SAST
    |
    +---- FAIL → stop
    |
    v
Automated Tests
    |
    +---- FAIL → stop
    |
    v
Docker Build
    |
    v
Docker Hub
    |
    v
Deploy
    |
    v
Application Running
    |
    v
OWASP ZAP DAST
    |
    +---- FAIL → report/fail according to policy
    |
    v
Deployment Complete
```

---

# 72. The Important Difference

Do not confuse these:

```text
SonarQube
→ "Is there something wrong/insecure in my code?"
```

```text
OWASP ZAP
→ "Can I find something wrong by interacting with the running application?"
```

They complement each other.

---

# 73. Simple Memory Trick

```text
SAST
S = Static
Source code
SonarQube
```

```text
DAST
D = Dynamic
Deployed/running application
OWASP ZAP
```

Or simply:

```text
SonarQube → Code
ZAP        → App
```

---

# 74. What We Will Actually Build

We will not stop at definitions.

Our practical progression will be:

```text
1. Create Node/Express app
        ↓
2. Dockerize it
        ↓
3. Docker Compose
        ↓
4. Git/GitHub
        ↓
5. GitHub Actions fundamentals
        ↓
6. CI workflow
        ↓
7. SonarQube SAST
        ↓
8. Docker image build
        ↓
9. Docker Hub push
        ↓
10. SSH deployment
        ↓
11. Application running
        ↓
12. OWASP ZAP DAST
        ↓
13. Complete CI/CD pipeline
```

The final result is a real pipeline rather than just memorized DevOps terminology.
