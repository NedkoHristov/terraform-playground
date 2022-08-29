# A terraform playground

Playground fo play with the hands-on from "The Terraform Book"

Running checkov on my codebase results quite a long list of recommendations from low-prio to high-prio fixes. This is the sanitized output of the checkov scan:

### terraform scan results:

:clock9: Ensure Instance Metadata Service Version 1 is not enabled

:clock9: Ensure that detailed monitoring is enabled for EC2 instances

:clock9: Ensure that EC2 is EBS optimized

:clock9: Ensure all data stored in the Launch configuration or instance Elastic Blocks Store is securely encrypted

:clock9: EC2 instance should not have public IP.

:clock9: Ensure that Elastic Load Balancer(s) uses SSL certificates provided by AWS Certificate Manager

:clock9: Ensure the ELB has access logging enabled

:clock9: Ensure no security groups allow ingress from 0.0.0.0:0 to port 80

:clock9: Ensure every security groups rule has a description

:clock9: Ensure no security groups allow ingress from 0.0.0.0:0 to port 22

:clock9: Ensure VPC subnets do not assign public IP by default

:clock9: Ensure that Security Groups are attached to another resource

:clock9: Ensure the default security group of every VPC restricts all traffic

:clock9: Ensure VPC flow logging is enabled in all VPCs
