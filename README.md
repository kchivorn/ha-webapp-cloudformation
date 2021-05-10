# Deploy a high-availability web app using CloudFormation

The script (infrastructure-as-code) to deploy a secured and high-availablity web application stored in AWS S3 and deployed in Apache Web Server.

## Main Features:

1. There are two availability zones each of which separate into private and public subnet.
2. A Load balancer to Application servers with auto-scaling capability.
3. Application server instance specification: 2vCPUs, 4GB RAM, 10GB disk.
4. Application servers are secured in a private subnet and only accepts traffic from bastion host and load balancer.
5. bastion hosts and load balancers are in public subnets.
6. load balancer accepts http request on port 80
7. Application servers can access internet via NAT gateway for critical OS updates and patches.
8. Bastion host in each availability zone can SSH access to instances of application servers for debugging and trouble shooting.
9. Application servers use Ubuntu machine images.
10. Applcation code is stored in S3 bucket with IAM permissions.
11. Applcation servers are configured with IAM instance profile to enable access to AWS S3 bucket.
12. Health checks and thresholds are defined to check system availability.
13. The script is to automate the process of creating, updating, deleting the whole environment in a predicted manner and short period of time.

![high availability web app cloud formation](https://user-images.githubusercontent.com/26404683/117610434-f4c42d80-b18b-11eb-9c81-0312934f0a80.png)

## Prerequisites

1. Create a Key Pair in AWS EC2 for application server access.
2. Create a Key pair for Bastion host.
3. Make appropriate change to file servers_parameters.json

## Steps

1. Clone the git repository
2. Create infra stack first by running:

```
./create_stack.sh infra infra.yml infra_parameters.json
```

3. Check the status of infra stack, and if infrastructrue is completed, create servers stack by running:

```
./create_stack.sh servers servers.yml servers_parameters.json
```

4. Check the status of servers stack. Access load balancer dns name in the output of the servers stack. You shoud your web app deploy successfully.
