# Hetzner Infrastructure

A Terraform-based infrastructure provisioning project for deploying and managing cloud resources on Hetzner Cloud.

This repository represents a **real-world infrastructure-as-code (IaC) system** designed to provision reproducible, cost-efficient cloud environments using Hetzner as the underlying compute provider.

---

## Overview

This project provisions and manages cloud infrastructure using a declarative Infrastructure-as-Code (Terraform) approach.

It focuses on:
- Repeatable server provisioning
- Network and firewall configuration
- Secure remote access via SSH
- Environment consistency through Terraform state management

The infrastructure is currently deployable in a **single Hetzner region**, optimised for cost-efficiency and simplicity rather than multi-region redundancy.

---

## Project Structure

This repository follows a modular layout to separate concerns between infrastructure components, configuration, and reusable modules. This is intentionally designed to support future scaling (e.g. multi-environment), updates, and Kubernetes-based platform layers.

## Layout

````shell
.
├── README.md
├── backend.tf              # Remote state backend configuration - HCP Terraform 
├── main.tf                 # Orchestration layer - Root
├── provider.tf             # Provider configuration (+ authentication context) - Hetzner
├── variables.tf            # Input variables - Root
├── outputs.tf              # Outputs - Root: node IPs

├── modules
│   ├── instance
│   │   ├── main.tf        # Nodes - VM provisioning
│   │   ├── variables.tf   # Input variables - Module: configuration inputs
│   │   ├── outputs.tf     # Outputs - Node: node IPs and names
│   │   └── provider.tf    # Required provider (to avoid false registry.terraform.io/hashicorp/...). Version is managed at root

│   └── ssh
│       ├── main.tf        # SSH - Public key lifecycle
│       ├── variables.tf   # Input variables - Module: configuration inputs
│       ├── outputs.tf     # Outputs - SSH: Public key
│       └── provider.tf    # Required provider (to avoid false registry.terraform.io/hashicorp/...). Version is managed at root

├── templates
│   └── cloud-init
│       └── os-hardening.tpl   # Cloud-init bootstrap template used for initial VM hardening and baseline OS configuration
````

---

## Notes

> This is a single-region deployment.
>
> The limitation is intentional due to:
> - Hobby project budget constraints
> - General limitations in Hetzner infrastructure availability at the time of creating this project
