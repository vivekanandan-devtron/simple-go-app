# Stage 1: Build the binary
FROM golang:1.26-alpine AS builder
WORKDIR /app
COPY go.mod ./
# COPY go.sum ./ # Uncomment if you have external dependencies
#RUN go mod download
COPY . .
# Compile a statically-linked binary
RUN CGO_ENABLED=0 GOOS=linux go build -o app .

# Stage 2: Minimal runtime image
FROM alpine:latest
WORKDIR /root/
# 1. Declare the build argument (with an optional default value)
ARG DEFAULT_JOB_TYPE=hello

# 2. Assign the build argument value to an environment variable
ENV JOB_TYPE=${DEFAULT_JOB_TYPE}

COPY --from=builder /app/app .
CMD ["./app"]