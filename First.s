mirzaei@haas034:~/sam/result/Aggregate$ grep -n "load_dataset\|get_day\|get_dataset\|day0\|day_id" cycle_gan_notebook_merged.py
34:parser.add_argument('--day0_id', type=int, default=0)
40:parser.add_argument('--day0_aligner_trials', type=int, default=80, choices=[80, 128],
86:day0_id = args.day0_id
89:day0_aligner_trials = args.day0_aligner_trials
116:num_days = dataset_loader.get_dataset_num_days(dataset_name)
136:    dayk_spike, dayk_label = dataset_loader.load_dataset_day(
145:def train_day0_decoder(day0_spike_, day0_label_):
148:    for train_idx, test_idx in decoder_kf.split(day0_spike_):
150:        x_train = [day0_spike_[i] for i in train_idx]
151:        y_train = [day0_label_[i] for i in train_idx]
162:        x_test = [day0_spike_[i] for i in test_idx]
163:        y_test = [day0_label_[i] for i in test_idx]
530:day0_decoder = None
536:    global day0_decoder, _checkpoint_aligner, _figure_export_ctx
537:    day0_spike, day0_label = dataset_loader.load_dataset_day(
538:        day0_id, dataset_name, stack=False, bin_size=bin_size)
545:        day0_n = dayk_n = TRIAL_CAP
547:            aligner_day0_n = aligner_dayk_n = TRIAL_CAP // 2
550:            aligner_day0_n = day0_aligner_trials
555:        day0_n = len(day0_spike)
557:        aligner_day0_n = day0_n // 2
561:    day0_spike_ = day0_spike[:day0_n]
562:    day0_label_ = day0_label[:day0_n]
565:    decoder_train_n = int(day0_n * 0.8)
567:    best_day0 = None
568:    if day0_decoder is None:
569:        day0_decoder, best_day0 = train_day0_decoder(day0_spike_[:decoder_train_n], day0_label_[:decoder_train_n])
571:    input_dim = int(day0_spike_[0].shape[1])
582:            day0_spike_[:aligner_day0_n], dayk_spike_[:aligner_dayk_n],
583:            D_params, G_params, training_params, day0_decoder, n_lags,
594:    pred_dayk_label_test_ = test_wiener_filter(dayk_spike_aligned_, day0_decoder)
601:            "day0_spike": day0_spike,
602:            "day0_label": day0_label,
606:            "aligner_day0_n": aligner_day0_n if constant_cut else None,
610:    return mr2, best_day0
614:best_day0_overall = None
615:day_indices = [k for k in range(1, num_days) if k != day0_id]
617:    day_mr2, best_day0_temp = test_dayk(k)
618:    if best_day0_temp is not None:
619:        best_day0_overall = best_day0_temp
622:print('Best day 0 result is: %s' % round(best_day0_overall, 3))
635:        day0_decoder=day0_decoder,
638:        train_day=day0_id,
639:        day0_spike=ctx["day0_spike"],
640:        day0_label=ctx["day0_label"],
647:        aligner_day0_n=ctx["aligner_day0_n"],
657:    r2_holdout = float(best_day0_overall) if best_day0_overall is not None else float("nan")
660:        r2_holdout = float(json.loads(plot_manifest.read_text()).get("r2_day0_overall", r2_holdout))
664:        "day0_decoder": day0_decoder,
704:        "day0_id": day0_id,
705:        "r2_day0_best": best_day0_overall,
mirzaei@haas034:~/sam/result/Aggregate$ 
