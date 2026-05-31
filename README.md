# Hetzner Infrastructure

Terraform-based infrastructure project for building a reproducible Hetzner K3s foundation.

This repository provisions infrastructure and node bootstrap only.  
Platform add-ons and workload-level tooling belong in a separate GitOps repository.

---

## Overview

This project provisions a private-networked Kubernetes base layer on Hetzner Cloud with Terraform and cloud-init.

It focuses on:
- Deterministic infrastructure provisioning
- Private networking between nodes
- Automatic K3s bootstrap during first boot
- Reproducible rebuilds (destroy/apply)
- Clear separation between infra and platform lifecycle

### Scope

This repository manages:

- Network
- Instances
- SSH key registration
- Cloud-init rendering
- K3s bootstrap at node creation time

This repository does **not** manage:

- Application workloads
- Helm releases for platform services
- Continuous cluster operations tooling (Flux/Argo CD, observability stack, ingress controllers)

Those belong in a separate platform/GitOps repository.

---

## Architecture

Terraform -> Hetzner infrastructure -> private network attachment -> cloud-init bootstrap -> K3s control plane + workers

Key principles:

- No Ansible orchestration
- No SSH-based post-provision automation in CI
- Bootstrap happens via `user_data` at creation time
- Infrastructure lifecycle remains in Terraform
- Platform lifecycle is intended to move to GitOps

---

## Project Structure

### Layout

````shell
.
├── README.md
├── backend.tf                  # Remote state backend configuration
├── main.tf                     # Root orchestration
├── provider.tf                 # Hetzner provider configuration
├── variables.tf                # Root inputs
├── locals.tf                   # Root computed values (e.g. deterministic node IPs)
├── outputs.tf                  # Root outputs (role-based inventory)

├── modules
│   ├── cloudinit
│   │   ├── main.tf             # Renders role-specific user_data
│   │   ├── variables.tf        # Cloud-init module inputs
│   │   ├── outputs.tf          # Rendered user_data output
│   │   └── provider.tf         # Required provider declaration

│   ├── instance
│   │   ├── main.tf             # VM creation and network attachment
│   │   ├── variables.tf        # Instance module inputs
│   │   ├── outputs.tf          # Instance IDs, names, IPs
│   │   └── provider.tf         # Required provider declaration

│   ├── network
│   │   ├── main.tf             # Hetzner network and subnet resources
│   │   ├── variables.tf        # Network module inputs
│   │   ├── outputs.tf          # Network outputs
│   │   └── provider.tf         # Required provider declaration

│   └── ssh
│       ├── main.tf             # Hetzner SSH key resource
│       ├── variables.tf        # SSH module inputs
│       ├── outputs.tf          # SSH key outputs
│       └── provider.tf         # Required provider declaration

├── templates
│   └── cloud-init
│       ├── k3s-server.yaml.tftpl   # Control plane bootstrap template
│       └── k3s-agent.yaml.tftpl    # Worker bootstrap template
````
---

## Outputs
Role-oriented outputs are exposed for operational handoff:

 - **Control-plane** name and it's private IP
 - **Worker names** and their respective private IPs
 - **Node inventory** object for downstream automation
 - **Sensitive artifacts** (e.g. kubeconfig) are intentionally not exported as Terraform outputs.

