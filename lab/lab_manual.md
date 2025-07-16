# 🧪 Ubuntu DevOps Troubleshooting Lab Manual

Welcome to the **Ubuntu 24.04 DevOps Lab Environment**. This lab simulates 6 real-world infrastructure and troubleshooting issues.

Your user: `student`
Use `sudo` when needed. You can also switch to root using `su`.

---

## 1️⃣ Scenario: Port 8080 Works, Port 80 Fails

### 🔍 Symptom

- You try accessing services using `curl` on different ports:

```bash
curl localhost:80        # Fails
curl localhost:8080      # Works (returns HTML)
```

### 🧠 Troubleshooting

- Run:

  ```bash
  ss -tuln | grep :80
  ss -tuln | grep :8080
  ```

- Check what ports are bound, and by whom.

### ✅ Goal (Expected Fix)

- Understand that port **8080 ≠ 80**.
- No service is bound to port 80 — that's expected.
- Do not try to "fix" this — it’s a scenario to teach service port differences.

---

## 2️⃣ Scenario: Service Installed but Not Running

### 🔍 Symptom

- There is a fake app (`fakeapp`) in the system.
- When you run:

```bash
/usr/local/bin/fakeapp
```

It prints:

```
Error: Misconfigured - set APP_ENV=dev
```

- There is also no service running.

### 🧠 Troubleshooting

- Inspect the script:

  ```bash
  cat /usr/local/bin/fakeapp
  ```

- Check whether it is running:

  ```bash
  ps aux | grep fakeapp
  ```

- Check if a PID file exists:

  ```bash
  cat /var/run/fakeapp.pid
  ```

### ✅ Goal (Expected Fix)

- Export the required environment variable:

  ```bash
  export APP_ENV=dev
  ```

- Start the app:

  ```bash
  nohup /usr/local/bin/fakeapp > /tmp/fakeapp.log 2>&1 &
  echo $! > /var/run/fakeapp.pid
  ```

- Confirm it’s running and prints: `App is working correctly!`

---

## 3️⃣ Scenario: DNS Failure

### 🔍 Symptom

- Pinging an IP works:

  ```bash
  ping 8.8.8.8
  ```

- But DNS lookups fail:

  ```bash
  dig google.com
  curl google.com
  ```

### 🧠 Troubleshooting

- Inspect DNS configuration:

  ```bash
  cat /etc/resolv.conf
  ```

- It may be missing nameservers or commented out.

### ✅ Goal (Expected Fix)

- Restore the original config:

  ```bash
  sudo mv /etc/resolv.conf.bak /etc/resolv.conf
  ```

- Re-test DNS resolution:

  ```bash
  dig google.com
  curl google.com
  ```

---

## 4️⃣ Scenario: SSH Running but Blocked

### 🔍 Symptom

- `sshd` is running:

  ```bash
  ps aux | grep sshd
  ss -tuln | grep :22
  ```

- But you can't connect via SSH externally.

### 🧠 Troubleshooting

- Check firewall status:

  ```bash
  sudo ufw status verbose
  sudo iptables -L -n -v
  ```

- Look for `DENY` or `DROP` rules on port 22.

### ✅ Goal (Expected Fix)

- Remove the firewall block:

  ```bash
  sudo ufw allow 22
  ```

- (External SSH won’t be testable in Docker, but confirm access is restored internally.)

---

## 5️⃣ Scenario: Port 8080 Blocked for Student

### 🔍 Symptom

- You run:

  ```bash
  curl localhost:8080
  ```

  It fails.

- But if you run as root:

  ```bash
  sudo curl localhost:8080
  ```

  It succeeds.

### 🧠 Troubleshooting

- Check `iptables` rules:

  ```bash
  sudo iptables -L -n -v
  ```

- Find UID-based rules rejecting non-root (UID ≠ 0).
- Check your UID:

  ```bash
  id -u
  ```

### ✅ Goal (Expected Fix)

- Remove the blocking rule:

  ```bash
  sudo iptables -D INPUT -p tcp --dport 8080 ! -m owner --uid-owner 0 -j REJECT
  ```

- Confirm:

  ```bash
  curl localhost:8080   # Now works
  ```

---

## 6️⃣ Scenario: Misconfigured App

### 🔍 Symptom

- When running:

  ```bash
  /usr/local/bin/fakeapp
  ```

  You get:

  ```
  Error: Misconfigured - set APP_ENV=dev
  ```

### 🧠 Troubleshooting

- Check the script:

  ```bash
  cat /usr/local/bin/fakeapp
  ```

- Look for logic involving environment variables

### ✅ Goal (Expected Fix)

- Set the environment:

  ```bash
  export APP_ENV=dev
  ```

- Then re-run:

  ```bash
  /usr/local/bin/fakeapp
  ```

  Output:

  ```
  App is working correctly!
  ```

---

Happy debugging! 💻🧠
