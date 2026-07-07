# Azure Resource Organization & Cloud Governance Framework

## Project Overview
This repository documents the implementation of a scalable cloud governance architecture within Microsoft Azure. It establishes a structural hierarchy using Subscriptions and Resource Groups to streamline lifecycle management, secure access control via Role-Based Access Control (RBAC), and enforce financial tracking using a standardized tagging taxonomy.

---

## 1. Enterprise Naming Convention Strategy
To maintain environmental consistency and clarity, a token-based, kebab-case naming convention has been adopted across all deployed infrastructure components.

**Standard Pattern:** `[resource-prefix]-[application]-[environment]-[region]-[index]`

### Core Resource Mappings
* **Resource Group:** `rg-coreapp-[env]-[region]-001`
* **Virtual Machine:** `vm-web-[env]-[region]-001`
* **Virtual Network:** `vnet-hub-[env]-[region]-001`
* **Storage Account:** `stcoreapp[env][region]001` *(Note: Storage accounts omit hyphens and caps due to Azure global DNS constraints)*
* **Key Vault:** `kv-secrets-[env]-[region]-001`

---

## 2. Resource Hierarchy & Environment Partitioning
The architecture partitions resources into distinct lifecycle boundaries using specialized Resource Groups within the subscription:

1. **Development Environment (`rg-coreapp-dev-eastus-001`):** Houses experimental, testing, and rapid-iteration components. Subject to aggressive cost controls and broader developer modification permissions.
2. **Production Environment (`rg-coreapp-prod-eastus-001`):** Houses stable, high-availability, user-facing applications. Highly restricted access, immutable deployment policies, and mandatory diagnostic logging.

---

## 3. Metadata Tagging Taxonomy
Every asset deployed within this environment inherits a mandatory key-value tagging schema used for cost center allocation, automation tracking, and ownership accountability:

| Tag Key | Example Value | Operational Purpose |
| :--- | :--- | :--- |
| `Environment` | `Production` \| `Development` | Segregates billing run-rates by tier |
| `Owner` | `App-Dev-Team` \| `Cloud-Ops` | Identifies engineering points of contact |
| `CostCenter` | `CC-7701` | Maps resource spending directly to business budgets |
| `Project` | `Infrastructure-Governance` | Groups related microservices under an overarching initiative |

---

## 4. Role-Based Access Control (RBAC) Architecture
Access control is strictly applied at the **Resource Group scope** rather than the broad Subscription scope to enforce the Principle of Least Privilege:

* **Cloud Operations Team:** Assigned the **Owner** role over the Development Resource Group and the **Contributor** role over the Production Resource Group.
* **Application Development Team:** Assigned the **Contributor** role over the Development Resource Group (allowing full resource creation/deletion for testing) and the **Reader** role over Production (allowing troubleshooting visibility without modification risks).
* **Finance Auditing Group:** Assigned the **Reader** role across all scopes to extract billing telemetry without operational interference.
## 🚀 Automated Deployment Integration (IaC First)
To enforce immutable infrastructure design, this project prioritizes programmatic configuration over manual portal modifications. 

The environment infrastructure, tagging structures, and baseline security footprints are fully codified within `deploy.sh`. 

### Local Execution Instructions
To provision this governance topology automatically inside a target subscription, execute the following commands via the Azure CLI:

```bash
chmod +x deploy.sh
./deploy.sh
