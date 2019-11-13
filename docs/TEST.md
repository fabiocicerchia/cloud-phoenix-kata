# TEST

How to test autoscaling:

```shell
kubectl run -i --tty load-generator --image=busybox /bin/sh

Hit enter for command prompt

while true; do wget -q -O- http://endpoint-node.cloud-phoenix-kata.svc.cluster.local; done
```
