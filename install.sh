#!/bin/bash
docker run -v `pwd`/src:/src composer create-project --prefer-dist laravel/laravel /src/$1
