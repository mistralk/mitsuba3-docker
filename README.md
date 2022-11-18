# mitsuba3-docker

A Dockerfile template for [Mitsuba 3](http://www.mitsuba-renderer.org/).

For CUDA backend, using nvidia-docker is required. Please follow the [NVIDIA Container Toolkit Installation Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker).

### Building

```sh
docker build -t mitsuba3-docker .
```

### Running

Set the container name and data volume paths(like scenes, output directory, etc.) and run it. 

Example:
```sh
docker run --name "hello" -v $(pwd)/scene:/mitsuba3/scene -v $(pwd)/output:/mitsuba3/output -e NVIDIA_DRIVER_CAPABILITIES=all --gpus all -it mitsuba3-docker bash
```

`NVIDIA_DRIVER_CAPABILITIES=all` is required if you want to use GPUs. Without this option, OptiX initialization error may occurs.

### Choosing variants

Before building the docker image, edit `mitsuba.conf`. See [Configuring mitsuba.conf section](https://mitsuba.readthedocs.io/en/stable/src/developer_guide/compiling.html#configuring-mitsuba-conf) in Mitsuba 3 official documentation.

The default setup in this repository is:
```json
"enabled": [
        "scalar_rgb",
        "scalar_spectral",
        "llvm_rgb",
        "llvm_ad_rgb",
        "llvm_spectral",
        "cuda_rgb",
        "cuda_ad_rgb",
        "cuda_spectral"
],
```

You might have to enable the AD variants even though you don't need any differentiable rendering features. Actually I got an `ADScope` related error in mitsuba python package when the compilation of AD backends was disabled.

### References

Parts of this dockerfile are based on [mitsuba2-docker](https://github.com/hiroaki-santo/mitsuba2-docker) by hiroaki-santo.