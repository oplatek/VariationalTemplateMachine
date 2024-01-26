#!/bin/bash
conda activate ./env
export dataset=Wiki
export stamp="$(date +%Y%m%d_%H%M%S)"
d="exp/$dataset.$stamp"
mkdir -p $d
cuda=""  # leave empty or provide -cuda
cmd="python train.py $cuda -data data/$dataset -max_vocab_cnt 50000 -emb_size 786 -hid_size 512 -table_hid_size 256 -pool_type max -sent_represent last_hid -z_latent_size 128 -c_latent_size 256 -dec_attention -drop_emb -add_preserving_content_loss -pc_weight 1.0 -add_preserving_template_loss -pt_weight 1.0 -anneal_function_z const -anneal_k_z 0.8 -anneal_function_c const -anneal_k_c 0.8 -add_mi_z -mi_z_weight 0.5 -add_mi_c -mi_c_weight 0.5 -lr 0.001 -clip 5.0 -log_interval 500 -bsz 16 -paired_epochs 5 -raw_epochs 2 -epochs 20 -save $d/model.ckpt"
echo "$cmd" > $d/cmd
echo "Saving log and model to $d"
$cmd 2>&1 | tee $d/log
