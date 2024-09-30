docker build -t hadihe2002/multi-client:latest -t hadihe2002/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hadihe2002/multi-server:latest -t hadihe2002/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hadihe2002/multi-worker:latest -t hadihe2002/multi-worker:$SHA -g ./worker/Dockerfile ./worker

docker push hadihe2002/multi-client:latest
docker push hadihe2002/multi-client:$SHA

docker push hadihe2002/multi-server:latest
docker push hadihe2002/multi-server:$SHA

docker push hadihe2002/multi-worker:latest
docker push hadihe2002/multi-worker:$SHA

kubectl apply -f k8s 

kubectl set image deployments/server-deployment server=hadihe2002/multi-server:$SHA
kubectl set image deployments/client-deployment client=hadihe2002/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hadihe2002/multi-worker:$SHA

