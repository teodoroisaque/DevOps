#!/bin/sh

echo "###########################    Testando erro Materia 1    ###########################"

curl -sv localhost:8000/api/comment/list/1

echo "###########################    Testando erro Materia 1    ###########################"

curl -sv 127.0.0.1:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"alice@example.com","comment":"first post!","content_id":1}'
curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"alice@example.com","comment":"ok, now I am gonna say something more useful","content_id":1}'
curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"bob@example.com","comment":"I agree","content_id":1}'

echo "###########################    Testando comentarios Materia 1    ###########################"

curl -sv localhost:8000/api/comment/list/1


echo "###########################    Testando erro Materia 2    ###########################"

curl -sv localhost:8000/api/comment/list/2

echo "###########################    Testando erro Materia 2    ###########################"

curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"bob@example.com","comment":"I guess this is a good thing","content_id":2}'
curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"charlie@example.com","comment":"Indeed, dear Bob, I believe so as well","content_id":2}'
curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"eve@example.com","comment":"Nah, you both are wrong","content_id":2}'

echo "###########################    Testando comentarios Materia 2    ###########################"

curl -sv localhost:8000/api/comment/list/2