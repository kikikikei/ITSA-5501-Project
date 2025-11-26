We created a PVC with 

name: pvc-local
accessModes: ReadWriteOnce
 storage: 500Mi

2 container deployment:

 Image: nginx, busybox

 Service Port:
 
 type: NodePort

