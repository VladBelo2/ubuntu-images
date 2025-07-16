#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "[⚠️  Skipping privileged lab setup — not running as root]"
else
    echo -e "\n📘 Welcome to the Ubuntu Troubleshooting Lab!"
    echo -e "🛠 See /lab/lab_manual.md for full instructions"

    # -------------------------------
    # 🔧 Scenario 1: Port 8080 only
    # -------------------------------
    # Serve a basic HTTP server on port 8080 (as root)
    nohup python3 -m http.server 8080 > /dev/null 2>&1 &

    # Port 80 is intentionally NOT bound to simulate inaccessibility

    # -------------------------------
    # 🔧 Scenario 2 + 6: Fake service not running + misconfigured
    # -------------------------------
    # Do NOT start it — student must start it manually
    install -m 755 /lab/fakeapp.sh /usr/local/bin/fakeapp

    # (Simulated service uses a PID file - not started yet)
    # Student must run it manually and create the PID file

    # -------------------------------
    # 🔧 Scenario 3: DNS broken
    # -------------------------------
    iptables -A OUTPUT -p udp --dport 53 -j REJECT
    iptables -A OUTPUT -p tcp --dport 53 -j REJECT

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
    # Final touches
    # -------------------------------
    cp /lab/README.txt /etc/motd
    chown -R student:student /lab
fi

exec bash
