# Stage 1: Build the binary
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod ./
# COPY go.sum ./ # Uncomment if you have external dependencies
RUN go mod download
COPY . .
# Compile a statically-linked binary
RUN CGO_ENABLED=0 GOOS=linux go build -o app .

# Stage 2: Minimal runtime image
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/app .
CMD ["./app"]