# Run Tests
docker network create --driver bridge radar-api_default || true

while getopts :e: flag
do
    case "${flag}" in
        e) env=${OPTARG};;        
    esac
done
if [ "$env" = "local" ]; then
    ENV_CONFIG="postman_environment.radar_local.json"
else
    ENV_CONFIG="postman_environment.radar_cpc_production.json"
fi
echo "Using postman env file: $ENV_CONFIG";


docker run \
    -v $(pwd)/tests:/etc/newman -v $(pwd)/docs:/output  --network=radar-api_default \
    --entrypoint /bin/bash postman/newman:ubuntu \
    -c "npm update -g && npm install -g newman-reporter-htmlextra;
        newman run /etc/newman/cwms-radar-api.postman_collection.json \
        --environment=/etc/newman/${ENV_CONFIG} \
        --reporters cli,htmlextra \
        --reporter-htmlextra-template /etc/newman/dashboard-template.hbs \
        --reporter-htmlextra-browserTitle 'CWMS RADAR Results' \
        --reporter-htmlextra-title 'CWMS RADAR Results' \
        --reporter-htmlextra-titleSize '4' \
        --reporter-htmlextra-export /output/index.html \
        --suppress-exit-code"
