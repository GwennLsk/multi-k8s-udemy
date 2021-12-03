docker build -t gwennlinski/multi-client-udemy:latest -t gwennlinski/multi-client-udemy:$SHA -f ./client/Dockerfile ./client
docker build -t gwennlinski/multi-server-udemy:latest -t gwennlinski/multi-server-udemy:$SHA -f ./server/Dockerfile ./server
docker build -t gwennlinski/multi-worker-udemy:latest -t gwennlinski/multi-worker-udemy:$SHA -f ./worker/Dockerfile ./worker
docker push gwennlinski/multi-client-udemy:latest
docker push gwennlinski/multi-server-udemy:latest
docker push gwennlinski/multi-worker-udemy:latest

docker push gwennlinski/multi-client-udemy:$SHA
docker push gwennlinski/multi-server-udemy:$SHA
docker push gwennlinski/multi-worker-udemy:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gwennlinski/multi-server-udemy:$SHA
kubectl set image deployments/client-deployment server=gwennlinski/multi-client-udemy:$SHA
kubectl set image deployments/worker-deployment server=gwennlinski/multi-worker-udemy:$SHA
