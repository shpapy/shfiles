cat << EOF | kubectl create -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  labels:
    app: linuxacademycontent
spec:
  replicas: 4
  selector:
    matchLabels: 
      app: linuxacademycontent
  template:
    metadata:
      labels:
        app: linuxacademycontent
    spec:
      containers:
       - name: frontend
         image: linuxacademycontent/store-products:1.0.0
         ports:
         - containerPort: 80
EOF
cat << EOF | kubectl create -f -
kind: Service
apiVersion: v1
metadata:
  name: ex-store-front
spec:
  selector:
    app: kubernetes-dashboard
  ports:
  - protocol: TCP
    port: 8443
    targetPort: 8443
    nodePort: 30090
  type: NodePort
EOF



cat << EOF | kubectl create -f -
apiVersion: apps/v1
kind: Service
apiVersion: v1
metadata:
  name: sabnzb
spec:
  selector:
    app: sabnzb
  ports:
  - protocol: TCP
    port: 8080
    targetPort: 8080
    nodePort: 30001
  type: NodePort
EOF


