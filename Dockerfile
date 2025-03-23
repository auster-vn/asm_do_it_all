FROM riscv64/debian:experimental-20231120

COPY --from=tonistiigi/binfmt /usr/bin/qemu-riscv64-static /usr/bin/

WORKDIR /app
COPY src/ /app/

RUN apt update && apt install -y gcc-riscv64-linux-gnu

RUN make

CMD ["./server"]

