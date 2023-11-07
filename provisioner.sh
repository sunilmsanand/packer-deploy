# this is a shell script for provisioning ami image from packer

#Update the packages in the linux machine
sudo yum -y update

# Installing git on the target machine
sudo yum install git -y

# Installing Amazon SSM
sudo yum install https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm -y

# Install Amazon CloudWatch Agent
sudo yum install https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm -y
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status

# Install AWS Inspector
curl -O https://inspector-agent.amazonaws.com/linux/latest/install
sudo bash install

#Install Docker
sudo yum install docker -y
sudo systemctl start docker