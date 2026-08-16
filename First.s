Last login: Sun Aug 16 15:53:07 2026 from 128.179.253.32
groups: cannot find name for group ID 30299
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
could not find any job with the given name mm8
mirzaei@haas034:~$ 
