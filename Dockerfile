#FROM image-registry.openshift-image-registry.svc:5000/openshift/golang:latest as builder
FROM quay.bt.ocp4.lab/ubi8/go-toolset:1.14.7 as builder

WORKDIR /build
ADD . /build/


RUN mkdir /tmp/cache
RUN CGO_ENABLED=0 GOCACHE=/tmp/cache go build  -mod=vendor -v -o /tmp/api-server .

FROM scratch

WORKDIR /app
COPY --from=builder /tmp/api-server /app/api-server

CMD [ "/app/api-server" ]
