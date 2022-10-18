FROM postman/newman:alpine



# Cache buster
RUN echo $(date +%s)

RUN npm install -g newman-reporter-htmlextra

WORKDIR /etc/newman

ENTRYPOINT [ "newman", "run", "cwms-radar-api.postman_collection.json", \
            "--environment=postman_environment.radar_cpc_production.json", \
            "-r", "htmlextra", \
            "--reporter-htmlextra-noSyntaxHightlighting", \
            "--reporter-htmlextra-template", "/etc/newman/dashboard-template.hbs", \
            "--reporter-htmlextra-browserTitle", "CWMS RADAR Results", \
            "--reporter-htmlextra-title", "CWMS RADAR Results", \
            "--reporter-htmlextra-titleSize", "4", \
            "--reporter-htmlextra-export", "/output/index.html"]



# ENTRYPOINT ["tail", "-f", "/dev/null"]