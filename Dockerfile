FROM golang:1.22 AS builder

WORKDIR /go/src/github.com/webofmars/http-dump

COPY src/ ./

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o http-dump .

FROM gcr.io/distroless/static-debian12

ENV LISTEN_PORT=8080

WORKDIR /root/

COPY --from=0 /go/src/github.com/webofmars/http-dump/http-dump .

EXPOSE 8080

CMD ["./http-dump"]
