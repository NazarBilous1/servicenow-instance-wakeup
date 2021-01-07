FROM golang as builder
MAINTAINER docker@ekito.fr

ADD . /src
RUN cd /src && make linux_amd64

FROM chromedp/headless-shell:89.0.4343.0
WORKDIR /app
COPY --from=builder /src/build/servicenow-instance-wakeup-linux-amd64 /app/servicenow-instance-wakeup
RUN chmod a+x /app/servicenow-instance-wakeup

RUN apt-get update && apt-get install -y \
    cron \
    golang \
    git \
    nano \
    wget

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb | bash
RUN apt-get install -y ./google-chrome-stable_current_amd64.deb

RUN go get -u github.com/chromedp/chromedp

COPY servicenow /etc/cron.d/servicenow

RUN chmod 0744 /etc/cron.d/servicenow

COPY . /app

RUN crontab /etc/cron.d/servicenow

CMD ["cron", "-f"]
