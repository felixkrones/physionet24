#! /bin/bash 
#SBATCH --cluster=htc
#SBATCH --gres=gpu:1
#SBATCH --nodes=1
#SBATCH --mem=250G
#SBATCH --ntasks-per-node=28
#SBATCH --time=10:10:00
#SBATCH --partition=short
#SBATCH --job-name=nn_pre

#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=wolf6245@ox.ac.uk

module load Anaconda3
source activate /data/inet-multimodal-ai/wolf6245/envs/ph24
conda info --env

# 1. Set the environment variables for nnU-Net.
export nnUNet_raw="/data/inet-multimodal-ai/wolf6245/data/ptb-xl"
export nnUNet_preprocessed="/data/inet-multimodal-ai/wolf6245/src/phd/physionet24/model/nnUNet_preprocessed"
export nnUNet_results="/data/inet-multimodal-ai/wolf6245/src/phd/physionet24/model/nnUNet_results"

# 2. Experiment planning and preprocessing
nnUNetv2_plan_and_preprocess -d 500 --clean -c 2d --verify_dataset_integrity

# 3. Model training # 14 h
# nnUNetv2_train 500 2d 0 -device cuda --c

# 4. Determine the best configuration
# nnUNetv2_find_best_configuration 500 -c 2d --disable_ensembling