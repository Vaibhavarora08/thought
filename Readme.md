This repository will help you install Mediawiki on AWS in fully automated fashion using Terraforma, AWS cli and Ansible.
Terraform is responsible for provisioning infrastructure on AWS while Ansible helps install Mediawiki.


# Diagrams - Infra
![](/mediawiki.jpeg)


# Diagram - Execution
1. Traffic arrives on load balancer and get routed to web servers in public subnet
2. Web servers can only make calls to DB server in private subnet



# How to Execute Terrform Scripts
# Plan
terrform plan
# Apply
terraform apply
# Destroy
terraform destroy


# How to Execute Ansible Playbook independent of Terraform
ansible-playbook -i non-production master-install-mediawiki.yaml

# Things to consider
1. Check python version of destination machines. If version <= 3 then please comment "ansible_python_interpreter" in group_vars
2. Pre-bake your image and provide ami-id in terraform.tfvars
3. The path for key file in terraform compute code is specific to my system location. You need to change the location as per your resources.

