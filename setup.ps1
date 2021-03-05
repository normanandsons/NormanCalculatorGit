$name = "NormanCalculator"
$rg = "rg" + $name
$location = "westeurope"
$acr = "acr" + $name
$aks = "aks" + $name
$subscriptionId = "4e516dda-f21d-47c1-9ac6-b5db83292518"
$kubeVersion = "1.20.2"
$nodeVMSize = "Standard_B2s"


Import-Module -Name Az.Accounts
Write-Output "Provide your credentials to access Azure subscription $subscriptionId" -Verbose
Connect-AzAccount -SubscriptionId $subscriptionId
$azureSubscription = Get-AzSubscription -SubscriptionId $subscriptionId
$connectionName = $azureSubscription.Id

Set-AzContext -Subscription $connectionName

# Create one resource group $rg on a specific location $location (for example eastus) which will contain the Azure services we need 
Write-Output "Creating new resource group: $rg" -Verbose
New-AzResourceGroup `
    -Name $rg `
    -Location $location
Write-Output "New resource group: $rg created" -Verbose

Write-Output "deleting service principal file" -Verbose
rm ~/.azure/acsServicePrincipal.json
Write-Output "service principal file deleted" -Verbose


# Create an ACR registry $acr
Write-Output "Creating new Azure Container registry: $acr" -Verbose
New-AzContainerRegistry -Name $acr -ResourceGroupName $rg -Location $location -Sku Basic
Write-Output "New Azure Container registry: ($acr) created" -Verbose

Write-Output "Creating new Azure Kubernetes Service cluster: $($aks)" -Verbose
New-AzAks `
    -Name $aks `
    -Location $location `
    -ResourceGroupName $rg `
    -NodeCount 1 `
    -KubernetesVersion $kubeVersion `
    -NodeVmSize $nodeVMSize `
    -Verbose 
Write-Output "New Azure Kubernetes Service cluster: ($($aks)) created" -Verbose


# Once created (the creation could take ~10 min), get the credentials to interact with your AKS cluster
Write-Output "Getting credentials for Azure Kubernetes Service cluster: $($aks)" -Verbose
Import-AzAksCredential -ResourceGroupName $rg -Name $aks
Write-Output "Credentials for Azure Kubernetes Service cluster: ($($aks)) obtained" -Verbose
  

 



# Remove-AzResourceGroup -Name $rg

        # $MicroserviceA = false
        # $editedFiles = git diff HEAD HEAD~ --name-only
        #   $editedFiles | ForEach-Object {
        #     Switch -Wildcard ($_ ) {
        #       '**/src/NormanCalculator/*' { echo "##vso[task.setvariable variable=MicroserviceA]True" }
        #       '**/azure-pipelines.yml' { echo "##vso[task.setvariable variable=MicroserviceA]True" }
        #     }
        #   }      


        
        