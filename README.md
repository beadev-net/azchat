# AzChat 

##### Websocket chat application using Azure Cloud Services.
- Azure Redis (PubSub)
- Azure Container Registry (Registry)
- WebApp + AppService Plan (Workload)
- Entra ID (Identity)

##### Using github actions for CI/CD:
- Build and push docker image to Azure Container Registry
- Deploy to Azure WebApp

---

### Local Development

```sh
make docker
```

---

### Az Login

```sh
az login
```

### Setup Resources on Azure Cloud

```sh
make azure-setup
```

---

### Github Actions

```sh
az ad sp create-for-rbac --name "github-action" --role contributor --scopes /subscriptions/<subcription-id> --sdk-auth
```

[Trigger Workflow](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/triggering-a-workflow#defining-inputs-for-manually-triggered-workflows)