run:
    docker-compose up -d \
    && docker-compose run website rake db:create && docker-compose run website rake db:migrate
