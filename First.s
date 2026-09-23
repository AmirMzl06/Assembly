mirzaei@haas034:/mnt/upmwmathis/scratch/hossein/aj_project/adversarial_BCI$ eerwmirzaei@haas034:/mnt/upmwmathis/scratch/hossein/aj_project/adversarial_BCI$ grep -R "decoder" -n . --exclude-dir=runs | head -50
grep: ./.git/index: binary file matches
./.gitignore:211:decoders/
./.gitignore:212:decoder/
./.gitignore:213:decoder_standard/
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:16:    "## The problem -- the performance of a well-calibrated iBCI decoder degrades over time"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:24:    "Intracortical brain-computer interfaces (iBCIs) uses a \"decoder\" to translate the moment-to-moment neural activity into a signal for intended movements, so as to help restore lost motor functions for people with paralysis (Figure 1A). \n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:26:    "The instability in neural recordings is a major hurdle to the long-term stability of iBCIs. Let's imagine the following case. On day-0, a BCI decoder is well calibrated and learned by the user. As time goes, usually we will see substantial changes in acquired neural signals on day-k. Such changes would hurt the performance of the well-calibrated day-0 decoder a lot (see Figure 1B) so that the intent of the user cannot be accurately predicted any more.    \n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:28:    "One way to solve this problem is to simply recalibrate the decoder with newly acquired data. Apparently, the normal use of the BCI system would be interrupted during recalibration, and it will take additional time and efforts for the user to learn the recalibrated decoder.\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:31:    "*Figure 1 A) The decoder for intracortical brain-computer interfaces (iBCIs). B) A well-calibrated decoder could produce accurate estimations of the EMGs on day-0, but failed on day-k.*"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:47:    "An ideal iBCI would accommodate the instabilities in neural recordings without supervision, thereby minimizing the need to periodically learn new decoders. But, how to do it? \n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:49:    "As mentioned above, it is mainly due to the changes of neural signals from day-0 to day-k that a well-calibrated day-0 decoder failed on day-k. If we apply some transformation on day-k neural signals to make them similar to day-0 neural signals, would the performance of the day-0 decoder be maintained on day-k? [Our preprint](https://www.biorxiv.org/content/10.1101/2022.08.26.504777v1) shows that this notion is feasible to extend BCI decoding accuracy over time. \n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:51:    "In our study, we use Cycle-Consistent Adversarial Networks (Cycle-GAN, Zhu et al., 2017, originally proposed for unpaired image-to-image translation) to implement such transformation on day-k neural signals. The results we obtained showed that even ~3 months after decoder training the performance of the day-0 decoder can be maintained if using Cycle-GAN to **\"align\"** the full-dimentional neural signals. We call this process **\"alignment\"**, and use Cycle-GAN as the **\"aligner\"**. We also showed that Cycle-GAN is easy to train, and such alignment can be done on continuous recordings, which means, there is no need to align trials according to specific behavioral events.\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:77:    "The second is `decoder_standard` for BCI decoder training. We will use functions `train_wiener_filter` and `test_wiener_filter` to train Wiener filter based BCI decoders. These codes could be download from [here](https://github.com/xuanma/decoder_standard)."
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:85:    "### Load necessary packages and put the directories of `xds` and `decoder_standard` in the path"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:98:    "sys.path.append('your own path/decoder_standard')"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:317:    "## Train linear decoders using the day-0 data (4-fold cross validation)"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:325:    "Here we use a Wiener filter to predict the EMGs from M1 neural activity. This type of decoder have been widely used in the past (Cherian, Krucoff, and Miller 2011; Naufel et al. 2019). The filter uses linear regression to predict the EMGs at time t with the given inputs stretching from present to T time bins in the past. We set T = 4 (200 ms) for the decoders here.\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:345:    "*Figure 4 A Wiener filter based BCI decoder*"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:353:    "Before the actual decoder training, we need to format the input data to fit the requirements of the Wiener filter. Below is a toy example, where $T=4, p=4, q=2$, and 10 time steps are shown.\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:370:    "What if we want to use a single number to quantify the prediction accuracy of the decoder? To do this, we can use a multi-variate $R^2$ defined as below:\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:380:    "Finally, we will pick the best decoder through the 4-fold CV, and save it for the tests below. This could be implemented by the function `kFold` in *scikit-learn* package."
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:406:    "decoder_list = [] # for decoder saving\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:415:    "    #------ train a Wiener filter based decoder ------#\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:423:    "    #------ test a Wiener filter based decoder ------#\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:430:    "    decoder_list.append(H)\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:436:    "#========================================= Save the decoder from the best fold ==========================================#\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:437:    "np.save('./decoder/Day-0 decoder.npy', decoder_list[np.argmax(mr2_list)])    \n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:466:    "  - H: the decoder coefficients matrix\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:470:    "  - H: the decoder coefficients matrix\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:473:    "  - pred_y: a numpy array, EMGs predicted by the decoder, in concatenated trials"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:504:    "# ========================= Load the saved decoder and use day-0 data from test fold ==================================#\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:505:    "day0_decoder = np.load('./decoder/Day-0 decoder.npy')\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:514:    "plot_actual_and_pred_EMG('Using day-0 decoder to predict EMGs on day-0', \n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:515:    "                         day0_spike_te, day0_EMG_te, day0_decoder, bin_size, n_lags, 10, r2_list[best_fold], day0_EMG_names, 'orange')\n"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:523:    "### However, this decoder cannot yield good predictions on day-k data"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:531:    "Here we will use the first 40 trials on day-k to test the trained (saved) day-0 decoder."
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:544:      "The multi-variate R² of the EMGs predicted by the day-0 decoder on day-k is 0.6755498038374077\n"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:554:    "# ==================================== Load the saved decoder and use day-k data to test =======================================#\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:555:    "day0_decoder = np.load('./decoder/Day-0 decoder.npy')\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:559:    "print('The multi-variate R\\u00b2 of the EMGs predicted by the day-0 decoder on day-k is %s'%(mr2))\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:570:    "### Let's plot the EMGs predicted by the previously trained day-0 decoder"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:591:    "day0_decoder = np.load('./decoder/Day-0 decoder.npy')\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:592:    "plot_actual_and_pred_EMG('Using day-0 decoder to predict EMGs on day-k', \n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:593:    "                         dayk_spike_, dayk_EMG_, day0_decoder, bin_size, n_lags, 8, r2_k, dayk_EMG_names, 'orange')"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:601:    "In each panel, the black traces are the actual day-k EMGs, while the orange traces are the EMGs predicted by the decoder. The numbers are the $R^2$ values of the EMG predictions for individual muscles. Gray lines indicate individual trials. From these figures, we could learn that although the predictions for some muscles (ECRl) remain good, the predictions for most muscles are quite different of the real EMGs"
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:617:    "Now we are going to build the Cycle-GAN based aligner described in [Our preprint](https://www.biorxiv.org/content/10.1101/2022.08.26.504777v1). We will train it with a certain number of trials. We will test the performance of the day-0 decoder after aligning day-k data using the Cycle-GAN based aligner. We will use `pytorch` for all the implementations. Since our approach is quite effecient, a CPU is already good enough for the training, while a GPU may not be used.\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:807:    "def train_cycle_gan_aligner(x1, x2, y2, D_params, G_params, training_params, decoder, n_lags, logs = True):\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:824:    "    decoder: the day-0 decoder to be tested on the validation set, an array.\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:826:    "    n_lags: the number of time lags of the decoder, a number.\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:897:    "                 'decoder r2 wiener': [],\n",
./.ipynb_checkpoints/Cycle_GAN_aligner-checkpoint.ipynb:898:    "                 'decoder r2 rnn': []}\n",
mirzaei@haas034:/mnt/upmwmathis/scratch/hossein/aj_project/adversarial_BCI$ 

