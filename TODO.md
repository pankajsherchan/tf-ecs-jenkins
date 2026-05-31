# Learning ECS with Terraform

Goal: build up from a tiny ECS deployment to a production-shaped service, learning each AWS piece as it appears.

## Phase 0: Setup and Mental Model

- [x] Confirm AWS CLI access works with the intended account and region.
- [x] Install/confirm Terraform locally.
- [x] Pick one AWS region for the project.
- [x] Learn the ECS building blocks:
  - [x] Cluster
  - [x] Task definition
  - [x] Service
  - [x] Container
  - [x] Fargate
  - [x] IAM roles
  - [x] CloudWatch logs

## Phase 1: Minimal Terraform Project

- [x] Create the basic Terraform file structure.
- [x] Configure the AWS provider.
- [ ] Add variables for project name and region.
- [ ] Add common tags.
- [x] Run `terraform init`.
- [x] Run `terraform plan`.

## Phase 2: Networking Foundation

- [x] Create a VPC.
- [x] Create public subnets in at least two availability zones.
- [x] Add an internet gateway.
- [x] Add a public route table.
- [x] Attach routes and subnet associations.
- [ ] Understand why ECS tasks need networking.

## Phase 3: First ECS Cluster

- [x] Create an ECS cluster.
- [ ] Learn the difference between ECS cluster and running containers.
- [x] Create a CloudWatch log group.

## Phase 4: Run One Container on Fargate

- [x] Create ECS task execution IAM role.
- [x] Create an ECS task definition.
- [x] Use a simple public container image first, such as `nginx`.
- [x] Configure container port mappings.
- [x] Configure container logs.
- [x] Create a security group for the task.
- [x] Run the task through an ECS service.

## Phase 5: Make It Reachable

- [x] Create an Application Load Balancer.
- [x] Create a target group.
- [x] Create an ALB listener.
- [x] Connect the ECS service to the target group.
- [x] Test the app in the browser.
- [x] Understand health checks.

## Phase 6: Replace Nginx with Our Own App

- [x] Add a tiny app locally.
- [x] Add a Dockerfile.
- [x] Build the Docker image.
- [x] Create an ECR repository.
- [x] Push the image to ECR.
- [ ] Update ECS task definition to use the ECR image.
- [ ] Redeploy and test.

## Phase 7: Safer Operations

- [ ] Add Terraform outputs for useful URLs and resource names.
- [ ] Learn how ECS deployments roll out.
- [ ] Update container image version safely.
- [x] Add CPU and memory settings intentionally.
- [ ] Review IAM permissions.
- [ ] Add autoscaling basics.

## Phase 8: Cleanup and Cost Control

- [ ] Learn what resources cost money.
- [ ] Destroy the stack with `terraform destroy`.
- [ ] Confirm resources are gone in AWS.
- [ ] Keep notes on what each resource did.

## Working Style

- Work in small steps.
- Run `terraform plan` before applying.
- Explain every AWS resource before creating it.
- Keep each Terraform change understandable.
- Prefer simple working infrastructure before abstraction.
