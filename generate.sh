#!/bin/bash
set -eo pipefail
set -x 
# conda activate ./env
ckpt_path=$1;shift
export dataset=Wiki
export stamp="$(date +%Y%m%d_%H%M%S)"
d="$(dirname $ckpt_path)/generate"  # output_dir
output_path="$d/generate.txt"
cuda=""  # leave empty or provide -cuda
mkdir -p $d
# sample top 5 with temp_sample decode method
# cmd="time python generate.py -data data/$dataset -max_vocab_cnt 50000 -load $ckpt_path -various_gen 5 -mask_prob 0.0 $cuda -decode_method temp_sample -sample_temperature 0.2 -gen_to_fi $output_path"
cmd="time python generate.py -data data/$dataset -max_vocab_cnt 50000 -load $ckpt_path -various_gen 1 -mask_prob 0.0 $cuda -decode_method beam_search -sample_temperature 0.2 -gen_to_fi $output_path"
echo "$cmd" > $d/cmd
echo "Saving log and model to $d"
$cmd 2>&1 | tee $d/log
