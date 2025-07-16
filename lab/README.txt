🧪 Welcome to the Ubuntu DevOps Troubleshooting Lab

You are inside a pre-configured environment with real-world issues to solve.

Your user: student
Password: student (if prompted with sudo)

Scenarios:

1️⃣ Port 8080 fails for normal user, but works for root  
   🔍 curl localhost:8080 → OK  
   🔍 curl localhost:80 → Fails (why?)  
   🛠 Use: ss, iptables, capabilities

2️⃣ App installed but not running  
   🔍 Use systemctl, ps, logs  
   🛠 Find and start the service

3️⃣ DNS failure  
   🔍 dig google.com fails  
   🛠 Inspect /etc/resolv.conf

4️⃣ SSH misconfigured  
   🔍 Service may be running but blocked  
   🛠 Troubleshoot firewall/ufw/iptables

5️⃣ UFW rules block student user  
   🔍 Check ufw status and rules  
   🛠 Fix access while keeping security

6️⃣ App returns error (misconfig)  
   🔍 curl localhost returns HTTP 500  
   🛠 Debug env vars, logs, port exposure

Solutions available in: /lab/solutions.txt
