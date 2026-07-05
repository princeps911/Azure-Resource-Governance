# Role-Based Access Control (RBAC) Architecture Report

## 1. Governance Objectives
This document establishes the Identity and Access Management (IAM) framework for the application infrastructure. The architecture utilizes Azure’s native Role-Based Access Control (RBAC) to enforce the **Principle of Least Privilege (PoLP)**. By targeting permissions strictly at the **Resource Group scope** rather than the broad Subscription scope, we ensure that team members only hold operational capabilities inside their designated environments.

The resource hierarchy is structured to cleanly inherit security boundaries across scopes:



---

## 2. Defined Roles & Target Scopes

### A. Development Environment Scope (`rg-coreapp-dev-eastus-001`)
* **Assigned Group:** `App-Dev-Team`
* **RBAC Role:** **Contributor**
* **Rationale:** The engineering team requires the freedom to rapidly build, modify, test, and tear down application components (such as storage tiers and compute engines) within their sandbox. The Contributor role grants full management capabilities over all resources inside the Resource Group but blocks them from altering the surrounding RBAC assignments or access permissions.

* **Assigned Group:** `Cloud-Ops-Team`
* **RBAC Role:** **Owner**
* **Rationale:** The platform engineering team maintains complete administrative authority over the sandbox environment to manage active service configurations and handle access requests.

### B. Production Environment Scope (`rg-coreapp-prod-eastus-001`)
* **Assigned Group:** `App-Dev-Team`
* **RBAC Role:** **Reader**
* **Rationale:** To preserve stability and prevent human error, developers are blocked from manually executing modifications inside the production tier. The Reader role allows them to browse resource states, view configuration metrics, and troubleshoot performance issues safely without any authorization to delete or change assets.

* **Assigned Group:** `Cloud-Ops-Team`
* **RBAC Role:** **Contributor**
* **Rationale:** Standard infrastructure releases, patches, and resource maintenance are delegated to operations specialists. They can adjust infrastructure states but cannot modify security roles, ensuring that role changes remain subject to formal change management protocols.

* **Assigned Group:** `Finance-Auditing-Team`
* **RBAC Role:** **Reader**
* **Rationale:** The billing and compliance teams require access to pull consumption analytics and resource metadata tags for budget chargebacks. They inherit read-only status across both development and production groups to monitor financial data without interrupting technical runtimes.
