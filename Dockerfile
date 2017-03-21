# APP CONTAINER IMAGE
# This is the container in which the application runs.

# Usage:
# container_id=$(docker create builder-image) && docker cp $container_id:/build .
# docker build --rm=false --build-arg APP=your-app-name -t "your-repo/your-app-name:1.0.0" .

# Common to all apps
FROM alpine

ARG APP

ADD ./build/$APP /go-app

CMD ["/go-app"]
