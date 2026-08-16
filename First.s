I have no name!@mm8-0-0:~/sam/result/Aggregate$ mv ~/.local/lib/python3.10/site-packages/torch ~/.local/lib/python3.10/site-packages/torch_backup
mv ~/.local/lib/python3.10/site-packages/triton ~/.local/lib/python3.10/site-packages/triton_backup
I have no name!@mm8-0-0:~/sam/result/Aggregate$ python -c "import torch; print(torch.__file__, torch.__version__)"
Traceback (most recent call last):
  File "<string>", line 1, in <module>
ModuleNotFoundError: No module named 'torch'
I have no name!@mm8-0-0:~/sam/result/Aggregate$ python -m pip list | grep -E "torch|triton"
torch                        2.13.0
torchtyping                  0.1.5
triton                       3.7.1
I have no name!@mm8-0-0:~/sam/result/Aggregate$ python -c "import torch; print(torch.__file__)"
Traceback (most recent call last):
  File "<string>", line 1, in <module>
ModuleNotFoundError: No module named 'torch'
I have no name!@mm8-0-0:~/sam/result/Aggregate$ 

