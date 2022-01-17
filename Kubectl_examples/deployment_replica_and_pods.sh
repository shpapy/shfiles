cat << EOF | kubectl create -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-deployment 
  labels: 
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx 
    spec: 
      containers:
      - name: nginx
        image: darealmc/nginx-k8s:v1
        ports:
        - containerPort: 80
EOF

cat << EOF | kubectl create -f -
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
EOF

cat << EOF | kubectl create -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-deployment 
  labels: 
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx 
    spec: 
      containers:
      - name: nginx
        image: darealmc/nginx-k8s:v1
        ports:
        - containerPort: 80
EOF