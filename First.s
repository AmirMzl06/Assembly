\If you don't see a command prompt, try pressing enter.
I have no name!@mm8-0-0:/workspace$ export PYTHONNOUSERSITE=1
I have no name!@mm8-0-0:/workspace$ python -c "import torch; print(torch.__file__, torch.__version__)"
Traceback (most recent call last):
  File "<string>", line 1, in <module>
ModuleNotFoundError: No module named 'torch'
I have no name!@mm8-0-0:/workspace$ ls ~/lm-cebra
cat         handwritingBCI  macorn_multi.zip  speech_dataset
corp-torch  llm             perich            submittable_robust_cebra
data        macorn_cluster  poyo_org          test.log
I have no name!@mm8-0-0:/workspace$ source ~/lm-cebra/.venv/bin/activate
(.venv) I have no name!@mm8-0-0:/workspace$ which python
python -c "import torch;print(torch.__file__)"
/home/mirzaei/lm-cebra/.venv/bin/python
/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/__init__.py
(.venv) I have no name!@mm8-0-0:/workspace$ cd /home/mirzaei/sam/result/Aggregate
(.venv) I have no name!@mm8-0-0:~/sam/result/Aggregate$ source ~/lm-cebra/.venv/bin/activate
(.venv) I have no name!@mm8-0-0:~/sam/result/Aggregate$ python Multi_session.py
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
Traceback (most recent call last):
  File "/home/mirzaei/sam/result/Aggregate/Multi_session.py", line 445, in <module>
    cebra_model = train_multisession_model(sessions, model_name="CEBRA", adversarial=False)
  File "/home/mirzaei/sam/result/Aggregate/Multi_session.py", line 256, in train_multisession_model
    optimizer = torch.optim.AdamW(model.parameters(), lr=LEARNING_RATE, betas=(0.9, 0.999), eps=1e-8, weight_decay=WEIGHT_DECAY)
  File "/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/optim/adamw.py", line 36, in __init__
    super().__init__(
  File "/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/optim/adam.py", line 102, in __init__
    super().__init__(params, defaults)
  File "/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/optim/optimizer.py", line 408, in __init__
    self.add_param_group(cast(dict, param_group))
  File "/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/_compile.py", line 47, in inner
    import torch._dynamo
  File "/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/_dynamo/__init__.py", line 13, in <module>
    from . import (
  File "/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/_dynamo/aot_compile.py", line 17, in <module>
    from torch._dynamo.package import SystemInfo
  File "/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/_dynamo/package.py", line 1173, in <module>
    DynamoCache = DiskDynamoCache(os.path.join(cache_dir(), "dynamo"))
  File "/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/_dynamo/package.py", line 1170, in cache_dir
    return cache_dir()
  File "/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/_inductor/runtime/cache_dir_utils.py", line 17, in cache_dir
    os.environ["TORCHINDUCTOR_CACHE_DIR"] = cache_dir = default_cache_dir()
  File "/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/_inductor/runtime/cache_dir_utils.py", line 23, in default_cache_dir
    sanitized_username = re.sub(r'[\\/:*?"<>|]', "_", getpass.getuser())
  File "/usr/lib/python3.10/getpass.py", line 169, in getuser
    return pwd.getpwuid(os.getuid())[0]
KeyError: 'getpwuid(): uid not found: 270850'
(.venv) I have no name!@mm8-0-0:~/sam/result/Aggregate$ 
