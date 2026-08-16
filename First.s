(.venv) I have no name!@mm8-0-0:~/sam/result/Aggregate$ export USER=mirzaei
export LOGNAME=mirzaei
export HOME=/home/mirzaei
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
CEBRA:   0%|                                                        | 0/3 [00:00<?, ?it/s]None
None
None
CEBRA:  33%|███████████▋                       | 1/3 [00:01<00:03,  1.57s/it, loss=6.8819]None
None
None
CEBRA:  33%|███████████▋                       | 1/3 [00:01<00:03,  1.57s/it, loss=6.8831]None
None
None
CEBRA:  67%|███████████████████████▎           | 2/3 [00:02<00:01,  1.02s/it, loss=6.8831]
Traceback (most recent call last):
  File "/home/mirzaei/sam/result/Aggregate/Multi_session.py", line 445, in <module>
    cebra_model = train_multisession_model(sessions, model_name="CEBRA", adversarial=False)
  File "/home/mirzaei/sam/result/Aggregate/Multi_session.py", line 274, in train_multisession_model
    loss, _, _ = criterion(reference, positive, negative)
  File "/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/nn/modules/module.py", line 1779, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/mirzaei/lm-cebra/.venv/lib/python3.10/site-packages/torch/nn/modules/module.py", line 1790, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/mirzaei/sam/result/Aggregate/CEBRA-main/cebra/models/criterions.py", line 181, in forward
    return infonce(pos_dist, neg_dist)
RuntimeError: The following operation failed in the TorchScript interpreter.
Traceback of TorchScript (most recent call last):
RuntimeError: nvrtc: error: failed to open libnvrtc-builtins.so.13.0.
  Make sure that libnvrtc-builtins.so.13.0 is installed correctly.
nvrtc compilation failed: 

#define NAN __int_as_float(0x7fffffff)
#define POS_INFINITY __int_as_float(0x7f800000)
#define NEG_INFINITY __int_as_float(0xff800000)


template<typename T>
__device__ T maximum(T a, T b) {
  return isnan(a) ? a : (a > b ? a : b);
}

template<typename T>
__device__ T minimum(T a, T b) {
  return isnan(a) ? a : (a < b ? a : b);
}

extern "C" __global__
void fused_sub_neg(float* tpos_dist_1, float* tv_, float* aten_neg) {
{
  float v = __ldg(tpos_dist_1 + (long long)(threadIdx.x) + 512ll * (long long)(blockIdx.x));
  float v_1 = __ldg(tv_ + (long long)(threadIdx.x) + 512ll * (long long)(blockIdx.x));
  aten_neg[(long long)(threadIdx.x) + 512ll * (long long)(blockIdx.x)] = 0.f - (v - v_1);
}
}


(.venv) I have no name!@mm8-0-0:~/sam/result/Aggregate$ 
