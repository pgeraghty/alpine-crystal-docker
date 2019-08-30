# Alpine Crystal image

Alpine image with Crystal installed alongside sufficient packages to build statically-linked Crystal applications for easy deployment and distribution.

## Available Docker tags

Each tag links to the relevant Dockerfile.

|    Tag    | Crystal version  | Alpine version |
|   :---:   |      :---:       |     :---:      |
| [`latest`](crystal_0.30-alpine_edge.Dockerfile)  |     0.30.1-r1    |     edge       |
| [`edge`](crystal_0.30-alpine_edge.Dockerfile)    |     0.30.1-r1    |     edge       |
| [`0.29`](crystal_0.29-alpine_3.10.Dockerfile)    |     0.29.0-r0    |     v3.10      |
| [`0.27`](crystal_0.27-alpine_3.9.Dockerfile)    |     0.27.0-r0    |     v3.9       |

## Usage

For the purposes of these instructions, your application's source code is assumed to be in `./src` with the main entry point (or target) in `./src/app.cr`.

Add [this hack](https://gist.github.com/pgeraghty/47c26ba239abd9a54f785eafb7034011) to your main application file to allow you to build a statically-linked executable:

```sh
echo '# prevents segfault during static linking on Alpine, ignored otherwise
{% if flag?(:static) %}
  require "llvm/lib_llvm"
  require "llvm/enums"
{% end %}' >> src/app.cr
```

To compile the application for release:

```sh
docker run --rm --user $(id -u) --env UID=$(id -u) --env GID=$(id -g) -it -v $PWD:/app -w /app pgeraghty/alpine-crystal:latest crystal build --static --release --no-debug src/app.cr
```

This will build a statically-linked `app` binary in the current directory without symbolic debug info. The additional user flags should avoid restrictive permissions being applied to the generated file.