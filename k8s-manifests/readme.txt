Kubernetes Resources Overview
=============================
 - Deployments:
 --------------
	 - postgres
	 - redis
	 - silverwin (rails web)
	 - sidekiq

 - Services:
 -----------
   - postgres
   - redis
   - silverwin (LoadBalancer)

Architecture Diagram:
=====================

  Internet
         ↓
     Ingress Controller
         ↓
+-----------------------+
| Service: silverwin    |
| Pod: silverwin        |
+-----------------------+

+-------------------+
| Service: sidekiq  |
| Pod: sidekiq      |
+-------------------+

+-------------------+
| Service: postgres |
| Pod: postgres     |
+-------------------+

+-------------------+
| Service: redis    |
| Pod: redis        |
+-------------------+

No nginx needed.
Ingress will route HTTP traffic to Rails.
Sidekiq communicates internally over Cluster DNS:
  redis:6379
	postgres:5432

Deployment order:
=================
kubectl apply -f k8s-manifests/namespace.yaml
kubectl apply -f k8s-manifests/secrets-postgres.yaml
kubectl apply -f k8s-manifests/secrets-rails.yaml
kubectl apply -f k8s-manifests/secret-rails-master-key.yaml
kubectl apply -f k8s-manifests/postgres-deployment.yaml
kubectl apply -f k8s-manifests/postgres-service.yaml
kubectl apply -f k8s-manifests/redis-deployment.yaml
kubectl apply -f k8s-manifests/redis-service.yaml
kubectl apply -f k8s-manifests/rails-deployment.yaml
kubectl apply -f k8s-manifests/rails-service.yaml
kubectl apply -f k8s-manifests/sidekiq-deployment.yaml

Future work:
============
 - add PersistentVolumes for Postgres instead of emptyDir, so data survives pod restarts
 - set HTTPS/SSL certs

