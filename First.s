I have no name!@mm8-v5-gcc-0-0:~/sam/result/Aggregate$ exit
exit
mirzaei@haas034:~/sam/result/Aggregate$ cd
mirzaei@haas034:~$ podman --storage-driver=vfs \
--root /tmp/$USER/podman-storage \
push \
registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.5
Getting image source signatures
Copying blob ec6d5f6c9ed9 skipped: already exists  
Copying blob 7021d1b70935 skipped: already exists  
Copying blob 0d6448aff889 skipped: already exists  
Copying blob 0a7674e3e8fe skipped: already exists  
Copying blob b71b637b97c5 skipped: already exists  
Copying blob 56dc85502937 skipped: already exists  
Copying blob 47b8539d532f skipped: already exists  
Copying blob 124c0f2e3c9f [----------------------------------] 8.0b / 225.1MiB | 1.3 MiB/s
Copying blob fd9cc1ad8dee skipped: already exists  
Copying blob 59cca8ee4425 skipped: already exists  
Copying blob 2d02ca966369 skipped: already exists  
Copying blob 83525caeeb35 skipped: already exists  
Copying blob eaa289c4d0c1 skipped: already exists  
Error: writing blob: initiating layer upload to /v2/upmwmathis-mirzaei/robust-cebra/blobs/uploads/ in registry.rcp.epfl.ch: unauthorized: unauthorized to access repository: upmwmathis-mirzaei/robust-cebra, action: push: unauthorized to access repository: upmwmathis-mirzaei/robust-cebra, action: push
mirzaei@haas034:~$ runai delete job mm8-v5-gcc -p upmwmathis-mirzaei
Job mm8-v5-gcc deleted successfully.
mirzaei@haas034:~$ runai submit --name mm8-v6-gcc \
  --image registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.5 \
  --gpu 1 --cpu 64 --memory 256Gi --node-pools h100 --large-shm \
  --pvc home:/home/mirzaei \
  --pvc upmwmathis-scratch:/data \
  -e HOME=/home/mirzaei \
  -p upmwmathis-mirzaei \
  --attach --run-as-user \
  --command -- bash -lc 'bash'
Job mm8-v6-gcc submitted successfully.
You can check the status of the job by running:
	runai describe job mm8-v6-gcc -p upmwmathis-mirzaei

