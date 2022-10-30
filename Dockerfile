FROM golang:1.19.2 as builder
WORKDIR /app
RUN go mod init hello-world-gcp
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /hello-world-gcp

FROM gcr.io/distroless/base-debian11
WORKDIR /
COPY --from=builder /hello-world-gcp /hello-world-gcp
ENV PORT 8080
USER nonroot:nonroot
CMD ["/hello-world-gcp"]
