FROM dart:stable

WORKDIR /tp
COPY . .

CMD ["/bin/bash"]