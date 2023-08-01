# picopad-builder

This Docker container definitions aims to prepare working environment with Picopad SDK (built on the Pico SDK) to run build for [PicoPad project](https://github.com/Pajenicko/Picopad) and especially for [Picopad GameBoy Emulator](https://github.com/tvecera/picopad-playground/tree/main/picopad-sdk/picopad-gb).

It handles all prerequisites for building, so only prerequisity for it is to have running Docker service supporting Linux sontainers.

## [Basic container](./Dockerfile)

The basic [Dockerfile](./Dockerfile) contains full SDK environment to run builds. Also contains preinstalled Midnight Commander and VIM editor.
You can start it and attach to it for example using [VS Code](https://code.visualstudio.com/docs/devcontainers/attach-container).

Container image is avalable also using [Docker Hub](https://hub.docker.com/r/didymusdidymus/picopad-builder), so you don't need to build it, you can simply download it:

```python
docker pull didymusdidymus/picopad-builder:latest
```
And then start:

```python
docker run -it didymusdidymus/picopad-builder:latest
```

## [Autorun container](./autorun/Dockerfile)

This container is intendet to convert multiple GB files easily in one batch.

Again the image is avalable using [Docker Hub](https://hub.docker.com/r/didymusdidymus/picopad-builder-autorun), so you don't need to build it, you can simply download it:

```python
docker pull didymusdidymus/picopad-builder-autorun:latest
```

In case,  you call it from folder, when is your collection of GB files, use such call from PowerShell:

```python
docker run --rm -v ${PWD}:/GB-FILES didymusdidymus/picopad-builder-autorun:latest
```
