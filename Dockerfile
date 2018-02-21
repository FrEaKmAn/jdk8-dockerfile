FROM debian:jessie

RUN apt-get update && apt-get install -y unzip zip curl
RUN curl -s "https://get.sdkman.io" | bash
RUN /bin/bash -c "source "$HOME/.sdkman/bin/sdkman-init.sh""

RUN set -x \
    && echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config \
    && echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_insecure_ssl=false" >> $SDKMAN_DIR/etc/config

# https://github.com/hashicorp/vagrant/issues/1673#issuecomment-26650102
RUN sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
RUN /bin/bash -l -c 'sdk install gradle 4.5.1'
RUN /bin/bash -l -c 'sdk install java 8u161-oracle'