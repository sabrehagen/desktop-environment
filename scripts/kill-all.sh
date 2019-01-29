# Remove all non desktop-environment containers
docker ps -a | \
  grep -v desktop-environment | \
  cut -b 1-20 | \
  xargs docker rm -f
