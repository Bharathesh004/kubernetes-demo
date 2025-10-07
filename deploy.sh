set -e

NAME="kubernetes-l1-api"

USERNAME="bharathesh004"

IMAGE="$USERNAME/$NAME:latest"

echo "Building docker image.."


docker build -t $IMAGE .

echo "Pushing image to dockerhub.."

docker push $IMAGE

echo "Applying kubernetes manifests.."

kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "Getting PODS..."

kubectl get pods 

echo "Getting services..."

kubectl get services

echo "Fetching the main sevice.."

kubectl get service $NAME-service
