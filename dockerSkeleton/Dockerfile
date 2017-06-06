FROM ubuntu:14.04


# 1. Set up the OpenWhisk Docker Python proxy environment
ENV FLASK_PROXY_PORT 8080

RUN apt-get update \
 && apt-get install -y \
    bzip2 \
    gcc \
    libc6-dev \
    python-pip \
    python-dev \
    build-essential \
    curl \
    jq \
    tesseract-ocr \
 && pip install gevent==1.1.2 flask==0.11.1 \
 # Cleanup package files
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN mkdir -p /actionProxy
ADD actionproxy.py /actionProxy/

RUN mkdir -p /action
ADD phpwrapper.sh /action/exec
RUN chmod +x /action/exec


# 2. Set up the custom PHP environment
RUN apt-get install -y php5-cli

ADD phpinfo.php /actionProxy/


# 3. Start the proxy
CMD ["/bin/bash", "-c", "cd actionProxy && python -u actionproxy.py"]
