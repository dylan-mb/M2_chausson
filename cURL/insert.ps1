# URL de base pour les produits et les utilisateurs
$baseUrlProducts = "http://localhost:8085/api/products"
$baseUrlUsers = "http://localhost:8085/api/users"

# ========== Ajout de 5 produits ==========
$productsToAdd = @(
    @{ productName = "Sundae"; price = 8.20; type = "Alimentaire" },
    @{ productName = "Croissant"; price = 1.50; type = "Alimentaire" },
    @{ productName = "Camembert"; price = 4.00; type = "Alimentaire" },
    @{ productName = "Jambon"; price = 3.50; type = "Alimentaire" },
    @{ productName = "Eau Minérale"; price = 0.80; type = "Boisson" }
)

foreach ($product in $productsToAdd) {
    $productBodyCreate = $product | ConvertTo-Json
    Write-Host "`nCreating product: $($product.productName)"
    $responseCreateProduct = Invoke-WebRequest -Uri $baseUrlProducts -Method Post -Body $productBodyCreate -ContentType "application/json" -Headers @{ "accept" = "*/*" }
    Write-Host "Create Product Response Code:" $responseCreateProduct.StatusCode
}

# ========== Ajout de 5 utilisateurs ==========
$usersToAdd = @(
    @{ name = "AlApadou" },
    @{ name = "Bob" },
    @{ name = "Charlie" },
    @{ name = "Dave" },
    @{ name = "Eve" }
)

foreach ($user in $usersToAdd) {
    $userBodyCreate = $user | ConvertTo-Json
    Write-Host "`nCreating user: $($user.name)"
    $responseCreateUser = Invoke-WebRequest -Uri $baseUrlUsers -Method Post -Body $userBodyCreate -ContentType "application/json" -Headers @{ "accept" = "*/*" }
    Write-Host "Create User Response Code:" $responseCreateUser.StatusCode
}

Write-Host "`n5 products and 5 users have been added successfully!"
