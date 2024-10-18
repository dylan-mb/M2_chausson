# URL de base pour les utilisateurs et les produits
$baseUrlUsers = "http://localhost:8085/api/users"
$baseUrlProducts = "http://localhost:8085/api/products"

# Liste des utilisateurs à supprimer
$usersToDelete = @(
    @{ id = 10; name = $null },
    @{ id = 12; name = $null },
    @{ id = 13; name = $null }
)

# Liste des produits à supprimer
$productsToDelete = @(
    @{ id = 11; productName = $null; price = 19.99; type = $null },
    @{ id = 12; productName = $null; price = 19.99; type = $null }
)

# Fonction pour interpréter les Status Codes
function Get-StatusMessage {
    param (
        [int]$statusCode
    )
    
    switch ($statusCode) {
        200 { return "Success: The request was successful." }
        201 { return "Created: The resource was successfully created." }
        204 { return "No Content: The resource was successfully deleted." }
        400 { return "Bad Request: There was an error with the request." }
        401 { return "Unauthorized: Authentication is required or has failed." }
        403 { return "Forbidden: You do not have permission to access this resource." }
        404 { return "Not Found: The resource could not be found." }
        500 { return "Internal Server Error: Something went wrong on the server." }
        default { return "Unexpected Status Code: $statusCode" }
    }
}

# Boucle pour supprimer les utilisateurs
foreach ($user in $usersToDelete) {
    $userId = $user.id
    Write-Host "`nDeleting user with ID $userId..."
    
    # Envoi de la requête DELETE pour les utilisateurs
    $responseDeleteUser = Invoke-WebRequest -Uri "$baseUrlUsers/$userId" -Method Delete -Headers @{ "accept" = "*/*" }
    
    # Affichage du message de statut
    Write-Host "Delete User with ID $userId Response: " (Get-StatusMessage $responseDeleteUser.StatusCode)
}

# Boucle pour supprimer les produits
foreach ($product in $productsToDelete) {
    $productId = $product.id
    Write-Host "`nDeleting product with ID $productId..."
    
    # Envoi de la requête DELETE pour les produits
    $responseDeleteProduct = Invoke-WebRequest -Uri "$baseUrlProducts/$productId" -Method Delete -Headers @{ "accept" = "*/*" }
    
    # Affichage du message de statut
    Write-Host "Delete Product with ID $productId Response: " (Get-StatusMessage $responseDeleteProduct.StatusCode)
}
