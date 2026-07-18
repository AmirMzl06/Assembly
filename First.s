e_neuron_binomial.py 

========== Processing Rat: achilles ==========
[12:27:44] INFO     (੭｡╹▿╹｡)੭ Poyo!                                             
/home/hossein/sammm/BrainBackdoor/result/Aggregate/CEBRA-main/cebra/__init__.py:123: UserWarning: Your code triggered a lazy import of cebra.datasets. While this will (likely) work, it is recommended to add an explicit import statement to you code instead. To disable this warning, you can run ``cebra.allow_lazy_imports()``.
  warnings.warn(
Added 5 fake neurons at indices: [5, 67, 86, 89, 105]

--- Training CEBRA (adv = False) ---
<class 'cebra.integrations.sklearn.dataset.SklearnDataset'>
None
<class 'cebra.data.single_session.ContinuousDataLoader'>
ALTERNATE IS False
pos: -2.2513 neg:  7.5216 total:  5.2702 temperature:  0.4000: 100%|█| 1500/1500
/home/hossein/sammm/BrainBackdoor/result/Aggregate/CEBRA-main/cebra/__init__.py:123: UserWarning: Your code triggered a lazy import of cebra.attribution. While this will (likely) work, it is recommended to add an explicit import statement to you code instead. To disable this warning, you can run ``cebra.allow_lazy_imports()``.
  warnings.warn(
None
Computing Jacobian Map for CEBRA...
Computing inverse for jf with method lsq
Computing inverse for jf with method svd
Computing inverse for jf-convabs with method lsq
Computing inverse for jf-convabs with method svd

>>> [CEBRA] Average Latent Attribution for Fake Neurons:
    Fake Neuron #1 (Index: 5): 4.658972e-05
    Fake Neuron #2 (Index: 67): 3.768218e-05
    Fake Neuron #3 (Index: 86): 2.764449e-05
    Fake Neuron #4 (Index: 89): 4.868014e-05
    Fake Neuron #5 (Index: 105): 4.010426e-05
Plot saved successfully at: images/achilles/CEBRA_jacobian.png

--- Training ACORN (adv = True) ---
<class 'cebra.integrations.sklearn.dataset.SklearnDataset'>
None
<class 'cebra.data.single_session.ContinuousDataLoader'>
ALTERNATE IS False
pos: -2.2860 neg:  7.5589 total:  5.2729 temperature:  0.4000: 100%|█| 1500/1500
None
Computing Jacobian Map for ACORN...
Traceback (most recent call last):
  File "fake_neuron_binomial.py", line 108, in <module>
    result = method.compute_attribution_map()
  File "/home/hossein/sammm/BrainBackdoor/result/Aggregate/CEBRA-main/cebra/attribution/attribution_models.py", line 340, in compute_attribution_map
    full_jacobian = self._compute_jacobian(self.input_data)
  File "/home/hossein/sammm/BrainBackdoor/result/Aggregate/CEBRA-main/cebra/attribution/attribution_models.py", line 328, in _compute_jacobian
    return cebra.attribution._jacobian.compute_jacobian(
  File "/home/hossein/sammm/BrainBackdoor/result/Aggregate/CEBRA-main/cebra/attribution/_jacobian.py", line 87, in compute_jacobian
    jacobian = torch.stack(jacob, dim=1)
torch.cuda.OutOfMemoryError: CUDA out of memory. Tried to allocate 6.52 GiB (GPU 0; 23.56 GiB total capacity; 7.50 GiB already allocated; 320.12 MiB free; 13.88 GiB reserved in total by PyTorch) If reserved memory is >> allocated memory try setting max_split_size_mb to avoid fragmentation.  See documentation for Memory Management and PYTORCH_CUDA_ALLOC_CONF
