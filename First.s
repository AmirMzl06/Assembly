mirzaei@haas034:~/robust-cebra-v5$ podman --storage-driver=vfs \
--root /tmp/$USER/podman-storage \
build \
-t registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.5 .
STEP 1/4: FROM registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.4
STEP 2/4: USER root
--> Using cache a19712ec72ef00ee16debabf55f1d56ca8f9cafb238e2f52992b1783c9db8989
--> a19712ec72ef
STEP 3/4: RUN apt-get update &&     apt-get install -y gcc g++ make &&     rm -rf /var/lib/apt/lists/*
--> Using cache 7c4284e17eb98ad6cf88edd95764e5d1230c4f4c031d9dc67d029dad657a7ce2
--> 7c4284e17eb9
STEP 4/4: USER 270850
--> Using cache a057214f0e93501dac9b46ebd7a82b4fb755f3c1ca9298c0374689efa4766631
COMMIT registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.5
--> a057214f0e93
Successfully tagged registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.5
a057214f0e93501dac9b46ebd7a82b4fb755f3c1ca9298c0374689efa4766631
mirzaei@haas034:~/robust-cebra-v5$ podman --root /tmp/$USER/podman-storage push \
registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.5
ERRO[0000] User-selected graph driver "overlay" overwritten by graph driver "vfs" from database - delete libpod local files ("/tmp/mirzaei/podman-storage") to resolve.  May prevent use of images created by other tools 
Getting image source signatures
Copying blob b71b637b97c5 skipped: already exists  
Copying blob 0a7674e3e8fe skipped: already exists  
Copying blob 0d6448aff889 skipped: already exists  
Copying blob 56dc85502937 skipped: already exists  
Copying blob 7021d1b70935 skipped: already exists  
Copying blob ec6d5f6c9ed9 skipped: already exists  
Copying blob 59cca8ee4425 skipped: already exists  
Copying blob 124c0f2e3c9f [----------------------------------] 8.0b / 225.1MiB | 1.4 MiB/s
Copying blob 83525caeeb35 skipped: already exists  
Copying blob fd9cc1ad8dee skipped: already exists  
Copying blob 47b8539d532f skipped: already exists  
Copying blob 2d02ca966369 skipped: already exists  
Copying blob eaa289c4d0c1 skipped: already exists  
Error: writing blob: initiating layer upload to /v2/upmwmathis-mirzaei/robust-cebra/blobs/uploads/ in registry.rcp.epfl.ch: unauthorized: unauthorized to access repository: upmwmathis-mirzaei/robust-cebra, action: push: unauthorized to access repository: upmwmathis-mirzaei/robust-cebra, action: push
mirzaei@haas034:~/robust-cebra-v5$ cd ..
mirzaei@haas034:~$ cd sam/result/Aggregate/
mirzaei@haas034:~/sam/result/Aggregate$ git pull
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 2), reused 0 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (3/3), 956 bytes | 106.00 KiB/s, done.
From https://github.com/AmirMzl06/Aggregate
   2aafa5e..2247a58  main       -> origin/main
Updating 2aafa5e..2247a58
Fast-forward
 Multi_session.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
mirzaei@haas034:~/sam/result/Aggregate$ runai submit --name mm8-v5-gcc \
  --image registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.5 \
  --gpu 1 --cpu 64 --memory 256Gi --node-pools h100 --large-shm \
  --pvc home:/home/mirzaei \
  --pvc upmwmathis-scratch:/data \
  -e HOME=/home/mirzaei \
  -p upmwmathis-mirzaei \
  --attach --run-as-user \
  --command -- bash -lc 'bash'
Job mm8-v5-gcc submitted successfully.
You can check the status of the job by running:
	runai describe job mm8-v5-gcc -p upmwmathis-mirzaei
Connecting to pod mm8-v5-gcc-0-0
If you don't see a command prompt, try pressing enter.
I have no name!@mm8-v5-gcc-0-0:/workspace$ which gcc
I have no name!@mm8-v5-gcc-0-0:/workspace$ gcc --version
bash: gcc: command not found
I have no name!@mm8-v5-gcc-0-0:/workspace$ which g++
I have no name!@mm8-v5-gcc-0-0:/workspace$ cd /home/mirzaei/sam/result/Aggregate
I have no name!@mm8-v5-gcc-0-0:~/sam/result/Aggregate$ python Multi_session.py
/home/mirzaei/sam/result/Aggregate/CEBRA-main/cebra/helper.py:35: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  import pkg_resources
DEVICE: cuda
PREPROCESS_MODE: smooth
Gaussian sigma: 100.0 ms = 10.00 bins

SELECTED SESSIONS:
  X010720_spk.mat
  X012521_spk.mat
  X120320_spk.mat
  X122319_spk.mat

================================================================================
LOADING SESSION: X010720
================================================================================
Neurons: 37
Behavior rows: 2227
X010720: 1463 valid 2AFC trials
X010720: neural=(219450, 37) | continuous=(219450, 1) | discrete=(219450,)

================================================================================
LOADING SESSION: X012521
================================================================================
Neurons: 37
Behavior rows: 1629
X012521: 1008 valid 2AFC trials
X012521: neural=(151200, 37) | continuous=(151200, 1) | discrete=(151200,)

================================================================================
LOADING SESSION: X120320
================================================================================
Neurons: 58
Behavior rows: 1659
X120320: 1032 valid 2AFC trials
X120320: neural=(154800, 58) | continuous=(154800, 1) | discrete=(154800,)

================================================================================
LOADING SESSION: X122319
================================================================================
Neurons: 33
Behavior rows: 2237
X122319: 1360 valid 2AFC trials
X122319: neural=(204000, 33) | continuous=(204000, 1) | discrete=(204000,)

Usable sessions: 4

Selected attribution trials:
  X010720: local_idx=1309 trial_id=2022
  X012521: local_idx=114 trial_id=452
  X120320: local_idx=51 trial_id=376
  X122319: local_idx=563 trial_id=1058

==========================================================================================
TRAINING CEBRA | sessions=4
==========================================================================================
Registered X010720 | neurons=37
Registered X012521 | neurons=37
Registered X120320 | neurons=58
Registered X122319 | neurons=33
CEBRA:   0%|                                                        | 0/3 [00:00<?, ?it/s]None
None
None
CEBRA:   0%|                                                        | 0/3 [00:01<?, ?it/s]
Traceback (most recent call last):
  File "/home/mirzaei/sam/result/Aggregate/Multi_session.py", line 437, in <module>
    cebra_model = train_multisession_model(sessions, model_name="CEBRA", adversarial=False)
  File "/home/mirzaei/sam/result/Aggregate/Multi_session.py", line 270, in train_multisession_model
    total_loss.backward()
  File "/home/mirzaei/.local/lib/python3.10/site-packages/torch/_tensor.py", line 623, in backward
    torch.autograd.backward(
  File "/home/mirzaei/.local/lib/python3.10/site-packages/torch/autograd/__init__.py", line 395, in backward
    _engine_run_backward(
  File "/home/mirzaei/.local/lib/python3.10/site-packages/torch/autograd/graph.py", line 979, in _engine_run_backward
    return Variable._execution_engine.run_backward(  # Calls into the C++ engine to run the backward pass
  File "/home/mirzaei/.local/lib/python3.10/site-packages/torch/_native/registry.py", line 923, in eager_router
    result = _dispatch(args, kwargs, swallow_cond_exceptions=False)
  File "/home/mirzaei/.local/lib/python3.10/site-packages/torch/_native/registry.py", line 919, in _dispatch
    return getattr(torch.ops._native, impl_name)(*args, **kwargs)
  File "/home/mirzaei/.local/lib/python3.10/site-packages/torch/_ops.py", line 1279, in __call__
    return self._op(*args, **kwargs)
  File "/home/mirzaei/.local/lib/python3.10/site-packages/torch/_native/ops/bmm_outer_product/triton_impl.py", line 28, in _bmm_outer_product_impl
    return bmm_outer_product(a, b)
  File "/home/mirzaei/.local/lib/python3.10/site-packages/torch/_native/ops/bmm_outer_product/triton_kernels.py", line 76, in bmm_outer_product
    _bmm_outer_product_kernel[(B * triton.cdiv(M, BLOCK_M) * triton.cdiv(N, BLOCK_N),)](
  File "/home/mirzaei/.local/lib/python3.10/site-packages/triton/runtime/jit.py", line 370, in <lambda>
    return lambda *args, **kwargs: self.run(grid=grid, warmup=False, *args, **kwargs)
  File "/home/mirzaei/.local/lib/python3.10/site-packages/triton/runtime/jit.py", line 713, in run
    device = driver.active.get_current_device()
  File "/home/mirzaei/.local/lib/python3.10/site-packages/triton/runtime/driver.py", line 39, in active
    self._active = self.default
  File "/home/mirzaei/.local/lib/python3.10/site-packages/triton/runtime/driver.py", line 33, in default
    self._default = _create_driver()
  File "/home/mirzaei/.local/lib/python3.10/site-packages/triton/runtime/driver.py", line 21, in _create_driver
    return active_drivers[0]()
  File "/home/mirzaei/.local/lib/python3.10/site-packages/triton/backends/nvidia/driver.py", line 336, in __init__
    self.utils = CudaUtils()  # TODO: make static
  File "/home/mirzaei/.local/lib/python3.10/site-packages/triton/backends/nvidia/driver.py", line 66, in __init__
    mod = compile_module_from_src(
  File "/home/mirzaei/.local/lib/python3.10/site-packages/triton/runtime/build.py", line 93, in compile_module_from_src
    so = _build(name, src_path, tmpdir, library_dirs or [], include_dirs or [], libraries or [], ccflags or [])
  File "/home/mirzaei/.local/lib/python3.10/site-packages/triton/runtime/build.py", line 32, in _build
    raise RuntimeError(
RuntimeError: Failed to find C compiler. Please specify via CC environment variable or set triton.knobs.build.impl.
I have no name!@mm8-v5-gcc-0-0:~/sam/result/Aggregate$ 
