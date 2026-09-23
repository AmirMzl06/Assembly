

mirzaei@haas034:/mnt/upmwmathis/scratch/hossein/aj_project/adversarial_BCI$ grep -R "format_data_from_trials\|n_lag" -n . --exclude-dir=runs
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:360:    "In this case, X will have $4\\times4$ columns, and Y still has 2 columns. Since the first 3 time steps would be a blind zone for the Wiener filter, we should get $10-4+1 = 7$ training samples from the 10 time steps. In order to use the data from multiple trials as the training data, we will need to do this reshaping for each trial, and then concatenate them together. The function `format_data_from_trials` is used to do this job.\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:399:    "from wiener_filter import format_data_from_trials, train_wiener_filter, test_wiener_filter\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:403:    "n_lags = 4 # the number of time lags in Wiener filter\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:414:    "    x_train_, y_train_ = format_data_from_trials(x_train, y_train, n_lags)\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:422:    "    x_test_, y_test_ = format_data_from_trials(x_test, y_test, n_lags)\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:451:    "* `[x_, y_] = format_data_from_trials(x, y, n_lags)`:\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:454:    "  - n_lags: a number indicating the number of time lags for Wiener filter\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:515:    "                         day0_spike_te, day0_EMG_te, day0_decoder, bin_size, n_lags, 10, r2_list[best_fold], day0_EMG_names, 'orange')\n"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:552:    "x_test_, y_test_ = format_data_from_trials(x_test, y_test, n_lags)\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:593:    "                         dayk_spike_, dayk_EMG_, day0_decoder, bin_size, n_lags, 8, r2_k, dayk_EMG_names, 'orange')"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:807:    "def train_cycle_gan_aligner(x1, x2, y2, D_params, G_params, training_params, decoder, n_lags, logs = True):\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:826:    "    n_lags: the number of time lags of the decoder, a number.\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:1011:    "            x2_valid_aligned_, y2_valid_ = format_data_from_trials(x2_valid_aligned, y2_valid, n_lags)\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:1183:    "                                  D_params, G_params, training_params, day0_decoder, n_lags, True)"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:1232:    "dayk_spike_aligned_, dayk_EMG_test_ = format_data_from_trials(dayk_spike_aligned, dayk_EMG_[120:], n_lags)\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:1271:    "                         dayk_spike_aligned, dayk_EMG_[120:], day0_decoder, bin_size, n_lags, 8, r2, dayk_EMG_names, 'green')"
./.ipynb_checkpoints/utils-checkpoint.py:94:def plot_actual_and_pred_EMG(fig_title, spike, EMG, decoder, bin_size, n_lags, num_trials, r2_list, EMG_names, color):
./.ipynb_checkpoints/utils-checkpoint.py:103:        x, y = format_data(each[0], each[1], n_lags)
./ADAN_aligner.ipynb:370:    "  - n_lags: number indicating the number of time lags for the LSTM decoder\n",
./ADAN_aligner.ipynb:390:    "training_params['n_lags'] = 4\n",
./ADAN_aligner.ipynb:418:    "        latent = tf.reshape(latent, [-1, training_params['n_lags'], training_params['latent_dim']])\n",
./ADAN_aligner.ipynb:601:    "In this case, X will have $4\\times4$ columns, and Y still has 2 columns. Since the first 3 time steps would be a blind zone for the Wiener filter, we should get $10-4+1 = 7$ training samples from the 10 time steps. In order to use the data from multiple trials as the training data, we will need to do this reshaping for each trial, and then concatenate them together. The function `format_data_from_trials` is used to do this job.\n",
./ADAN_aligner.ipynb:721:    "from wiener_filter import format_data_from_trials, train_wiener_filter, test_wiener_filter\n",
./ADAN_aligner.ipynb:734:    "n_lags = 4 # the number of time lags in Wiener filter\n",
./ADAN_aligner.ipynb:750:    "    idx_tr = int(len(x_train) // training_params['n_lags'] * training_params['n_lags'])\n",
./ADAN_aligner.ipynb:753:    "    idx_te = int(len(x_test) // training_params['n_lags'] * training_params['n_lags'])\n",
./ADAN_aligner.ipynb:792:    "                    x_train_lat_, y_train_ = format_data_from_trials(x_train_lat, y_train, training_params['n_lags'])\n",
./ADAN_aligner.ipynb:796:    "                    x_test_lat_, y_test_ = format_data_from_trials(x_test_lat, y_test, training_params['n_lags'])\n",
./ADAN_aligner.ipynb:844:    "            x_test_lat_, y_test_ = format_data_from_trials(x_test_lat, y_test, training_params['n_lags'])\n",
./ADAN_aligner.ipynb:864:    "* `[x_, y_] = format_data_from_trials(x, y, n_lags)`:\n",
./ADAN_aligner.ipynb:867:    "  - n_lags: a number indicating the number of time lags for Wiener filter\n",
./ADAN_aligner.ipynb:1174:    "def train_adan_aligner(x1, x2, y2, training_params, decoder, best_fold, n_lags, logs = True):\n",
./ADAN_aligner.ipynb:1191:    "    n_lags: the number of time lags of the decoder, a number.\n",
./ADAN_aligner.ipynb:1259:    "            x2_valid_lat_, y2_valid_ = format_data_from_trials(x2_valid_lat, y2_valid, n_lags)\n",
./ADAN_aligner.ipynb:1264:    "            x2_valid_aligned_lat_, y2_valid_ = format_data_from_trials(x2_valid_aligned_lat, y2_valid, n_lags)\n",
./ADAN_aligner.ipynb:1412:    "                   training_params, day0_decoder, best_fold, n_lags, True)"
./ADAN_aligner.ipynb:1471:    "dayk_spike_lat_aligned_, dayk_EMG_test_ = format_data_from_trials(dayk_spike_lat_aligned, dayk_EMG_[120:], n_lags)\n",
./ADAN_aligner.ipynb:1512:    "                         dayk_spike_lat_aligned, dayk_EMG_[120:], day0_decoder, bin_size, n_lags, 8, r2, dayk_EMG_names, 'green')\n"
./Cycle_GAN_aligner.ipynb:394:    "In this case, X will have $4\\times4$ columns, and Y still has 2 columns. Since the first 3 time steps would be a blind zone for the Wiener filter, we should get $10-4+1 = 7$ training samples from the 10 time steps. In order to use the data from multiple trials as the training data, we will need to do this reshaping for each trial, and then concatenate them together. The function `format_data_from_trials` is used to do this job.\n",
./Cycle_GAN_aligner.ipynb:433:    "from wiener_filter import format_data_from_trials, train_wiener_filter, test_wiener_filter\n",
./Cycle_GAN_aligner.ipynb:437:    "n_lags = 4 # the number of time lags in Wiener filter\n",
./Cycle_GAN_aligner.ipynb:448:    "    x_train_, y_train_ = format_data_from_trials(x_train, y_train, n_lags)\n",
./Cycle_GAN_aligner.ipynb:456:    "    x_test_, y_test_ = format_data_from_trials(x_test, y_test, n_lags)\n",
./Cycle_GAN_aligner.ipynb:485:    "* `[x_, y_] = format_data_from_trials(x, y, n_lags)`:\n",
./Cycle_GAN_aligner.ipynb:488:    "  - n_lags: a number indicating the number of time lags for Wiener filter\n",
./Cycle_GAN_aligner.ipynb:549:    "                         day0_spike_te, day0_EMG_te, day0_decoder, bin_size, n_lags, 10, r2_list[best_fold], day0_EMG_names, 'orange')\n"
./Cycle_GAN_aligner.ipynb:586:    "x_test_, y_test_ = format_data_from_trials(x_test, y_test, n_lags)\n",
./Cycle_GAN_aligner.ipynb:627:    "                         dayk_spike_, dayk_EMG_, day0_decoder, bin_size, n_lags, 8, r2_k, dayk_EMG_names, 'orange')"
./Cycle_GAN_aligner.ipynb:841:    "def train_cycle_gan_aligner(x1, x2, y2, D_params, G_params, training_params, decoder, n_lags, logs = True):\n",
./Cycle_GAN_aligner.ipynb:860:    "    n_lags: the number of time lags of the decoder, a number.\n",
./Cycle_GAN_aligner.ipynb:1045:    "            x2_valid_aligned_, y2_valid_ = format_data_from_trials(x2_valid_aligned, y2_valid, n_lags)\n",
./Cycle_GAN_aligner.ipynb:1217:    "                                  D_params, G_params, training_params, day0_decoder, n_lags, True)"
./Cycle_GAN_aligner.ipynb:1266:    "dayk_spike_aligned_, dayk_EMG_test_ = format_data_from_trials(dayk_spike_aligned, dayk_EMG_[120:], n_lags)\n",
./Cycle_GAN_aligner.ipynb:1305:    "                         dayk_spike_aligned, dayk_EMG_[120:], day0_decoder, bin_size, n_lags, 8, r2, dayk_EMG_names, 'green')"
grep: ./__pycache__/utils.cpython-37.pyc: binary file matches
grep: ./__pycache__/utils.cpython-310.pyc: binary file matches
./logs_bkup/f0e086db-0b39-41bc-9b2b-249add1e34fd_hezow2cv/attempt_0/0/stderr.log:3:    from wiener_filter import format_data_from_trials, train_wiener_filter, test_wiener_filter
./logs_bkup/ec11fad8-1a0c-46ec-9a79-78edb5baffa8_4xm3ceyf/attempt_0/0/stderr.log:3:    from wiener_filter import format_data_from_trials, train_wiener_filter, test_wiener_filter
./logs_bkup/5894b556-d8dc-4634-9dc5-b92164863b3d_7yy9tpja/attempt_0/0/stderr.log:3:    from wiener_filter import format_data_from_trials, train_wiener_filter, test_wiener_filter
./logs_bkup/f092930d-4621-49d3-b6d3-1224a9999d73_vmj2bicj/attempt_0/0/stderr.log:3:    from wiener_filter import format_data_from_trials, train_wiener_filter, test_wiener_filter
./logs_bkup/7bd7375b-ce90-4828-81fd-f4cf23a61243_dm_g817u/attempt_0/0/stderr.log:3:    from wiener_filter import format_data_from_trials, train_wiener_filter, test_wiener_filter
./logs_bkup/f050d322-1b05-4f77-b928-33e2414d6fe8_sxidqxxy/attempt_0/0/stderr.log:3:    from wiener_filter import format_data_from_trials, train_wiener_filter, test_wiener_filter
./logs_bkup/50274e23-2d21-49ab-928c-6c68f63da541_rzs8dv7v/attempt_0/0/stderr.log:3:    from wiener_filter import format_data_from_trials, train_wiener_filter, test_wiener_filter
./decoder_standard/.ipynb_checkpoints/decoder_standard_demo-checkpoint.ipynb:140:    "n_lags = 20\n",
./decoder_standard/.ipynb_checkpoints/decoder_standard_demo-checkpoint.ipynb:141:    "train_x_wiener, train_y_wiener = dataset_for_WF_multifile(train_spike, train_emg, n_lags)\n",
./decoder_standard/.ipynb_checkpoints/decoder_standard_demo-checkpoint.ipynb:143:    "test_x_wiener, test_y_wiener = dataset_for_WF_multifile(test_spike, test_emg, n_lags)\n",
grep: ./decoder_standard/__pycache__/fnn_decoder.cpython-37.pyc: binary file matches
grep: ./decoder_standard/__pycache__/rnn_decoder.cpython-310.pyc: binary file matches
grep: ./decoder_standard/__pycache__/rnn_decoder.cpython-37.pyc: binary file matches
grep: ./decoder_standard/__pycache__/wiener_filter.cpython-36.pyc: binary file matches
grep: ./decoder_standard/__pycache__/wiener_filter.cpython-37.pyc: binary file matches
grep: ./decoder_standard/__pycache__/wiener_filter.cpython-310.pyc: binary file matches
./decoder_standard/decoder_standard_demo.ipynb:118:    "n_lags = 8\n",
./decoder_standard/decoder_standard_demo.ipynb:125:    "train_x, train_y = format_data(train_x, train_y, n_lags)\n",
./decoder_standard/decoder_standard_demo.ipynb:126:    "test_x, test_y = format_data(test_x, test_y, n_lags)\n",
./decoder_standard/fnn_decoder.py:7:def format_data_fnn(x, y, n_lag):
./decoder_standard/fnn_decoder.py:13:        n_lag: the number of time lags, an int number
./decoder_standard/fnn_decoder.py:18:    x_ = [x[i:i+n_lag, :].reshape(n_lag*x.shape[1]) for i in range(x.shape[0]-n_lag+1)]
./decoder_standard/fnn_decoder.py:19:    return np.asarray(x_), y[n_lag-1:, :]
./decoder_standard/fnn_decoder.py:21:def format_data_from_trials_fnn(x, y, n_lag):
./decoder_standard/fnn_decoder.py:28:        n_lag: the number of time lags, an int number
./decoder_standard/fnn_decoder.py:39:        temp = format_data_fnn(each[0], each[1], n_lag)
./decoder_standard/rnn_decoder.py:9:def format_data_rnn(x, y, n_lag):
./decoder_standard/rnn_decoder.py:14:    x_ = [x[i:i+n_lag, :] for i in range(x.shape[0]-n_lag+1)]
./decoder_standard/rnn_decoder.py:16:        return np.asarray(x_), y[n_lag-1:, :]
./decoder_standard/rnn_decoder.py:21:def format_data_from_trials_rnn(x, y, n_lag):
./decoder_standard/rnn_decoder.py:34:            temp = format_data_rnn(each[0], each[1], n_lag)
./decoder_standard/rnn_decoder.py:40:            temp = format_data_rnn(each, [], n_lag)
./decoder_standard/wiener_filter.py:21:def format_data(x, y, n_lag):
./decoder_standard/wiener_filter.py:27:        n_lag: the number of time lags, an int number
./decoder_standard/wiener_filter.py:32:    x_ = [x[i:i+n_lag, :].reshape(n_lag*x.shape[1]) for i in range(x.shape[0]-n_lag+1)]
./decoder_standard/wiener_filter.py:33:    return np.asarray(x_), y[n_lag-1:, :]
./decoder_standard/wiener_filter.py:35:def format_data_from_list(x, y, n_lag):
./decoder_standard/wiener_filter.py:42:        temp = format_data(each[0], each[1], n_lag)
./decoder_standard/wiener_filter.py:47:def format_data_from_trials(x, y, n_lag):
./decoder_standard/wiener_filter.py:54:        n_lag: the number of time lags, an int number
./decoder_standard/wiener_filter.py:65:        temp = format_data(each[0], each[1], n_lag)
./xds/xds_python/lib_data_analysis/.ipynb_checkpoints/decoder_standard_demo-checkpoint.ipynb:118:    "n_lags = 8\n",
./xds/xds_python/lib_data_analysis/.ipynb_checkpoints/decoder_standard_demo-checkpoint.ipynb:125:    "train_x, train_y = format_data(train_x, train_y, n_lags)\n",
./xds/xds_python/lib_data_analysis/.ipynb_checkpoints/decoder_standard_demo-checkpoint.ipynb:126:    "test_x, test_y = format_data(test_x, test_y, n_lags)\n",
./xds/xds_python/lib_data_analysis/decoder_standard_demo.ipynb:118:    "n_lags = 8\n",
./xds/xds_python/lib_data_analysis/decoder_standard_demo.ipynb:125:    "train_x, train_y = format_data(train_x, train_y, n_lags)\n",
./xds/xds_python/lib_data_analysis/decoder_standard_demo.ipynb:126:    "test_x, test_y = format_data(test_x, test_y, n_lags)\n",
./logs/3025d822-3559-48b3-aec7-86ec8dd9863e_hyzq5hbo/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=1.0, cycle_loss_p=3.0, epochs=400, g_hidden_dim=96, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/369f32d9-7851-48f1-b642-98d65021f41d_gnb0vzg2/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=1.0, cycle_loss_p=5.0, epochs=400, g_hidden_dim=64, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/f19918cf-8240-469a-a5ea-6e0b9e1a0ce5_ssoegpic/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=1.0, cycle_loss_p=3.0, epochs=400, g_hidden_dim=64, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/a8c2ff65-f13d-44d7-b789-0beae0ec63de_hmwg3nft/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=1.0, cycle_loss_p=5.0, epochs=400, g_hidden_dim=96, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/060333a2-4cbb-41f1-8eeb-80a32a4d3dea_u63b2wf5/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=1.0, cycle_loss_p=7.0, epochs=400, g_hidden_dim=64, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/3e77fc6a-08c5-4ea0-ae27-a800ae369aca_z_3qd1rl/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=1.0, cycle_loss_p=7.0, epochs=400, g_hidden_dim=96, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/70ebce31-6ed3-400d-a822-824ab67770fa_lypcgb_p/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=1.0, cycle_loss_p=10.0, epochs=400, g_hidden_dim=64, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/d2d6903a-51cb-4842-afc8-a23a483583fd_q9i6_mtw/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=1.0, cycle_loss_p=10.0, epochs=400, g_hidden_dim=96, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/af305192-9c47-4493-86de-909c576f07f1_odwjxkt_/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=2.0, cycle_loss_p=5.0, epochs=400, g_hidden_dim=96, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/4b895581-31fc-490a-ae36-9d2ebb18dee6_6326sd8b/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=2.0, cycle_loss_p=5.0, epochs=400, g_hidden_dim=64, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/a7452bea-2972-4319-a05f-2e44c44c9126_24vebyqh/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=2.0, cycle_loss_p=3.0, epochs=400, g_hidden_dim=64, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/28f3833f-2c04-451b-bba0-6ac2d0dea033_khib_w9t/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=2.0, cycle_loss_p=3.0, epochs=400, g_hidden_dim=96, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/cc26f3b2-162b-4d3f-a1ae-af870134b44f_6x43vo2y/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=2.0, cycle_loss_p=7.0, epochs=400, g_hidden_dim=64, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/6b9e73c3-e07f-4928-a400-1a7e85efaaeb_gc_s1pv9/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=2.0, cycle_loss_p=10.0, epochs=400, g_hidden_dim=96, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/962b7ee2-2a21-4030-b5de-d6b433771183_5susv9gz/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=2.0, cycle_loss_p=7.0, epochs=400, g_hidden_dim=96, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/f1ab7218-df3f-4f37-8e3a-4ab9a4f00322_6wa53qkg/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=2.0, cycle_loss_p=10.0, epochs=400, g_hidden_dim=64, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags=4, loss_type='L1', optim_type='Adam')
./logs/6a798513-abe1-4a41-847a-efd659919422_h3so1o_u/attempt_0/0/stdout.log:1:current arguments:  Namespace(dataset_name='PG-P', zero_shot=False, day0_id=0, data_root_dir='/data/hossein/data', aligner_val_frac=0.75, dayk_aligner_trials=80, day0_aligner_trials=80, random_seed=42, constant_cut=False, d_lr=0.001, g_lr=0.001, batch_size=32, id_loss_p=2.0, cycle_loss_p=10.0, epochs=400, g_hidden_dim=64, d_hidden_dim=None, drop_out_g=0.2, drop_out_d=0.2, n_lags
