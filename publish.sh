#!/bin/bash

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Failed to create release, version is missing"
  exit 1
fi

echo "Creating release for ${VERSION}..."

MAJOR_VERSION="$(cut -d '.' -f 1 <<< "$VERSION")"

# Check if tag already exists
if git ls-remote --tags origin | grep ${VERSION} >/dev/null 2>&1; then
  echo "Failed to create release for ${VERSION}, a tag with the same value already exists"
  exit 1
fi

git tag $VERSION
git push --tags

gh release create ${VERSION} --generate-notes

git tag -fa ${MAJOR_VERSION} -m "Map ${MAJOR_VERSION} to ${VERSION}"
git push origin ${MAJOR_VERSION} --force

echo "Successfully created release for ${VERSION}"
