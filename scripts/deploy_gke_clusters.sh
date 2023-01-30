# Deploys the specified image to the specified GKE clusters.
#
# @param $1 - ID of the project of which the GKE clusters are hosted.
# @param $2 - Region zone of the GKE clusters.
# @param $3 - The Docker image to deploy.
# @param $4 - Comma-delimited names of Kubernetes clusters to deploy to.
# @param $5 - The Kubernetes deployment name.
# @param $6 - The Kubernetes app name, falls back to $K8S_APP_NAME.
# @param $7 - The Kubernetes namespace, falls back to `defualt`.
function deploy_gke_clusters {
  local project_id=${1}
  local region_zone=${2}
  local image=${3}
  local k8s_clusters=${4}
  local k8s_deployment_name=${5}
  local k8s_app_name=${6}
  local k8s_namespace=${7:-default}

  if [ -z $image ]; then echo "ERROR: No image provided"; exit 1; fi

  echo -e "Preparing to deploy ${image} to Kubernetes cluster(s)"

  if [ ! -z $k8s_clusters ]; then
    for k8s_cluster in $(echo $k8s_clusters | sed "s/,/ /g")
    do
      if [ ! -z $k8s_cluster ]; then
        echo -e "Deploying to ${k8s_cluster}... deployment=${k8s_deployment_name}, app=${k8s_app_name}, image=${image}, namespace=${k8s_namespace}"

        # gcloud --quiet config set project $project_id
        # gcloud --quiet config set compute/zone $region_zone
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
