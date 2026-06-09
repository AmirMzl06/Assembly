python TANR.py 
Running on: cuda
--- Training Baseline Model ---
Epoch 001/80 | Loss: 0.8226 | R2: 0.2905
Epoch 005/80 | Loss: 0.1287 | R2: 0.7045
Epoch 010/80 | Loss: 0.0498 | R2: 0.7151
Epoch 015/80 | Loss: 0.0263 | R2: 0.6966
Epoch 020/80 | Loss: 0.0173 | R2: 0.6643
Epoch 025/80 | Loss: 0.0129 | R2: 0.6494
Epoch 030/80 | Loss: 0.0108 | R2: 0.6319
Epoch 035/80 | Loss: 0.0081 | R2: 0.6352
Epoch 040/80 | Loss: 0.0062 | R2: 0.6176
Epoch 045/80 | Loss: 0.0053 | R2: 0.6172
Epoch 050/80 | Loss: 0.0088 | R2: 0.6079
Epoch 055/80 | Loss: 0.0047 | R2: 0.6184
Epoch 060/80 | Loss: 0.0053 | R2: 0.6139
Epoch 065/80 | Loss: 0.0055 | R2: 0.6126
Epoch 070/80 | Loss: 0.0045 | R2: 0.6024
Epoch 075/80 | Loss: 0.0045 | R2: 0.6083
Epoch 080/80 | Loss: 0.0033 | R2: 0.5934
Baseline Time: 6.38s | Final R2: 0.5934
--- Training tanr_l001 ---
Epoch 001/80 | Loss: 5.8490 | R2: 0.1846
Epoch 005/80 | Loss: 4.1791 | R2: 0.6456
Epoch 010/80 | Loss: 3.9980 | R2: 0.6903
Epoch 015/80 | Loss: 3.9222 | R2: 0.6775
Epoch 020/80 | Loss: 3.8823 | R2: 0.6718
Epoch 025/80 | Loss: 3.8592 | R2: 0.6681
Epoch 030/80 | Loss: 3.8453 | R2: 0.6464
Epoch 035/80 | Loss: 3.8344 | R2: 0.6629
Epoch 040/80 | Loss: 3.8264 | R2: 0.6536
Epoch 045/80 | Loss: 3.8209 | R2: 0.6404
Epoch 050/80 | Loss: 3.8164 | R2: 0.6615
Epoch 055/80 | Loss: 3.8113 | R2: 0.6531
Epoch 060/80 | Loss: 3.8090 | R2: 0.6525
Epoch 065/80 | Loss: 3.8049 | R2: 0.6559
Epoch 070/80 | Loss: 3.8025 | R2: 0.6447
Epoch 075/80 | Loss: 3.7992 | R2: 0.6481
Epoch 080/80 | Loss: 3.7992 | R2: 0.6522
tanr_l001 Time: 11.53s | Final R2: 0.6522
Baseline Latent Space PCA explained variance: 0.8051
tanr_l001 Latent Space PCA explained variance: 0.3714
--- Training tanr_l005 ---
Epoch 001/80 | Loss: 4.1115 | R2: 0.3261
Epoch 005/80 | Loss: 3.3225 | R2: 0.6866
Epoch 010/80 | Loss: 3.1602 | R2: 0.7123
Epoch 015/80 | Loss: 3.1039 | R2: 0.6855
Epoch 020/80 | Loss: 3.0775 | R2: 0.6794
Epoch 025/80 | Loss: 3.0599 | R2: 0.6702
Epoch 030/80 | Loss: 3.0501 | R2: 0.6744
Epoch 035/80 | Loss: 3.0418 | R2: 0.6722
Epoch 040/80 | Loss: 3.0344 | R2: 0.6583
Epoch 045/80 | Loss: 3.0318 | R2: 0.6417
Epoch 050/80 | Loss: 3.0274 | R2: 0.6393
Epoch 055/80 | Loss: 3.0228 | R2: 0.6318
Epoch 060/80 | Loss: 3.0199 | R2: 0.6438
Epoch 065/80 | Loss: 3.0168 | R2: 0.6245
Epoch 070/80 | Loss: 3.0145 | R2: 0.6110
Epoch 075/80 | Loss: 3.0122 | R2: 0.5903
Epoch 080/80 | Loss: 3.0120 | R2: 0.5933
tanr_l005 Time: 11.37s | Final R2: 0.5933
Baseline Latent Space PCA explained variance: 0.8051
tanr_l005 Latent Space PCA explained variance: 0.3866
--- Training tanr_l010 ---
Epoch 001/80 | Loss: 5.7171 | R2: 0.2733
Epoch 005/80 | Loss: 4.2213 | R2: 0.6516
Epoch 010/80 | Loss: 4.0087 | R2: 0.6645
Epoch 015/80 | Loss: 3.9285 | R2: 0.6364
Epoch 020/80 | Loss: 3.8917 | R2: 0.6331
Epoch 025/80 | Loss: 3.8716 | R2: 0.6381
Epoch 030/80 | Loss: 3.8605 | R2: 0.6168
Epoch 035/80 | Loss: 3.8495 | R2: 0.6159
Epoch 040/80 | Loss: 3.8428 | R2: 0.6384
Epoch 045/80 | Loss: 3.8383 | R2: 0.6329
Epoch 050/80 | Loss: 3.8334 | R2: 0.6323
Epoch 055/80 | Loss: 3.8285 | R2: 0.6168
Epoch 060/80 | Loss: 3.8258 | R2: 0.6290
Epoch 065/80 | Loss: 3.8228 | R2: 0.6183
Epoch 070/80 | Loss: 3.8208 | R2: 0.6284
Epoch 075/80 | Loss: 3.8182 | R2: 0.6222
Epoch 080/80 | Loss: 3.8187 | R2: 0.6256
tanr_l010 Time: 11.44s | Final R2: 0.6256
Baseline Latent Space PCA explained variance: 0.8051
tanr_l010 Latent Space PCA explained variance: 0.4274

Final Results:
baseline: 0.5934
tanr_l001: 0.6522
tanr_l005: 0.5933
tanr_l010: 0.6256

