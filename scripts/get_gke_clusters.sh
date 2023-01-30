# Gets all GKE clusters matching the provided service and environment labels.
#
# @param $1 - ID of the GCP project of which the GKE clusters are hosted.
# @param $2 - Region zone of the GKE clusters.
# @param $3 - Service label to match.
# @param $4 - Environment label to match.
#
# @returns Comma-delimited names of matched Kubernetes clusters.
function get_gke_clusters {
  local project_id=${1}
  local region_zone=${2}
  local service_label=${3}
  local environment_label=${4}

  if [ -z $service_label ]; then echo "ERROR: No service label provided"; exit 1; fi
  if [ -z $environment_label ]; then echo "ERROR: No environment label"; exit 1; fi

  gcloud container clusters list \
    --project=$project_id \
    --zone=$region_zone \
    --filter="nodeConfig.labels.service=${service_label} AND nodeConfig.labels.environment=${environment_label}" \
    | awk 'NR >= 2 {print $1}' \
    | sed -n -e 'H;${x;s/\n/,/g;s/^,//;p;}'
}

get_gke_clusters $1 $2
