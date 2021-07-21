#!/usr/bin/env bash

if [ $# -gt 0 ]; then
    if [ "$1" == "artisan" ] || [ "$1" == "art" ]; then
        shift 1
        docker-compose exec \
            web \
            php artisan "$@"

    # If "composer" is used, pass-thru to "composer"
    # inside a new container
    elif [ "$1" == "composer" ]; then
        shift 1
        docker-compose exec \
            web \
            composer "$@"

    # If "test" is used, run unit tests,
    # pass-thru any extra arguments to php-unit
    elif [ "$1" == "test" ]; then
        shift 1
        docker-compose exec \
            web \
            ./vendor/bin/phpunit "$@"
    elif [ "$1" == "npm" ]; then
        shift 1
        docker-compose run --rm \
            node \
            npm "$@"
    else
        docker-compose "$@"
    fi
else
    >&2 echo "No command passed to cmd"
    exit 1
fi