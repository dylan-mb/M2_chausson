# Fonction pour interpréter les Status Codes
function Get-StatusMessage {
    param (
        [int]$statusCode
    )
    
    switch ($statusCode) {
        200 { return "Success: The request was successful." }
        201 { return "Created: The resource was successfully created." }
        204 { return "No Content: The request was successful, but there is no content to return." }
        400 { return "Bad Request: There was an error with the request." }
        401 { return "Unauthorized: Authentication is required or has failed." }
        403 { return "Forbidden: You do not have permission to access this resource." }
        404 { return "Not Found: The resource could not be found." }
        500 { return "Internal Server Error: Something went wrong on the server." }
        default { return "Unexpected Status Code: $statusCode" }
    }
}

# URL de base pour les produits et les utilisateurs
$baseUrlProducts = "http://localhost:8085/api/products"
$baseUrlUsers = "http://localhost:8085/api/users"

# ========== Produits ==========

# 1. Get all products
Write-Host "Fetching all products..."
$responseGetAllProducts = Invoke-WebRequest -Uri $baseUrlProducts -Method Get -Headers @{ "accept" = "*/*" }
Write-Host "Products Response:" $responseGetAllProducts.Content

# 2. Create a new product
Write-Host "`nCreating a new product..."
$productBodyCreate = @{
    productName = "Creatine"
    price = 19.99
    type = "Dopage"
} | ConvertTo-Json

$responseCreateProduct = Invoke-WebRequest -Uri $baseUrlProducts -Method Post -Body $productBodyCreate -ContentType "application/json" -Headers @{ "accept" = "*/*" }
Write-Host "Create Product Response: " (Get-StatusMessage $responseCreateProduct.StatusCode)

# 3. Get a specific product by ID
$productId = 10

Write-Host "`nFetching product with ID $productId..."
$responseGetOneProduct = Invoke-WebRequest -Uri "$baseUrlProducts/$productId" -Method Get -Headers @{ "accept" = "*/*" }
Write-Host "Product Response:" $responseGetOneProduct.Content
Write-Host "Status: " (Get-StatusMessage $responseGetOneProduct.StatusCode)

# 4. Update a product
Write-Host "`nUpdating product with ID $productId..."
$productBodyUpdate = @{
    productName = "Sucette"
    price = 9.99
    type = "Bonbon"
} | ConvertTo-Json

$responseUpdateProduct = Invoke-WebRequest -Uri "$baseUrlProducts/$productId" -Method Put -Body $productBodyUpdate -ContentType "application/json" -Headers @{ "accept" = "*/*" }
Write-Host "Update Product Response: " (Get-StatusMessage $responseUpdateProduct.StatusCode)

# 5. Delete a product
Write-Host "`nDeleting product with ID $productId..."
$responseDeleteProduct = Invoke-WebRequest -Uri "$baseUrlProducts/$productId" -Method Delete -Headers @{ "accept" = "*/*" }
Write-Host "Delete Product Response: " (Get-StatusMessage $responseDeleteProduct.StatusCode)


# ========== Utilisateurs ==========

# 1. Get all users
Write-Host "`nFetching all users..."
$responseGetAllUsers = Invoke-WebRequest -Uri $baseUrlUsers -Method Get -Headers @{ "accept" = "*/*" }
Write-Host "Users Response:" $responseGetAllUsers.Content

# 2. Create a new user
Write-Host "`nCreating a new user..."
$userBodyCreate = @{
    name = "John"
} | ConvertTo-Json

$responseCreateUser = Invoke-WebRequest -Uri $baseUrlUsers -Method Post -Body $userBodyCreate -ContentType "application/json" -Headers @{ "accept" = "*/*" }
Write-Host "Create User Response: " (Get-StatusMessage $responseCreateUser.StatusCode)

# 3. Get a specific user by ID
$userId = 11

Write-Host "`nFetching user with ID $userId..."
$responseGetOneUser = Invoke-WebRequest -Uri "$baseUrlUsers/$userId" -Method Get -Headers @{ "accept" = "*/*" }
Write-Host "User Response:" $responseGetOneUser.Content
Write-Host "Status: " (Get-StatusMessage $responseGetOneUser.StatusCode)

# 4. Update a user
Write-Host "`nUpdating user with ID $userId..."
$userBodyUpdate = @{
    name = 'abdou'
} | ConvertTo-Json

$responseUpdateUser = Invoke-WebRequest -Uri "$baseUrlUsers/$userId" -Method Put -Body $userBodyUpdate -ContentType "application/json" -Headers @{ "accept" = "*/*" }
Write-Host "Update User Response: " (Get-StatusMessage $responseUpdateUser.StatusCode)

# 5. Delete a user
Write-Host "`nDeleting user with ID $userId..."
$responseDeleteUser = Invoke-WebRequest -Uri "$baseUrlUsers/$userId" -Method Delete -Headers @{ "accept" = "*/*" }
Write-Host "Delete User Response: " (Get-StatusMessage $responseDeleteUser.StatusCode)
