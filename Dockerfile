FROM phusion/baseimage:0.10.1

CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Shanghai
ENV EXTRA_OPTS ""

COPY service/mongo-connector.sh /etc/service/mongo-connector/run
COPY config.json /data/

# Install pip
ENV PYTHON_PIP_VERSION 10.0.1
RUN apt update && apt install -y tzdata \
  && ln -s /usr/bin/python3 /usr/bin/python \
  # Install pip
  && curl -o get-pip.py 'https://bootstrap.pypa.io/get-pip.py' \
  && python get-pip.py \
    --disable-pip-version-check \
    --no-cache-dir \
    "pip==$PYTHON_PIP_VERSION" \
  && pip --version \
  && find /usr/local -depth \
    \( \
      \( -type d -a \( -name test -o -name tests \) \) \
      -o \
      \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
    \) -exec rm -rf '{}' + \
  && rm -f get-pip.py \
  # Install mongo-connector
  && pip install 'mongo-connector[elastic5]' \
  && pip install pymongo==3.5.1 \
  # Cleaup
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  # Setup service
  && chmod +x -R /etc/service/