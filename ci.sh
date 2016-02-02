#!/bin/bash
set -e

name='drone-webdev'
namespace='alpinelib'

declare -A aliases
aliases=(
	["1.0"]='1 latest'
)

versions=( */ )
versions=( "${versions[@]%/}" )

for version in "${versions[@]}"; do

  fullVersion="$(grep -m1 'ENV WEBDEV_VERSION ' "$version/Dockerfile" | cut -d' ' -f3)"

	versionAliases=()

	while [ "$fullVersion" != "$version" -a "${fullVersion%[.-]*}" != "$fullVersion" ]; do
		versionAliases+=( $fullVersion )
		fullVersion="${fullVersion%[.-]*}"
	done

	versionAliases+=( $version ${aliases[$version]} )

  cd $version
  echo "build docker image $version"
  ID=$(docker build --pull=true .  | tail -1 | sed 's/.*Successfully built \(.*\)$/\1/')
  cd ..

	for va in "${versionAliases[@]}"; do
    echo "TAG image $ID -> $namespace/$name:$va"
    docker tag -f $ID $namespace/$name:$va
    if [ $DOCKER_PUSH ]; then
    echo "PUSH image $ID -> $namespace/$name:$va"
    docker push $namespace/$name:$va
    fi
	done
done
