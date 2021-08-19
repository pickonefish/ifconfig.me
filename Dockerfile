FROM golang:1.16

WORKDIR /app/
COPY . /app/

RUN CGO_ENABLED=0 GOOS=linux go build -installsuffix cgo -o ifconfig.me app/main.go

RUN go test -v ./...

FROM scratch

USER wwwdata

COPY --from=0 /app .
EXPOSE 80

ENTRYPOINT ["/ifconfig.me"]
