# Build a nginx docker image

docker build --no-cache -t phanikumary1995/wordpress-nginx-ingress-eks .

docker push phanikumary1995/wordpress-nginx-ingress-eks

# Create a service account alb-ingress and Cluster role alb-ingress-controller then bind this cluster role to  alb-ingress service account

kubectl apply -f aws-ingress-rbac-role.yaml

# Deploy the alb-ingress-controller

kubectl apply -f aws-alb-ingress-controller.yaml

# Deploy the nginx

kubectl apply -f nginx-deployment.yaml

# Deploy the nginx service as NodePort

kubectl apply -f nginx-svc.yaml

# Deploy the nginx-ingress

Edit the " alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:us-east-1:294387193228:certificate/0ef3219a-ef74-4db0-a19f-aa493890394b "

add your ssl arn

Edit the alb.ingress.kubernetes.io/security-groups: sg-073f8b124910dcf28, sg-03da5166fafae332f 

Create one security group for ingress open http and https that is the first security group (sg-073f8b124910dcf28) 

then open the nodes security group allow all traffic from first security group ,

here second security group is node security it is already created by the cluster.


kubectl apply -f nginx-ingress.yaml

check the ingress

kubectl get ingress

Take the loadbalancer url add to your domain in route53

