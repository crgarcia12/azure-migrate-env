using './main.bicep'

param artifactsLocation = 'https://raw.githubusercontent.com/crgarcia12/azure-migrate-env/main/'
param location = 'swedencentral'
param vmPassword = '' // Set this via command line or secure parameter
param prefix = 'migration-lab'
