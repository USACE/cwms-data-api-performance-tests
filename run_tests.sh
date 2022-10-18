# Run Tests
docker network create --driver bridge radar-api_default || true

# docker run \
#     -v $(pwd)/tests:/etc/newman --network=radar-api_default \
#     --entrypoint /bin/bash postman/newman:ubuntu \
#     -c "npm i -g newman-reporter-htmlextra;
#         newman run /etc/newman/cwms-radar-api.postman_collection.json \
#         --environment=/etc/newman/postman_environment.radar_cpc_production.json \
#         -r htmlextra --reporter-htmlextra-export --reporter-htmlextra-noSyntaxHightlighting \
#         /etc/newman/radar-api-results.html"

docker build -t postman/newman . && docker run -v $(pwd)/tests:/etc/newman -v $(pwd)/docs:/output postman/newman