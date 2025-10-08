# Get manual app configuration
az webapp config show --name fastapi-webapp-6673 --resource-group fastapi-webapp-6673_group > manual-app.json

# Get terraform app configuration
az webapp config show --name fastapi-webapp-85080 --resource-group rg-fastapi-app > terraform-app.json

diff manual-app.json terraform-app.json
