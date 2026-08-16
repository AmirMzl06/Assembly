I have no name!@mm8-0-0:~/sam/result/Aggregate$ ls ~/.local/lib/python3.10/site-packages | grep torch
functorch
torch-2.13.0.dist-info
torch_backup
torchgen
torchtyping
torchtyping-0.1.5.dist-info
I have no name!@mm8-0-0:~/sam/result/Aggregate$ ls /usr/local/lib/python3.10/site-packages | grep torch
ls: cannot access '/usr/local/lib/python3.10/site-packages': No such file or directory
I have no name!@mm8-0-0:~/sam/result/Aggregate$ python -c "import sys; print(sys.path)"
['', '/usr/lib/python310.zip', '/usr/lib/python3.10', '/usr/lib/python3.10/lib-dynload', '/home/mirzaei/.local/lib/python3.10/site-packages', '/usr/local/lib/python3.10/dist-packages', '/usr/lib/python3/dist-packages']
I have no name!@mm8-0-0:~/sam/result/Aggregate$ 
