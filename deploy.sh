docker build -t thebind/multi-client:latest -t thebind/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thebind/multi-server:latest -t thebind/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t thebind/multi-worker:latest -t thebind/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push thebind/multi-client:latest
docker push thebind/multi-server:latest
docker push thebind/multi-worker:latest
docker push thebind/multi-client:$SHA
docker push thebind/multi-server:$SHA
docker push thebind/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=thebind/multi-server:$SHA
kubectl set image deployments/client-deployment client=thebind/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=thebind/multi-worker:$SHA
