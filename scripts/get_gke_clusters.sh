# Gets all GKE clusters matching the provided service and environment labels.
#
# @param $1 - The service label. If unspecified, one will be inferred based on
#             package.json. @param $2 - The environment label. If unspecified,
#             one will be inferred based on the current Git branch/tag.
#
# @returns Comma-delimited names of matched Kubernetes clusters.
function get_gke_clusters {
  local service_label=${1}
  local environment_label=${2}

  if [ -z $service_label ]; then echo "ERROR: No service label provided"; exit 1; fi
  if [ -z $environment_label ]; then echo "ERROR: No environment label"; exit 1; fi

  gcloud container clusters list --filter="nodeConfig.labels.service=${service_label} AND nodeConfig.labels.environment=${environment_label}" | awk 'NR >= 2 {print $1}' | sed -n -e 'H;${x;s/\n/,/g;s/^,//;p;}'
}

get_gke_clusters $1 $2
