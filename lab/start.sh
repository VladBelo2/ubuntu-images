#!/bin/bash

echo -e "\n📘 Welcome to the Ubuntu Troubleshooting Lab!"
echo -e "🛠 See /lab/lab_manual.md for full instructions"

# -------------------------------
# 🔧 Scenario 1: Port 8080 only
# -------------------------------
# Serve a basic HTTP server on port 8080 (as root)
nohup python3 -m http.server 8080 > /dev/null 2>&1 &

# Port 80 is intentionally NOT bound to simulate inaccessibility

# -------------------------------
# 🔧 Scenario 2: Fake service not running
# -------------------------------
# Do NOT start it — student must start it manually
cat <<EOF > /usr/local/bin/fakeapp
#!/bin/bash
if [ "\$APP_ENV" != "dev" ]; then
  echo "Error: Misconfigured - set APP_ENV=dev"
  exit 1
fi
echo "App is working correctly!"
EOF
chmod +x /usr/local/bin/fakeapp

# (Simulated service uses a PID file - not started yet)
# Student must run it manually and create the PID file

# -------------------------------
# 🔧 Scenario 3: DNS broken
# -------------------------------
mv /etc/resolv.conf /etc/resolv.conf.bak
echo "# DNS broken intentionally for lab" > /etc/resolv.conf

# -------------------------------
# 🔧 Scenario 4: SSH blocked by firewall
# -------------------------------
service ssh start
ufw allow 80
ufw allow 8080
ufw deny 22
ufw --force enable

# -------------------------------
# 🔧 Scenario 5: iptables blocks port 8080 for student
# -------------------------------
iptables -A INPUT -p tcp --dport 8080 ! -m owner --uid-owner 0 -j REJECT

# -------------------------------
# 🔧 Scenario 6: App misconfigured (handled by fakeapp)
# -------------------------------

# -------------------------------
# Final touches
# -------------------------------
cp /lab/README.txt /etc/motd
chown -R student:student /lab

exec bash
