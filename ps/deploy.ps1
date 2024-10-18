$WORKING_DIR = Get-Location
$CURRENT_DIR = (Get-Item -Path $WORKING_DIR).Name

$DOCKER_IMAGE = "openjdk:17"

$CONTAINER_RUNTIME_NAME = "$CURRENT_DIR-openjdk-17"

docker run -it --rm `
    --name $CONTAINER_RUNTIME_NAME `
    -v "$WORKING_DIR/target/rest-api-0.0.1-SNAPSHOT.jar:/app/rest-api-0.0.1-SNAPSHOT.jar" `
    -p 8085:8080 `
    $DOCKER_IMAGE java -jar /app/rest-api-0.0.1-SNAPSHOT.jar
