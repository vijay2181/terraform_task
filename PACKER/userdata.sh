#! /bin/bash

#update the server
yum update -y
sudo yum install -y httpd
sudo echo "<html><body><h1>Hello Vijay</h1></body></html>" | sudo tee /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
