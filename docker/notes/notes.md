# Docker Notes — From Beginner to Compose

## 1. What is Docker?

Docker is a platform used to package and run applications in isolated environments called **containers**.

Without Docker:

```text
Application
   ↓
Needs Node
Needs npm
Needs specific versions
Needs dependencies
Needs configuration
```

Different machines may have different environments, causing the **"works on my machine"** problem.

With Docker:

```text
Application
+ Dependencies
+ Runtime
+ Configuration
        ↓
     Docker Image
        ↓
     Container
```

The same image can run consistently on different machines.

---

# 2. Important Docker Terms

## Image

An **image** is a blueprint/template used to create containers.

Example:

```text
node:20
```

is a Node.js base image.

Our own image:

```text
my-backend
```

## Container

A **container** is a running instance of an image.

```text
Image
  ↓
Container
```

One image can create multiple containers.

## Dockerfile

A Dockerfile contains instructions for building a Docker image.

## Docker Registry

A registry stores Docker images.

Example: Docker Hub.

```text
Local machine
      ↓
docker push
      ↓
Docker Hub
      ↓
docker pull
      ↓
Another machine
```

---

# 3. Our Practice Project

We created a small full-stack Docker project:

```text
docker/
├── backend/
│   ├── Dockerfile
│   ├── package.json
│   ├── package-lock.json
│   └── src/
│       └── server.js
│
├── frontend/
│   ├── Dockerfile
│   └── index.html
│
└── docker-compose.yml
```

The backend is a small **Node.js + Express** application.

The frontend is a simple HTML page served by **Nginx**.

---

# 4. Backend Dockerfile

```dockerfile
FROM node:20

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
```

---

# 5. Dockerfile Instructions

## FROM

Specifies the base image.

```dockerfile
FROM node:20
```

Meaning:

> Start with an environment that already has Node.js 20.

---

## WORKDIR

Sets the working directory inside the container.

```dockerfile
WORKDIR /app
```

---

## COPY

Copies files from the build context into the image.

```dockerfile
COPY package*.json ./
```

Then:

```dockerfile
COPY . .
```

copies the rest of the application.

### Why copy package files first?

Docker caches layers.

```dockerfile
COPY package*.json ./
RUN npm install

COPY . .
```

If only `server.js` changes, Docker can reuse the cached `npm install` layer.

This makes rebuilding faster.

---

## RUN

Executes a command while **building** the image.

```dockerfile
RUN npm install
```

Remember:

```text
RUN → build time
CMD → container runtime
```

---

## EXPOSE

Documents the port used by the application.

```dockerfile
EXPOSE 3000
```

It does **not** publish the port to the host.

---

## CMD

Specifies the default command when the container starts.

```dockerfile
CMD ["npm", "start"]
```

Equivalent to:

```bash
npm start
```

---

# 6. `.dockerignore`

Similar to `.gitignore`.

Example:

```text
node_modules
.git
.env
npm-debug.log
```

It prevents unnecessary or sensitive files from being sent into the Docker build context.

---

# 7. Build the Backend Image

From the backend directory:

```bash
docker build -t my-backend .
```

Breakdown:

```text
docker build
    ↓
Build an image

-t my-backend
    ↓
Image name

.
    ↓
Current directory = build context
```

---

# 8. Run the Backend Container

```bash
docker run -d -p 3000:3000 my-backend
```

### `-d`

Runs in detached/background mode.

### `-p`

Maps:

```text
HOST_PORT:CONTAINER_PORT
```

Example:

```bash
-p 3000:3000
```

means:

```text
Host localhost:3000
        ↓
Container :3000
```

---

# 9. EXPOSE vs Port Mapping

Very important:

```dockerfile
EXPOSE 3000
```

means:

> The application uses port 3000 inside the container.

While:

```yaml
ports:
  - "3000:3000"
```

means:

> Publish container port 3000 through host port 3000.

Therefore:

```text
EXPOSE
   ↓
Documents container port

ports / -p
   ↓
Publishes port to host
```

---

# 10. Frontend Dockerization

We used a simple HTML frontend served by Nginx.

Frontend Dockerfile:

```dockerfile
FROM nginx:alpine

COPY ./index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

Nginx serves files from:

```text
/usr/share/nginx/html/
```

---

# 11. Frontend Port Mapping

We ran:

```bash
docker run -d -p 8080:80 --name frontend my-frontend
```

Meaning:

```text
Host localhost:8080
        ↓
Nginx container :80
```

The frontend is available at:

```text
http://localhost:8080
```

---

# 12. CORS

CORS means **Cross-Origin Resource Sharing**.

Our frontend and backend were running on different ports:

```text
Frontend:
http://localhost:8080

Backend:
http://localhost:3000
```

Different ports mean different origins.

Express can allow the frontend using CORS middleware:

```js
const cors = require("cors");

app.use(cors({
  origin: "http://localhost:8080"
}));
```

In production, allowed origins should normally be restricted.

---

# 13. Docker Compose

When multiple containers are involved, manually building and running each container becomes inconvenient.

Docker Compose lets us define the whole application in one YAML file.

Structure:

```text
docker/
├── backend/
├── frontend/
└── docker-compose.yml
```

---

# 14. docker-compose.yml

Our Compose file:

```yaml
services:
  backend:
    build: ./backend
    ports:
      - "3000:3000"

  frontend:
    build: ./frontend
    ports:
      - "8080:80"
    depends_on:
      - backend
```

---

# 15. `services`

```yaml
services:
```

Defines the services managed by Compose.

We have:

```yaml
backend:
frontend:
```

---

# 16. `build`

```yaml
backend:
  build: ./backend
```

Compose uses:

```text
./backend/Dockerfile
```

to build the backend image.

Similarly:

```yaml
frontend:
  build: ./frontend
```

uses:

```text
./frontend/Dockerfile
```

---

# 17. `ports`

Backend:

```yaml
ports:
  - "3000:3000"
```

Frontend:

```yaml
ports:
  - "8080:80"
```

So:

```text
localhost:3000 → backend container:3000

localhost:8080 → frontend container:80
```

---

# 18. `depends_on`

```yaml
depends_on:
  - backend
```

Means:

> Start the backend service before starting the frontend service.

Important:

`depends_on` controls **startup order**.

It does not guarantee that the backend application is fully ready.

For larger applications, healthchecks can be used.

---

# 19. Compose Service Names

We don't need to manually specify:

```yaml
container_name:
```

Compose automatically generates container names.

More importantly, service names work as DNS names inside the Compose network.

For example:

```text
backend
frontend
```

A container can reach the backend using:

```text
backend:3000
```

---

# 20. Docker Networking

Compose automatically creates a network for the services.

```text
          Docker Network
                 │
        ┌────────┴────────┐
        ↓                 ↓
    frontend           backend
       :80               :3000
```

Containers communicate using service names.

Example:

```text
frontend → backend:3000
```

## Important: localhost

Inside a container:

```text
localhost
```

means:

> This same container.

It does **not** mean another container.

Container-to-container communication uses:

```text
http://backend:3000
```

However, browser JavaScript runs in the user's browser, not inside the Nginx container. Therefore browser requests can use:

```text
http://localhost:3000
```

when the backend port is published to the host.

---

# 21. `docker compose up`

Instead of manually doing:

```bash
docker build ...
docker run ...
docker build ...
docker run ...
```

we can run:

```bash
docker compose up
```

Compose can:

```text
Read compose file
      ↓
Build images
      ↓
Create containers
      ↓
Create network
      ↓
Start services
```

---

# 22. `docker compose up --build`

Use:

```bash
docker compose up --build
```

when you want Compose to rebuild the images before starting.

Useful after changing:

- Dockerfiles
- Application files
- Build configuration

---

# 23. `docker compose down`

Stops and removes the Compose containers and network:

```bash
docker compose down
```

Basic workflow:

```bash
docker compose up
```

Start.

```bash
docker compose down
```

Stop/remove.

---

# 24. Checking Containers

Running containers:

```bash
docker ps
```

All containers:

```bash
docker ps -a
```

Compose services:

```bash
docker compose ps
```

---

# 25. Logs

All Compose logs:

```bash
docker compose logs
```

Follow logs:

```bash
docker compose logs -f
```

Individual container:

```bash
docker logs <container>
```

---

# 26. Docker Volumes

Volumes are used to persist data outside the normal container lifecycle.

Without a volume:

```text
Container
   ↓
Data
   ↓
Container deleted
   ↓
Data can be lost
```

With a volume:

```text
Container
   ↓
Volume
   ↓
Data survives container deletion
```

Example:

```yaml
services:
  db:
    image: postgres
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
```

Volumes are especially important for databases.

---

# 27. Environment Variables

Configuration should not be hardcoded into images.

Example:

```yaml
services:
  backend:
    environment:
      PORT: 3000
      DATABASE_URL: ${DATABASE_URL}
```

A `.env` file can provide Compose variables:

```env
DATABASE_URL=postgres://user:password@db:5432/app
```

Important:

> Never commit real secrets to Git.

For production, secrets are commonly injected through:

- CI/CD secret stores
- Cloud secret managers
- Deployment platforms
- Secret management systems

---

# 28. Multi-Stage Builds

Multi-stage builds use multiple `FROM` instructions.

Example:

```dockerfile
FROM node:20 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html
```

Concept:

```text
Build stage
     ↓
Build application
     ↓
Production stage
     ↓
Copy only required output
```

Benefits:

- Smaller final images
- Fewer unnecessary dependencies
- Better production images
- Cleaner build/runtime separation

---

# 29. Docker Image Optimization

Good practices:

- Use appropriate base images.
- Use `.dockerignore`.
- Copy dependency files first for caching.
- Avoid unnecessary packages.
- Use multi-stage builds.
- Never put secrets inside images.
- Keep images focused.

---

# 30. Common Docker Commands

## Images

```bash
docker images
```

```bash
docker build -t my-app .
```

```bash
docker rmi my-app
```

## Containers

```bash
docker run my-app
```

```bash
docker run -d my-app
```

```bash
docker ps
```

```bash
docker ps -a
```

```bash
docker stop <container>
```

```bash
docker start <container>
```

```bash
docker rm <container>
```

```bash
docker logs <container>
```

## Compose

```bash
docker compose up
```

```bash
docker compose up --build
```

```bash
docker compose up -d
```

```bash
docker compose down
```

```bash
docker compose ps
```

```bash
docker compose logs
```

```bash
docker compose logs -f
```

---

# 31. Our Final Architecture

```text
                    HOST MACHINE
                         │
                  docker compose up
                         │
              ┌──────────┴──────────┐
              ↓                     ↓
        FRONTEND SERVICE       BACKEND SERVICE
              │                     │
         Nginx :80             Node :3000
              │                     │
       host :8080             host :3000
              │                     │
              ↓                     ↓
      localhost:8080          localhost:3000
```

Compose also creates a network:

```text
             Docker Network
                   │
          ┌────────┴────────┐
          ↓                 ↓
      frontend            backend
          │                 │
          └──── backend:3000┘
```

---

# 32. Overall Docker Workflow

Single application:

```text
Application
    ↓
Dockerfile
    ↓
docker build
    ↓
Docker Image
    ↓
docker run
    ↓
Container
```

Multiple services:

```text
Backend Dockerfile ──→ Backend Image ──→ Backend Container
Frontend Dockerfile ─→ Frontend Image ─→ Frontend Container

                    ↓

              docker-compose.yml
                    ↓
              Docker Compose
                    ↓
       ┌────────────┴────────────┐
       ↓                         ↓
   Backend                    Frontend
       │                         │
       └──── Docker Network ─────┘
```

---

# 33. Docker and CI/CD

Docker and CI/CD are different concepts.

Docker:

```text
Package + Run application
```

CI/CD:

```text
Automate testing + building + deployment
```

They work together:

```text
Developer
    ↓
git push
    ↓
CI/CD pipeline
    ↓
Run tests
    ↓
Build Docker image
    ↓
Push image to registry
    ↓
Deploy
```

Docker becomes one part of our future CI/CD pipeline.

---

# 34. What We Learned

## Docker Fundamentals

- Docker
- Images
- Containers
- Dockerfiles
- Docker Registry

## Dockerfiles

- `FROM`
- `WORKDIR`
- `COPY`
- `RUN`
- `EXPOSE`
- `CMD`
- `.dockerignore`
- Layer caching

## Containers

- `docker build`
- `docker run`
- `docker ps`
- `docker stop`
- `docker start`
- `docker rm`
- `docker logs`

## Networking

- Port mapping
- `EXPOSE` vs `ports`
- Container networking
- Service names
- `localhost`
- CORS basics

## Docker Compose

- `services`
- `build`
- `ports`
- `depends_on`
- Automatic networking
- `docker compose up`
- `docker compose down`
- `docker compose ps`
- Compose logs

## Additional Concepts

- Volumes
- Environment variables
- `.env`
- Secrets
- Multi-stage builds
- Image optimization

---

# 35. Docker Status

```text
DOCKER
   │
   ├── Fundamentals           [DONE]
   ├── Dockerfile             [DONE]
   ├── Images                 [DONE]
   ├── Containers             [DONE]
   ├── Port mapping           [DONE]
   ├── Frontend + Nginx       [DONE]
   ├── Backend + Node         [DONE]
   ├── CORS                   [DONE]
   ├── Docker Compose         [DONE]
   ├── Multiple services      [DONE]
   ├── Networking             [DONE]
   ├── Volumes                [NOTED]
   ├── Environment variables  [NOTED]
   ├── Multi-stage builds     [NOTED]
   └── Optimization           [NOTED]

              ↓

         DOCKER DONE

              ↓

            CI/CD
```

The practical Docker foundation is complete. The remaining topics are concepts to remember and practice when needed.