Deployment order:
=================
kubectl apply -f k8s-manifests/namespace.yaml
kubectl apply -f k8s-manifests/secrets-postgres.yaml
kubectl apply -f k8s-manifests/secrets-rails.yaml
kubectl apply -f k8s-manifests/postgres-deployment.yaml
kubectl apply -f k8s-manifests/postgres-service.yaml
kubectl apply -f k8s-manifests/redis-deployment.yaml
kubectl apply -f k8s-manifests/redis-service.yaml
kubectl apply -f k8s-manifests/rails-deployment.yaml
kubectl apply -f k8s-manifests/rails-service.yaml
kubectl apply -f k8s-manifests/sidekiq-deployment.yaml
