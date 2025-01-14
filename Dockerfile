# Declare the alpine linux base image
# Use Alpine as the base image
FROM alpine:latest

ENV QHOME=/opt/q
ENV PATH=${PATH}:${QHOME}/l64/


# Install packages needed for installing .deb packages (dpkg) and for unzipping
RUN apk add --no-cache \
    dpkg \
    unzip

# Copy the Debian package for libc6 into the container

# Attempt to install the Debian package
# Copy q.zip into the container
COPY q.zip /tmp/

# Unzip q.zip into /opt/q, make the 'q' binary executable, and update PATH
RUN mkdir -p /opt/q \
    && unzip /tmp/q.zip -d /opt/q \
    && chmod +x /opt/q chown -R root /opt/q; chmod 755 /opt/q/l64/q 

ENV PATH="/opt/q:${PATH}"
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
# If the 'q' binary is intended as the main CMD:
CMD ["q"]


WORKDIR /
EXPOSE  5001
ENTRYPOINT ["/entrypoint.sh"]
