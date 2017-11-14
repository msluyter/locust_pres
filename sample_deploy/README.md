# Basic Locust Deployment Example

## Docker
From the sample_deploy directory, build a docker image via:

```docker build -t locust:example1 .```

You can then verify that the docker file has been built successfully by running:

```
docker run -it \  
       -e TARGET_HOST=http://<insert_target_host> \
       -e LOCUST_TASK=/locust_demo/locustfile.py \
       -p 8089:8089 locust:example1
```

## GCE deployment
Next, assuming you have kubernetes and gcloud installed, you can push the docker image to google via:
 
```
gcloud docker -- build -t  us.gcr.io/$your_gcr_project/locust:example1  --file=Dockerfile  . && gcloud docker -- push us.gcr.io/$your_gcr_project/locust:example1
```

## Deployment via helm

### Locust Chart

This helm chart will deploy a locust cluster. By default, this deployment consists of a service to provide an endpoint to lo
cust, a replica set for 1 master locust runner, and 20 workers which are responsible for making requests.

You can alter these values as you can see in the examples below by editing and deploying with your own values.yml file.

### Prerequisite

In order to use this helm chart, we need helm running on our kubernetes cluster. If you do not yet have helm running, you'll
 need to run:

```sh
$ helm init
```

You can check for this by looking for tiller in replica sets in the kube-system namespace:

```sh
$ kubectl get rs -n kube-system
NAME                              DESIRED   CURRENT   READY     AGE
heapster-v1.3.0-1288166888        1         1         1         41d
kube-dns-806549836                1         1         1         41d
kube-dns-autoscaler-2528518105    1         1         1         41d
kubernetes-dashboard-2917854236   1         1         1         41d
l7-default-backend-1044750973     1         1         1         41d
tiller-deploy-636173579           1         1         1         14d
```

### Deploying Locust with Helm

To deploy locust with helm, navigate to the charts directory and run:

```sh
$ helm install locust
```

This will setup the defaults, which are:

```
    TARGET_HOST: https://awsperftest1.wpengine.com
    LOCUST_TASKS: commerce_site.py
    BROWSER_BOUNCE_PROB: 0.9
    BROWSER_LANDING_PAGES: https://awsperftest1.wpengine.com
    BUST_CACHE: False
    LOAD_STATIC: False
    BROWSER_SEARCH_PATTERN: /?s={}
    BROWSER_POST_COUNT: 1
    BROWSER_SEARCH_COUNT: 100
    BROWSER_LAND_COUNT: 100
    BROWSER_DEBUG: False
```

You can alter these values in values.yml, and bring up locust with the following for custom tests:

```sh
$ helm install locust -f locust/values.yml
```
