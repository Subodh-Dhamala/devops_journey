# Linux Package Management & System Administration

## hostname

Displays the hostname (computer name) of the system.

```bash
hostname
```

---

## uptime

Shows how long the system has been running, the number of logged-in users, and the system load average.

```bash
uptime
```

---

## free

Displays RAM and swap memory usage.

```bash
free -m
```

`-m` displays memory values in megabytes.

---

## df

Shows disk space usage of mounted filesystems.

```bash
df -h
```

`-h` displays sizes in a human-readable format (KB, MB, GB).

---

## du

Displays the size of a directory or file.

```bash
du -sh .
```

Options:

- `-s` → Show only the total size.
- `-h` → Human-readable format.

`.` refers to the current directory.

---

## apt update

Downloads the latest package information from Ubuntu repositories.

```bash
sudo apt update
```

This command **does not install updates**. It only refreshes the package list.

---

## apt list --upgradable

Lists packages that have newer versions available.

```bash
apt list --upgradable
```

Useful before upgrading your system.

---

## apt show

Displays detailed information about a package.

```bash
apt show nginx
```

Shows:

- Version
- Description
- Dependencies
- Package size
- Maintainer

---

## apt install

Installs a package from the repository.

```bash
sudo apt install nginx
```

This downloads and installs the Nginx web server.

---

## systemctl status

Displays the current status of a service.

```bash
systemctl status nginx
```

Shows whether the service is running, stopped, or has errors.

---

## systemctl start

Starts a service.

```bash
sudo systemctl start nginx
```

Starts the Nginx service without restarting the computer.

---

## systemctl stop

Stops a running service.

```bash
sudo systemctl stop nginx
```

The service will no longer accept requests.

---

## systemctl restart

Stops and immediately starts the service again.

```bash
sudo systemctl restart nginx
```

Commonly used after changing configuration files.

---

## systemctl reload

Reloads a service's configuration without fully restarting it.

```bash
sudo systemctl reload nginx
```

Useful when configuration changes can be applied without interrupting the service.

---

## systemctl enable

Configures a service to start automatically when the system boots.

```bash
sudo systemctl enable nginx
```

---

## systemctl disable

Prevents a service from starting automatically at boot.

```bash
sudo systemctl disable nginx
```

The service can still be started manually.

---

## systemctl is-active

Checks whether a service is currently running.

```bash
systemctl is-active nginx
```

Possible outputs include:

- `active`
- `inactive`
- `failed`

---

## systemctl is-enabled

Checks whether a service is configured to start automatically at boot.

```bash
systemctl is-enabled nginx
```

Possible outputs:

- `enabled`
- `disabled`

---

## curl

Sends an HTTP request and displays the server's response.

```bash
curl localhost
```

Since Nginx is running locally, this displays the default Nginx welcome page.

---

## nginx -v

Displays the installed Nginx version.

```bash
nginx -v
```

---

## nginx -V

Displays the Nginx version along with detailed build and configuration information.

```bash
nginx -V
```

---

## apt autoremove

Removes packages that were installed as dependencies but are no longer needed.

```bash
sudo apt autoremove
```

Helps keep the system clean by removing unused packages.

---

## Key Takeaways

- `apt` manages software packages.
- `systemctl` manages system services.
- `curl` is useful for testing web servers and APIs.
- `free`, `df`, and `du` monitor system resources.
- Nginx can be installed, started, stopped, and tested entirely from the command line.

---

## Next Topic

**06 - Linux Networking & Shell Scripting**
