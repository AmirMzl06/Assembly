hossein@server7-Lambda-Vector:~$ cd sammm/
hossein@server7-Lambda-Vector:~/sammm$ cd BrainBackdoor/
hossein@server7-Lambda-Vector:~/sammm/BrainBackdoor$ cd Br
-bash: cd: Br: No such file or directory
hossein@server7-Lambda-Vector:~/sammm/BrainBackdoor$ cd BrainBackdoor/
hossein@server7-Lambda-Vector:~/sammm/BrainBackdoor/BrainBackdoor$ ls
5.py                 DefenseIdea.py      Histo.py          RegIdea.py
ABL.py               Downlads_Models.py  Idea.py           sparsity.py
ASRandWeight.py      effective.py        image             svd_forall.py
attn.py              effective_rank      model.py          svd.py
CEBRA.py             Finalimage          models            TANR.py
CEBRA_TANR.py        FullyConnected.py   Nimage            TANR_vision.py
cifar100_results     Guess.py            NNimage           Trojai.py
condition_number.py  hip                 poyo_achilles.py  WeightZero.py
data                 hip_rnn.py          README.md
hossein@server7-Lambda-Vector:~/sammm/BrainBackdoor/BrainBackdoor$ cd effective_rank/
hossein@server7-Lambda-Vector:~/sammm/BrainBackdoor/BrainBackdoor/effective_rank$ ls
adv_hippo.ipynb  base.zip  CEBRA  CEBRA_ADV.py  utils
hossein@server7-Lambda-Vector:~/sammm/BrainBackdoor/BrainBackdoor/effective_rank$ utils/
-bash: utils/: Is a directory
hossein@server7-Lambda-Vector:~/sammm/BrainBackdoor/BrainBackdoor/effective_rank$ python CEBRA_ADV.py 
Patch applied successfully!
Traceback (most recent call last):
  File "CEBRA_ADV.py", line 23, in <module>
    import cebra
  File "/home/hossein/.local/lib/python3.8/site-packages/cebra/__init__.py", line 58, in <module>
    from cebra.data.load import load as load_data
  File "/home/hossein/.local/lib/python3.8/site-packages/cebra/data/__init__.py", line 47, in <module>
    from cebra.data.base import *
  File "/home/hossein/.local/lib/python3.8/site-packages/cebra/data/base.py", line 30, in <module>
    import torch
  File "/home/hossein/.local/lib/python3.8/site-packages/torch/__init__.py", line 229, in <module>
    from torch._C import *  # noqa: F403
hossein@server7-Lambda-Vector:~/sammm/BrainBackdoor/BrainBackdoor/effective_rank$ ls
adv_hippo.ipynb  base.zip  CEBRA  CEBRA_ADV.py  utils
hossein@server7-Lambda-Vector:~/sammm/BrainBackdoor/BrainBackdoor/effective_rank$ 
