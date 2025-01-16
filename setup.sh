AZ_RSG_NAME="$AZ_RSG_NAME"
AZ_LOCATION="eastus"
AZ_REDIS_NAME="redisazchat"
AZ_PLAN_NAME="appserviceplanazchat"
AZ_WEBAPP_NAME="webappazchat"
AZ_ACR_NAME="acrmyregistry"

az group create \
  --name $AZ_RSG_NAME \
  --location $AZ_LOCATION

az redis create \
  --name $AZ_REDIS_NAME \
  --resource-group $AZ_RSG_NAME \
  --location $AZ_LOCATION \
  --sku Standard \
  --vm-size C1 \
  --enable-non-ssl-port false \
  --minimum-tls-version 1.2

az acr create \
  --name $AZ_ACR_NAME \
  --resource-group $AZ_RSG_NAME \
  --location $AZ_LOCATION \
  --sku Basic \
  --admin-enabled true

az appservice plan create \
  --name $AZ_PLAN_NAME \
  --resource-group $AZ_RSG_NAME \
  --location $AZ_LOCATION \
  --is-linux \
  --sku B1

az webapp create \
  --name $AZ_WEBAPP_NAME \
  --resource-group $AZ_RSG_NAME \
  --plan $AZ_PLAN_NAME \
  --runtime "DOCKER|node:20" \
  --deployment-container-image-name $AZ_ACR_NAME.azurecr.io/azchat:latest

az acr credential show --name $AZ_ACR_NAME --resource-group $AZ_RSG_NAME

az webapp config container set \
  --name $AZ_WEBAPP_NAME \
  --resource-group $AZ_RSG_NAME \
  --docker-custom-image-name $AZ_ACR_NAME.azurecr.io/azchat:latest \
  --docker-registry-server-url https://$AZ_ACR_NAME.azurecr.io \
  --docker-registry-server-user <acr-username> \
  --docker-registry-server-password <acr-password>
