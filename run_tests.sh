# Run Tests
docker network create --driver bridge radar-api_default || true

docker run \
    -v $(pwd)/tests:/etc/newman -v $(pwd)/docs:/output  --network=radar-api_default \
    --entrypoint /bin/bash postman/newman:ubuntu \
    -c "npm update -g && npm install -g newman-reporter-htmlextra;
        newman run /etc/newman/cwms-radar-api.postman_collection.json \
        --environment=/etc/newman/postman_environment.radar_cpc_production.json \
        -r htmlextra --reporter-htmlextra-noSyntaxHightlighting \
        --reporter-htmlextra-export --reporter-htmlextra-noSyntaxHightlighting \
        --reporter-htmlextra-template /etc/newman/dashboard-template.hbs \
        --reporter-htmlextra-browserTitle 'CWMS RADAR Results' \
        --reporter-htmlextra-title 'CWMS RADAR Results' \
        --reporter-htmlextra-titleSize '4' \
        --reporter-htmlextra-export /output/index.html \
        --suppress-exit-code"


# docker build -t postman/newman . && docker run -v $(pwd)/tests:/etc/newman -v $(pwd)/docs:/output postman/newman
