mirzaei@haas034:~$ runai delete job mm8 -p upmwmathis-mirzaei
Job mm8 deleted successfully.
mirzaei@haas034:~$ runai submit --name mm8 \
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
(.venv) I have no name!@mm8-0-0:/workspace$ 
