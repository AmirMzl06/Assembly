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
mirzaei@haas034:~/robust-cebra-v5$ 
