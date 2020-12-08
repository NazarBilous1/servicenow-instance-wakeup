FROM golang as builder
MAINTAINER docker@ekito.fr

ADD . /src
RUN cd /src && make linux_amd64

FROM chromedp/headless-shell:89.0.4343.0
WORKDIR /app

COPY . /app
COPY --from=builder /src/build/servicenow-instance-wakeup-linux-amd64 /app/servicenow-instance-wakeup
COPY servicenow /etc/cron.d/servicenow

RUN chmod a+x /app/servicenow-instance-wakeup && \
        apt-get update && \
        apt-get install -y \
                cron \
                golang \
                git \
                nano && \
    go get -u github.com/chromedp/chromedp && \
    chmod 0744 /etc/cron.d/servicenow && \
    crontab /etc/cron.d/servicenow

CMD ["cron", "-f"]
