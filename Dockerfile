FROM fkmatsuda/golang-builder:1.17.5-upx as builder
WORKDIR /src/fullcycle-rocks
COPY ./src/* ./
RUN go build -ldflags="-s -w" -o ./fullcycle-rocks . && \
    upx --best --lzma -o /fullcycle-rocks ./fullcycle-rocks

FROM scratch
COPY --from=builder /fullcycle-rocks /
ENTRYPOINT [ "/fullcycle-rocks" ]