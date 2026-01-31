component=$1
dnf install ansible -y
ansible-pull -U https://github.com/vkg1209/ansible-roles-roboshop.tf.git -e component=$component main.yaml
