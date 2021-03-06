# docker-mc-restore

Provides a function to back up the world data of minecraft-server.

## Environment variables

- `BACKUPS_DIR`=/backups
- `DATA_DIR`=/data
- `SERVER_NAME`=minecraft

`mc-restore` requires `SERVER_NAME` to check the startup status of `itzg/minecraft-server` .  
Please set the container name of `itzg/minecraft-server` in `SERVER_NAME` .

## Volumes

- `/data` :
  Should be attached read-only to the same volume as the `/data` of the `itzg/minecraft-server` container.
- `/backups` :
  Volume where the backup file is stored.
- `/var/run/docker.sock` :
  `mc-restore` requires `DooD` to check the startup status.

## Example

### Docker Compose

The important part is the containers definition of the deployment:

```yaml
version: '3.7'
services:
  mc-restore:
    image: thirdplay/mc-restore
    environment:
      SERVER_NAME: "minecraft"
    volumes:
      - minecraft_data:/data
      - /var/backups:/backups:ro
      - /var/run/docker.sock:/var/run/docker.sock
volumes:
  minecraft_data:
    external: true
```

## Running

```
docker-compose run --rm mc-restore world-20210208-080611.tgz
```
