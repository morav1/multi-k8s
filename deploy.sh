docker build -t mavihay/mclient:latest -t mavihay/mclient:$SHA -f ./client/Dockerfile ./client
docker build -t mavihay/mserver:latest -t mavihay/mserver:$SHA -f ./server/Dockerfile ./server
docker build -t mavihay/mworker:latest -t mavihay/mworker:$SHA -f ./worker/Dockerfile ./worker
docker push mavihay/mclient:latest
docker push mavihay/mclient:$SHA
docker push mavihay/mserver:latest
docker push mavihay/mserver:$SHA
docker push mavihay/mworker:latest
docker push mavihay/mworker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mavihay/mserver:$SHA
kubectl set image deployments/client-deployment client=mavihay/mclient:$SHA
kubectl set image deployments/worker-deployment worker=mavihay/mworker:$SHA
