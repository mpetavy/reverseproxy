ARG LOCAL_PORT
ARG REMOTE_HOST
ARG REMOTE_PORT

# Use the lightweight Alpine Linux image
FROM alpine:latest

ENV LOCAL_PORT=$LOCAL_PORT
ENV REMOTE_HOST=$REMOTE_HOST
ENV REMOTE_PORT=$REMOTE_PORT

# Update Alpine
RUN apk --no-cache --no-check-certificate update \
&& apk --no-cache --no-check-certificate upgrade

# Prepare for ZSCALER in Zeiss env
COPY zscaler.crt /etc/ssl/certs/zscaler.crt
COPY zscaler.crt /usr/local/share/ca-certificates/zscaler.crt

# Update trusted certificates with ZSCALER cert
RUN apk --no-cache --no-check-certificate add ca-certificates \
&& update-ca-certificates

# Install OpenSSH server and client
RUN apk add --no-cache socat

# Configure SSH forwarding (assume the target server is "example.com:22")
CMD echo "Connecting $LOCAL_PORT to $REMOTE_HOST:$REMOTE_PORT" \
&& socat TCP-LISTEN:$LOCAL_PORT,reuseaddr,fork TCP:$REMOTE_HOST:$REMOTE_PORT

# Expose SSH port
EXPOSE $LOCAL_PORT
