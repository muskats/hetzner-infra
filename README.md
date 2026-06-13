# Hetzner Infrastructure

Terraform-based infrastructure project for building a reproducible Hetzner K3s foundation.

This repository owns infrastructure provisioning, node bootstrap, Tailscale enrollment, and the initial Flux bootstrap. The GitOps repository owns day-2 cluster state only.

---

## Overview

- Provisions Hetzner Cloud network and servers
- Boots K3s on first boot with cloud-init
- Enrolls nodes in the Tailscale tailnet for private operator access
- Installs Flux on the control plane
- Points Flux at the public GitOps repository

The current GitOps repository is:

- `https://github.com/muskats/hetzner-platform`

Flux tracks:

- branch: `main`
- path: `./clusters/hetzner-k3s`

---

## Bootstrap Flow

1. Terraform provisions the Hetzner network, SSH key, and servers.
2. Cloud-init installs K3s on the control plane and workers.
3. Cloud-init joins every node to the Tailscale tailnet.
4. The control plane installs Flux.
5. Flux syncs the GitOps repository and reconciles the cluster overlay.

This flow has been validated on a three-node cluster: one control plane and two workers.

---

## Scope

This repository manages:

- Network
- Instances
- SSH key registration
- Cloud-init rendering
    - K3s day-0 bootstrap
    - Tailscale node enrollment
    - Flux bootstrap

This repository does **not** manage:

- Application workloads
- Platform add-ons and cluster state
- Secret material committed to Git

Those belong in the separate GitOps repository.

---

## Repository Layout

```text
.
├── backend.tf
├── main.tf
├── outputs.tf
├── provider.tf
├── variables.tf
├── locals.tf
├── modules
│   ├── cloudinit
│   ├── instance
│   ├── network
│   └── ssh
└── templates
    └── cloud-init
        ├── flux-bootstrap.yaml.tftpl
        ├── k3s-agent.yaml.tftpl
        └── k3s-server.yaml.tftpl
```

---

## Runtime Inputs

Provide these through the pipeline or environment, not in Git:

- `HCLOUD_TOKEN`
- `HCLOUD_SSH_PUBLIC`
- `K3_TOKEN`
- `TSKEY_AUTH`

The GitHub Actions workflows map these into Terraform variables.

---

## Validation

### Working directory
Run after changes:

```bash
terraform fmt -recursive
terraform validate
terraform plan
```

### Infrastucture
Run on the control plane after apply:

```bash
k3s kubectl get nodes -o wide
tailscale status
k3s kubectl -n flux-system get gitrepositories,kustomizations,helmreleases,helmrepositories -o wide
```

Pass criteria:

- all K3s nodes are `Ready`
- the node is connected to the tailnet
- `gitrepository/flux-system` is `Ready=True`
- `kustomization/hetzner-platform` is `Ready=True`
- `kustomization/apps` is `Ready=True`

---

## Notes

- Cloud-init is the day-0 bootstrap mechanism.
- Flux is installed on the control plane and pulls the GitOps repository directly.
- The GitOps repository remains the source of truth for day-2 state.
- If Flux stays in `Reconciling`, the issue is usually in the GitOps repository rather than this repo.
