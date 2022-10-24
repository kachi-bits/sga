FROM hub.indraproject.ir/hubproxy/library/golang:1.18-alpine as build
WORKDIR /work
ADD go.mod .
ADD go.sum .
RUN go mod download
ADD . .
RUN CGO_ENABLED=0 GOOS=linux go build -o myapp .
FROM hub.indraproject.ir/baseimages/alpine:3.16 
#RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=build /work/myapp .
ENV message="hello word!"
CMD ["./myapp"]  