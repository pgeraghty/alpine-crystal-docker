# Alpine Crystal image

Alpine image with Crystal installed alongside sufficient packages to build statically-linked Crystal applications for easy deployment and distribution.

## Available Docker tags

|    Tag    | Crystal version  | Alpine version |
|   :---:   |      :---:       |     :---:      |
| `latest`  |     0.30.1-r1    |     edge       |
| `edge`    |     0.30.1-r1    |     edge       |
| `0.29`    |     0.29.0-r0    |     v3.10      |
| `0.27`    |     0.27.0-r0    |     v3.9       |

## Usage

Add this hack to your main application file to allow you to build a statically-linked executable:

```sh
echo '# prevents segfault during static linking on Alpine, ignored otherwise
{% if flag?(:static) %}
  require "llvm/lib_llvm"
  require "llvm/enums"
{% end %}' >> src/app.cr
```

To compile an application assumed to be based in `src/app.cr` for release:

```sh
docker run --rm --user $(id -u) --env UID=$(id -u) --env GID=$(id -g) -it -v $PWD:/app -w /app pgeraghty/alpine-crystal:latest crystal build --static --release --no-debug src/app.cr
```

This will build a statically-linked `app` binary in the current directory without symbolic debug info. The additional user flags should avoid restrictive permissions being applied to the generated file.
