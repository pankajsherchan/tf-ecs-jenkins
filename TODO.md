# Learning ECS with Terraform

Goal: build up from a tiny ECS deployment to a production-shaped service, learning each AWS piece as it appears.

## Phase 0: Setup and Mental Model

- [x] Confirm AWS CLI access works with the intended account and region.
- [x] Install/confirm Terraform locally.
- [x] Pick one AWS region for the project.
- [ ] Learn the ECS building blocks:
  - [ ] Cluster
  - [ ] Task definition
  - [ ] Service
  - [ ] Container
  - [ ] Fargate
  - [ ] IAM roles
  - [ ] CloudWatch logs

## Phase 1: Minimal Terraform Project

- [x] Create the basic Terraform file structure.
- [x] Configure the AWS provider.
- [ ] Add variables for project name and region.
- [ ] Add common tags.
- [ ] Run `terraform init`.
- [ ] Run `terraform plan`.

## Phase 2: Networking Foundation

- [x] Create a VPC.
- [x] Create public subnets in at least two availability zones.
- [x] Add an internet gateway.
- [x] Add a public route table.
- [x] Attach routes and subnet associations.
- [ ] Understand why ECS tasks need networking.

## Phase 3: First ECS Cluster

- [ ] Create an ECS cluster.
- [ ] Learn the difference between ECS cluster and running containers.
- [ ] Create a CloudWatch log group.

## Phase 4: Run One Container on Fargate

- [ ] Create ECS task execution IAM role.
- [ ] Create an ECS task definition.
- [ ] Use a simple public container image first, such as `nginx`.
- [ ] Configure container port mappings.
- [ ] Configure container logs.
- [ ] Create a security group for the task.
- [ ] Run the task through an ECS service.

## Phase 5: Make It Reachable

- [ ] Create an Application Load Balancer.
- [ ] Create a target group.
- [ ] Create an ALB listener.
- [ ] Connect the ECS service to the target group.
- [ ] Test the app in the browser.
- [ ] Understand health checks.

## Phase 6: Replace Nginx with Our Own App

- [ ] Add a tiny app locally.
- [ ] Add a Dockerfile.
- [ ] Build the Docker image.
- [ ] Create an ECR repository.
- [ ] Push the image to ECR.
- [ ] Update ECS task definition to use the ECR image.
- [ ] Redeploy and test.

## Phase 7: Safer Operations

- [ ] Add Terraform outputs for useful URLs and resource names.
- [ ] Learn how ECS deployments roll out.
- [ ] Update container image version safely.
- [ ] Add CPU and memory settings intentionally.
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
