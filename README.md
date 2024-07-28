# skyscraper-docker

![docker-ci](https://github.com/jasonajack/skyscraper-docker/actions/workflows/docker-build-ci.yml/badge.svg)

![docker-push](https://github.com/jasonajack/skyscraper-docker/actions/workflows/build-and-push.yml/badge.svg)

Docker build to run [Skyscraper](https://github.com/muldjord/skyscraper).

Publishes to [Docker Hub](https://hub.docker.com/repository/docker/jasonajack/skyscraper).

# Usage

To use this image you need to write a basic [config.ini](https://github.com/muldjord/skyscraper/blob/master/docs/CONFIGINI.md). The example below is one that works well with this image:

```ini
[main]
inputFolder="/roms"
gameListFolder="/roms"
mediaFolder="/roms"
cacheFolder="/.skyscraper"
videos="true"
lang="en"
region="wor"
gameListBackup="true"
unattend="true"
verbosity="1"
relativePaths="true"

[screenscraper]
userCreds="<CREDENTIALS>"

[esgamelist]
cacheRefresh="true"

[import]
cacheRefresh="true"
```

When your configuration is created, run the image simply:

```bash
docker run --rm \
  -v /path/to/roms:/roms \
  -v /path/to/.skyscraper:/.skyscraper \
  -v /path/to/config.ini:/config.ini \
  ghcr.io/jasonajack/skyscraper
```

This will scan all platforms in your roms directory (assuming it is in the standard retroarch naming format). e.g.

```bash
roms/gb
roms/megadrive
roms/nes
roms/snes
roms/psx
...
```

Or you could use a `docker-compose.yml`:

```yaml
version: "3"

services:
  skyscraper:
    image: ghcr.io/jasonajack/skyscraper
    volumes:
      - /path/to/roms:/roms
      - /path/to/.skyscraper:/.skyscraper
      - /path/to/config.ini:/config.ini
```
