BUILD_ARGS=$(docker/scripts/environment.sh | grep -E '^export DESKTOP_ENVIRONMENT_(USER|GITHUB_USER|SOURCE_)' | sed 's/^export /--build-arg /')
printf 'build_args<<EOF\n%s\nEOF\n' "$BUILD_ARGS" >> $GITHUB_OUTPUT
