# STEP - 1. Generate the public key


1. Create public and private key follow below link.
2. https://docs.acquia.com/acquia-cloud-platform/manage-apps/command-line/ssh/getting-started/generate
3. Update the public in main.tf file.  

# STEP - 2. git clone the repo

# STEP - 3. Copy the keypari file from local machine to EC2 Public Cloudideastar-Svr1 (VPC1)

cat keypair > copy
ssh to public ec2 and past there > vi keypair
Change permission > chmod 400 keypair
SSH to private EC2 Cloudideastar-PrivateSvr1(VPC3) via public EC2 Cloudideastar-Svr1 (VPC1)
```bash
ssh -i "keypair" ec2-user@172.16.1.X
```  
![header image](tgw.jpg)

## Verify the connectivity test

Can reach out to Web1 private IP from Web2
1. Can reach out to Cloudideastar-PrivateSvr1(VPC3) private IP from Cloudideastar-Svr1 (VPC1)



### Command to Deploy
```bash
  - terraform init
  - terraform validate
  - terraform fmt
  - terraform plan
  - terraform apply -auto-approve
  - terraform state list
```  
### Command to Undeploy  
```bash
  - terraform destroy -auto-approve
```  
