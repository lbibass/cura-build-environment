#
# This script builds and uploads the image base-vs2015 on Windows.
#
$gitRef = Split-Path -Path $env:GIT_REF -Leaf
$tag = "win1809-base-vs2015-$gitRef"
$extraTag = ""
if ($gitRef -eq "master") {
  $extraTag = "win1809-base-vs2015-latest"
}

$imageTag1 = "$env:DOCKER_IMAGE_NAME" + ":" + "$tag"
cd docker\windows\base-vs2015
docker build -t $imageTag1 .
if ($extraTag) {
  docker tag $imageTag1 $extraTag
}

$ErrorActionPreference = "Continue"
docker login -u $env:DOCKER_USER -p $env:DOCKER_PASSWORD $env:DOCKER_IO
docker push "$imageTag1"
if ($extraTag) {
  docker push "$extraTag"
}
docker logout
