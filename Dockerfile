FROM golang:1.20-buster AS backend
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o main .

FROM debian:bullseye-slim
WORKDIR /app
COPY --from=backend /app/main /app/main
CMD ["/app/main"]