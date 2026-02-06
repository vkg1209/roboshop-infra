component=$1
env=$2

dnf install ansible -y

REPO_URL=https://github.com/vkg1209/ansible-roles-roboshop.tf.git
REPO_DIR=/opt/roboshop/ansible/
ANSIBLE_DIR=ansible-roles-roboshop.tf

mkdir -p $REPO_DIR
mkdir -p "/var/log/roboshop/"
touch "ansible.log"

cd $REPO_DIR

if [ $ANSIBLE_DIR -d ]; then
    cd $ANSIBLE_DIR
    git pull
else
    git clone $REPO_URL
    cd $ANSIBLE_DIR
fi

ansible-playbook -e component=${component} -e env=${env} main.yaml
