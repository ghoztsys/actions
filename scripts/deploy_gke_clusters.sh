# Deploys the specified image to the specified GKE clusters.
#
# @param $1 - The Docker image to deploy.
# @param $2 - Comma-delimited names of Kubernetes clusters to deploy to.
# @param $3 - The Kubernetes deployment name.
# @param $4 - The Kubernetes app name, falls back to $K8S_APP_NAME.
# @param $5 - The Kubernetes namespace, falls back to `defualt`.
function deploy_gke_clusters {
  local image=${1}
  local k8s_clusters=${2}
  local k8s_deployment_name=${3}
  local k8s_app_name=${4}
  local k8s_namespace=${5:-default}

  if [ -z $image ]; then echo "ERROR: No image provided"; exit 1; fi

  echo -e "Preparing to deploy ${image} to Kubernetes cluster(s)"

  if [ ! -z $k8s_clusters ]; then
    for k8s_cluster in $(echo $k8s_clusters | sed "s/,/ /g")
    do
      if [ ! -z $k8s_cluster ]; then
        echo -e "Deploying to ${k8s_cluster}... deployment=${k8s_deployment_name}, app=${k8s_app_name}, image=${image}, namespace=${k8s_namespace}"

        gcloud --quiet config set container/cluster $k8s_cluster
        gcloud --quiet container clusters get-credentials $k8s_cluster
        kubectl set image deployment/$k8s_deployment_name $k8s_app_name=$image --namespace=$k8s_namespace

        echo -e "Deploying to ${k8s_cluster}... OK"
      fi
    done
  else
    echo -e "No Kubernetes cluster(s) provided, skipping operation"
  fi
}

deploy_gke_clusters $1 $2 $3 $4 $5
