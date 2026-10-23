# Coral Launch DevOps examples

Clean, working examples of how we set up cloud and DevOps for our clients.
Use them to see how we work, or as a starting point for your own setup.

Website: https://corallaunch.com | Contact: contact@corallaunch.com

## What is inside

| Folder | What it does |
| --- | --- |
| `terraform/modules/network` | VPC across 2 or 3 zones, public and private subnets, internet gateway, NAT gateway (one shared or one per zone) |
| `terraform/modules/ecs-fargate-service` | ECS Fargate service behind an HTTPS load balancer, auto scaling on CPU, logs, safe deploys with automatic rollback |
| `terraform/examples/fargate-web` | Puts the two modules together with a container registry (ECR) |
| `.github/workflows/terraform.yml` | Format, validate, plan on every pull request, apply on main after approval |
| `.github/workflows/deploy-app.yml` | Test, build an ARM64 image, push to ECR, deploy to ECS and wait until stable |
| `ansible/harden.yml` | Basic Ubuntu hardening: updates, firewall, SSH keys only, fail2ban |
| `docker/` | Small non root Node.js image with a health check and a test |

## How a release flows

1. A developer opens a pull request.
2. The pipeline checks the code and posts the Terraform plan on the pull request.
3. A team member reviews and approves.
4. On merge, the pipeline builds the image, pushes it to ECR and deploys to ECS.
5. If the new version fails its health check, ECS rolls back on its own.

## Safe by default

- No long lived AWS keys. GitHub Actions uses OIDC roles.
- Read only role for plans, a separate role for deploys.
- Deploys to production need approval (GitHub environment with reviewers).
- App tasks run in private subnets. Only the load balancer can reach them.
- HTTPS only, with a modern TLS policy. HTTP redirects to HTTPS.
- Containers run as a non root user with a read only file system.
- Image scanning on push, and old images cleaned up.

## Try it

```bash
# Terraform
cd terraform/examples/fargate-web
cp terraform.tfvars.example terraform.tfvars   # add your certificate ARN
terraform init
terraform plan

# Ansible (check mode first, it changes nothing)
cd ansible
ansible-galaxy collection install -r requirements.yml
ansible-playbook -i inventory.example.ini harden.yml --check --diff

# Docker
cd docker
docker compose up --build
curl http://localhost:8080/health
```

## Cost note

NAT gateways and load balancers cost money even when idle. For a cheap test, keep
`one_nat_per_az = false` and destroy the stack when you finish: `terraform destroy`.

## Need help?

We can set this up for you, fix one part, or review your current setup with
view only access. Book a free cloud health check at https://corallaunch.com.

## License

MIT. See `LICENSE`.
# devops-examples
