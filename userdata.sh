#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "<center><h1> Hello, World </h1></center>" | sudo tee /var/www/html/index.html
sudo systemctl restart httpd