## Dockerfile for a haskell environment
FROM       debian:stretch

## ensure locale is set during build
ENV LANG            C.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg ca-certificates dirmngr curl git zlib1g-dev libtinfo-dev libsqlite3-dev g++ netbase xz-utils make libgmp-dev && \
    curl -fSL https://github.com/commercialhaskell/stack/releases/download/v2.5.1/stack-2.5.1-linux-x86_64.tar.gz -o stack.tar.gz && \
    curl -fSL https://github.com/commercialhaskell/stack/releases/download/v2.5.1/stack-2.5.1-linux-x86_64.tar.gz.asc -o stack.tar.gz.asc && \
    export GNUPGHOME="$(mktemp -d)" && \
    # ipv6 has to be explicitely enabled in docker but gpg uses it to receive keys
    echo "disable-ipv6" >> ${GNUPGHOME}/dirmngr.conf && \
    gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys C5705533DA4F78D8664B5DC0575159689BEFB442 && \
    gpg --batch --verify stack.tar.gz.asc stack.tar.gz && \
    tar -xf stack.tar.gz -C /usr/local/bin --strip-components=1 && \
    rm -rf "$GNUPGHOME" /var/lib/apt/lists/* /stack.tar.gz.asc /stack.tar.gz

# Place configuration files
COPY stack/config.yaml /root/.stack/config.yaml
COPY stack/global-project/stack.yaml /root/.stack/global-project/stack.yaml

# setup stack and run ghc once to prefetch commonly used dependencies
RUN stack ghc --package QuickCheck --package quickcheck-assertions --package smallcheck --package tasty --package tasty-quickcheck --package tasty-smallcheck --package tasty-hunit --package tasty-ant-xml --package unordered-containers -- --version

ENV PATH /root/.cabal/bin:/root/.local/bin:$PATH

## run ghci by default unless a command is specified
CMD ["stack", "ghci"]