Here is your cleaned-up and fully polished Markdown document, with all encoding glitches fixed and formatted for optimal readability:

```markdown
# Linux Networking Basics

## Overview

Linux networking is the process of connecting computers, servers, and services to communicate with each other. Networking knowledge is essential for DevOps because servers, containers, cloud platforms, APIs, and distributed applications depend on network communication.

---

## Network Interfaces

A network interface is a software or hardware component that allows a Linux system to communicate over a network.

### View Network Interfaces

```bash
ip addr

```

**Example Output:**

```text
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    inet 172.30.112.47/20 brd 172.30.127.255 scope global eth0

```

### Important Fields

| Field | Meaning |
| --- | --- |
| `eth0` | Network interface name |
| `inet` | IPv4 address |
| `inet6` | IPv6 address |
| `mtu` | Maximum Transmission Unit |
| `UP` | Interface state is active |

---

## Loopback Interface

The loopback interface allows a computer to send network traffic to itself, bypassing hardware network adapters.

* **Interface Name:** `lo`
* **IP Address:** `127.0.0.1`

### Example Usage

```bash
ping localhost
# or
ping 127.0.0.1

```

**Output:**

```text
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.038 ms

```

> **Note:** The loopback interface is primarily used for local testing, running local web servers, and inter-process communication.

---

## Checking Your IP Address

### 1. `ip addr`

Displays all network interfaces, assigned IP addresses, and operational statuses.

```bash
ip addr

```

### 2. `hostname -I`

Displays only the system's assigned IP addresses (excluding the loopback interface).

```bash
hostname -I

```

**Example Output:**

```text
172.30.112.47

```

---

## System Hostname

A hostname is a unique label assigned to a device on a network.

### View Hostname

```bash
hostname

```

**Example Output:**

```text
Subodh-Dhamala

```

### View Detailed Hostname Information (`hostnamectl`)

```bash
hostnamectl

```

**Example Output:**

```text
 Static hostname: Subodh-Dhamala
       Icon name: computer-vm
         Chassis: vm
      Machine ID: e520a7b4...
        Boot ID: 4d28c9f0...
Virtualization: wsl
Operating System: Ubuntu 24.04 LTS
          Kernel: Linux 6.6.137.3-microsoft-standard-WSL2
    Architecture: x86-64

```

### Field Breakdown

| Field | Meaning |
| --- | --- |
| **Static hostname** | Set computer name |
| **Operating System** | Linux distribution and version |
| **Kernel** | Linux kernel release version |
| **Virtualization** | System virtualization layer (e.g., WSL, KVM) |

### Changing the Hostname

Changing the hostname requires root or `sudo` privileges.

```bash
sudo hostnamectl set-hostname new-hostname

```

---

## Network Routing

Routing determines the path network traffic follows from source to destination.

### View Routing Table

```bash
ip route

```

**Example Output:**

```text
default via 172.30.112.1 dev eth0

```

| Component | Meaning |
| --- | --- |
| `default` | Catch-all destination for outbound traffic outside local network |
| `via 172.30.112.1` | Gateway IP address forwarding traffic |
| `dev eth0` | Network interface used to reach the gateway |

### Default Gateway

A default gateway is the node that routes traffic from the local network segment out to external networks (such as the Internet).

---

## Testing Network Connectivity

### `ping`

The `ping` command uses ICMP protocol packets to check if a remote host is reachable and measures packet response round-trip time.

```bash
ping google.com

```

**Example Output:**

```text
64 bytes from 142.251.126.139: icmp_seq=1 ttl=115 time=14.2 ms

```

| Field | Meaning |
| --- | --- |
| `icmp_seq` | Sequence number of the ICMP packet |
| `ttl` | Time to Live (hop limit remaining) |
| `time` | Round-trip latency in milliseconds |

> Use `CTRL + C` to stop sending ping requests.

---

## Domain Name System (DNS)

DNS acts as the phonebook of the internet, resolving human-readable hostnames (e.g., `google.com`) into numerical IP addresses (e.g., `142.251.126.139`).

### Installing DNS Diagnostic Tools

```bash
sudo apt update
sudo apt install dnsutils -y

```

### Querying DNS with `nslookup`

```bash
nslookup google.com

```

**Example Output:**

```text
Server:         10.255.255.254
Address:        10.255.255.254#53

Non-authoritative answer:
Name:   google.com
Address: 142.251.126.139

```

---

## Testing Web Services with `curl`

`curl` is a command-line utility for transferring data to or from a server using various protocols (HTTP, HTTPS, FTP, etc.).

### Basic Usage

```bash
curl google.com

```

**Output:**

```text
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="[http://www.google.com/](http://www.google.com/)">here</A>.
</BODY></HTML>

```

### Inspect HTTP Response Headers (`-I`)

To inspect status codes, server information, and headers without fetching the full response body:

```bash
curl -I [https://google.com](https://google.com)

```

**Example Output:**

```text
HTTP/2 301
location: [https://www.google.com/](https://www.google.com/)
content-type: text/html; charset=UTF-8
server: gws

```

### Common HTTP Status Codes

| Code | Status | Description |
| --- | --- | --- |
| **200** | OK | The request succeeded |
| **301** | Moved Permanently | Resource has been permanently relocated |
| **302** | Found | Resource has been temporarily relocated |
| **404** | Not Found | Requested resource could not be found |
| **500** | Internal Server Error | Generic error on the target server |

---

## Protocol Comparison: HTTP vs. HTTPS

* **HTTP (Hypertext Transfer Protocol):** Transmits data in plain text over port 80.
* **HTTPS (HTTP Secure):** Encrypts traffic using SSL/TLS over port 443, offering:
* **Encryption:** Protects data against eavesdropping.
* **Authentication:** Verifies the server identity via SSL certificates.
* **Integrity:** Prevents packet tampering during transit.



---

## Command Reference Summary

| Command | Primary Function |
| --- | --- |
| `ip addr` | View network interfaces and IP addresses |
| `hostname -I` | Print system IP address |
| `hostname` | Print current system hostname |
| `hostnamectl` | View or modify detailed system hostname and kernel info |
| `ip route` | Display kernel routing table |
| `ping <host>` | Test ICMP connectivity to a target |
| `nslookup <domain>` | Perform DNS name resolution queries |
| `curl <url>` | Make HTTP requests and retrieve web content |
| `curl -I <url>` | Fetch response headers only |

---

## Key Takeaways

1. **IP Addresses** uniquely identify devices on local and global networks.
2. **Network Interfaces** (`eth0`, `lo`) link the Linux OS to physical or virtual network devices.
3. `ip addr` and `ip route` form the baseline tools for viewing interface configurations and default gateways.
4. `ping` verifies reachability, while `nslookup` resolves domain names to underlying IP addresses.
5. `curl` is essential for inspecting HTTP endpoints, status codes, and API behavior directly from the terminal.

---

## Next Steps

**Linux Shell Environment & Environment Variables**

```

```
