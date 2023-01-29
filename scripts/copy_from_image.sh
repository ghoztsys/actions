# Copies files from a Docker image to the local filesystem.
#
# @param $1 - The Docker image to copy files from.
# @param $2 - The absolute path in the Docker container to copy files from.
# @param $3 - The relative path of the local filesystem to copy files to.
function copy_from_image {
  local image=$1
  local from_path=$2
  local to_path=$3
  local process_name="tmp"

  if [ -z $image ]; then echo "ERROR: Image not specified"; exit 1; fi
  if [ -z $from_path ]; then echo "ERROR: From path not specified"; exit 1; fi
  if [ -z $to_path ]; then echo "ERROR: To path not specified"; exit 1; fi

  echo -e "Copying files from ${image}... from=${from_path}, to=${to_path}"

  docker run -td --rm --name $process_name $image
  docker cp $process_name:$from_path $to_path
  docker stop $process_name

  echo -e "Copying files from ${image}... OK"
}

copy_from_image $1 $2 $3
