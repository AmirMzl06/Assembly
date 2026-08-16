mirzaei@haas034:~$ mkdir ~/robust-cebra-v5
cd ~/robust-cebra-v5
mirzaei@haas034:~/robust-cebra-v5$ nano Dockerfile
mirzaei@haas034:~/robust-cebra-v5$ podman build \
WARN[0000] Network file system detected as backing store.  Enforcing overlay option `force_mask="700"`.  Add it to storage.conf to silence this warning 
Error: no context directory and no Containerfile specified
mirzaei@haas034:~/robust-cebra-v5$ -t registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.5 .
-t: command not found
mirzaei@haas034:~/robust-cebra-v5$ podman build \
-t registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.5 .
WARN[0000] Network file system detected as backing store.  Enforcing overlay option `force_mask="700"`.  Add it to storage.conf to silence this warning 
STEP 1/4: FROM registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.4
Trying to pull registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.4...
Getting image source signatures
Copying blob ec6d5f6c9ed9 done   | 
Copying blob 7021d1b70935 done   | 
Copying blob 0a7674e3e8fe done   | 
Copying blob 0d6448aff889 done   | 
Copying blob 56dc85502937 done   | 
Copying blob b71b637b97c5 done   | 
Copying blob 47b8539d532f done   | 
Copying blob fd9cc1ad8dee done   | 
Copying blob 83525caeeb35 done   | 
Copying blob 59cca8ee4425 done   | 
Copying blob 2d02ca966369 done   | 
Copying blob eaa289c4d0c1 done   | 
Error: creating build container: writing blob: adding layer with blob "sha256:7021d1b70935851c95c45ed18156980b5024eda29b99564429025ea04f5ec109": processing tar file(lsetxattr /boot: operation not supported): exit status 1
mirzaei@haas034:~/robust-cebra-v5$ podman push \
registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.5
WARN[0000] Network file system detected as backing store.  Enforcing overlay option `force_mask="700"`.  Add it to storage.conf to silence this warning 
Error: registry.rcp.epfl.ch/upmwmathis-mirzaei/robust-cebra:v0.5: image not known
mirzaei@haas034:~/robust-cebra-v5$ 
