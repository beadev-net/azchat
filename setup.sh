export AZ_RSG_NAME="rsgazchat"
export AZ_LOCATION="australiaeast"
export AZ_REDIS_NAME="redisazchat"
export AZ_PLAN_NAME="appserviceplanazchat"
export AZ_WEBAPP_NAME="webappazchat"
export AZ_ACR_NAME="acrmyregistry"
export IMAGE="azchat:latest"

echo "Creating Azure resource group $AZ_RSG_NAME in $AZ_LOCATION"
az group create \
  --name $AZ_RSG_NAME \
  --location $AZ_LOCATION

echo "Creating Azure Redis $AZ_REDIS_NAME in $AZ_LOCATION"
az redis create \
  --name $AZ_REDIS_NAME \
  --resource-group $AZ_RSG_NAME \
  --location $AZ_LOCATION \
  --sku Basic \
  --vm-size C0 \
  --enable-non-ssl-port

echo "Creating Azure Container Registry $AZ_ACR_NAME in $AZ_LOCATION"
az acr create \
  --name $AZ_ACR_NAME \
  --resource-group $AZ_RSG_NAME \
  --location $AZ_LOCATION \
  --sku Basic \
  --admin-enabled true

echo "Building Docker image $IMAGE"
az acr login --name $AZ_ACR_NAME
az acr build -r $AZ_ACR_NAME --image $IMAGE --platform linux/amd64 --file Dockerfile .

echo "Creating Azure App Service Plan $AZ_PLAN_NAME in $AZ_LOCATION"
az appservice plan create \
  --name $AZ_PLAN_NAME \
  --resource-group $AZ_RSG_NAME \
  --location $AZ_LOCATION \
  --is-linux \
  --sku B1

echo "Creating Azure Web App $AZ_WEBAPP_NAME in $AZ_LOCATION"
az webapp create \
  --name $AZ_WEBAPP_NAME \
  --resource-group $AZ_RSG_NAME \
  --plan $AZ_PLAN_NAME \
  -i $AZ_ACR_NAME.azurecr.io/$IMAGE \
  --assign-identity '[system]' \
  --acr-use-identity \
  --acr-identity '[system]'

export WEB_APP_MANAGED_IDENTITY=$(az webapp identity show --name $AZ_WEBAPP_NAME --resource-group $AZ_RSG_NAME --query principalId --output tsv)
export ACR_ID=$(az acr show --name $AZ_ACR_NAME --resource-group $AZ_RSG_NAME --query id --output tsv)

az role assignment create \
  --assignee $WEB_APP_MANAGED_IDENTITY \
  --role "AcrPull" \
  --scope $ACR_ID
