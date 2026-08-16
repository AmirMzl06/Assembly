mirzaei@haas034:~$ 
runai submit --name mm8 \
  --image registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.4 \
  --gpu 1 --cpu 64 --memory 256Gi --node-pools h100 --large-shm \
  --pvc home:/home/mirzaei \
  --pvc upmwmathis-scratch:/data \
  -e HOME=/home/mirzaei \
  -p upmwmathis-mirzaei \
  --attach --run-as-user \
  --command -- bash -lc 'bash'
Job mm8 submitted successfully.
You can check the status of the job by running:
	runai describe job mm8 -p upmwmathis-mirzaei
Connecting to pod mm8-0-0
If you don't see a command prompt, try pressing enter.
I have no name!@mm8-0-0:/workspace$ cd /home/mirzaei/sam/result/Aggregate
I have no name!@mm8-0-0:~/sam/result/Aggregate$ python -m pip show torch
python -m pip show triton
Name: torch
Version: 2.13.0
Summary: Tensors and Dynamic neural networks in Python with strong GPU acceleration
Home-page: https://pytorch.org
Author: 
Author-email: PyTorch Team <packages@pytorch.org>
License-Expression: Apache-2.0 AND Apache-2.0 WITH LLVM-exception AND BSD-2-Clause AND BSD-3-Clause AND BSL-1.0 AND MIT
Location: /home/mirzaei/.local/lib/python3.10/site-packages
Requires: cuda-bindings, cuda-toolkit, filelock, fsspec, jinja2, networkx, nvidia-cudnn-cu13, nvidia-cusparselt-cu13, nvidia-nccl-cu13, nvidia-nvshmem-cu13, setuptools, sympy, triton, typing-extensions
Required-by: accelerate, captum, neural_decoder, torchtyping
Name: triton
Version: 3.7.1
Summary: A language and compiler for custom Deep Learning operations
Home-page: https://github.com/triton-lang/triton/
Author: Philippe Tillet
Author-email: phil@openai.com
License: 
Location: /home/mirzaei/.local/lib/python3.10/site-packages
Requires: 
Required-by: torch
I have no name!@mm8-0-0:~/sam/result/Aggregate$ 
