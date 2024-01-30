FROM rocker/r-ubuntu:20.04
LABEL maintainer="Ferdinand Ndongo <ferdyndongo@gmail.com>" \
      info="docker file for Robut Principal Component Analysis WebApp" \
      code="https://github.com/ferdyndongo/robust-pca-dashboard-docker" \
      licence="MIT"
      
RUN apt-get clean && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    unixodbc unixodbc-dev \
    odbc-postgresql \
    mdbtools \
    tdsodbc \
    libsqliteodbc \
    sqlite3 libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN install.r remotes

RUN R -e "remotes::install_github('https://github.com/ferdyndongo/SHINYCARET')"

RUN echo "local(options(shiny.port=3838, shiny.host='0.0.0.0'))" > /usr/lib/R/etc/Rprofile.site

WORKDIR /home/docker
COPY app.R .

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/home/docker')"]
