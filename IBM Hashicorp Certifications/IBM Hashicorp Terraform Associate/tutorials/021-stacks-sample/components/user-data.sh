#!/bin/bash
# User data script for EC2 instances
# This script configures instance as a basic web server

# Update system packages
yum update -y

# Install Apache web server
yum install -y httpd

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Create a simple web page
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>\${project_name} - \${environment}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #FF9900;
            text-align: center;
        }
        .info {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .footer {
            text-align: center;
            margin-top: 30px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 \${project_name}</h1>
        <div class="info">
            <h2>Server Information</h2>
            <p><strong>Environment:</strong> \${environment}</p>
            <p><strong>Server IP:</strong> \$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)</p>
            <p><strong>Instance ID:</strong> \$(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
            <p><strong>Availability Zone:</strong> \$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
            <p><strong>Region:</strong> \$(curl -s http://169.254.169.254/latest/meta-data/placement/region)</p>
        </div>
        
        <div class="info">
            <h2>System Status</h2>
            <p><strong>Uptime:</strong> \$(uptime -p)</p>
            <p><strong>Memory Usage:</strong> \$(free -h | grep Mem)</p>
            <p><strong>Disk Usage:</strong> \$(df -h / | tail -1)</p>
        </div>
        
        <div class="info">
            <h2>Web Server</h2>
            <p><strong>Apache Version:</strong> \$(httpd -v | head -1)</p>
            <p><strong>Server Time:</strong> \$(date)</p>
        </div>
        
        <div class="footer">
            <p>Powered by Terraform Stacks | AWS Infrastructure</p>
            <p>Last updated: \$(date)</p>
        </div>
    </div>
</body>
</html>
EOF

# Set proper permissions
chmod 644 /var/www/html/index.html

# Create a health check endpoint
cat > /var/www/html/health << EOF
OK
EOF

chmod 644 /var/www/html/health

# Configure firewall (if active)
if systemctl is-active --quiet firewalld; then
    firewall-cmd --permanent --add-service=http
    firewall-cmd --permanent --add-service=https
    firewall-cmd --reload
fi

# Log configuration completion
echo "Web server configuration completed at \$(date)" >> /var/log/web-setup.log

# Restart Apache to ensure all changes are applied
systemctl restart httpd
