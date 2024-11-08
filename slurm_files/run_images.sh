#! /bin/bash 
#SBATCH --nodes=1
#SBATCH --mem=120G
#SBATCH --ntasks-per-node=20
#SBATCH --time=20:10:00
#SBATCH --partition=long
#SBATCH --job-name=spl5

#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=wolf6245@ox.ac.uk

module load Anaconda3
source activate /data/inet-multimodal-ai/wolf6245/envs/ph24
conda info --env

# python prepare_ptbxl_data.py \
#             -i /data/inet-multimodal-ai/wolf6245/data/ptb-xl/records500 \
#             -pd /data/inet-multimodal-ai/wolf6245/data/ptb-xl/ptbxl_database.csv \
#             -pm /data/inet-multimodal-ai/wolf6245/data/ptb-xl/scp_statements.csv \
#             -sd /data/inet-multimodal-ai/wolf6245/data/ptb-xl-p/labels/12sl_statements.csv \
#             -sm /data/inet-multimodal-ai/wolf6245/data/ptb-xl-p/labels/mapping/12slv23ToSNOMED.csv \
#             -o /data/inet-multimodal-ai/wolf6245/data/ptb-xl/records500_prepared

##################################################################################
# RUN: gen_ecg_images_from_data_batch
##################################################################################

# python prepare_image_data.py \
#         -i /data/inet-multimodal-ai/wolf6245/data/ptb-xl/records500_prepared_w_images/00000 \
#         -o /data/inet-multimodal-ai/wolf6245/data/ptb-xl/records500_prepared_w_images/00000

# python replot_pixels.py \
#         --resample_factor 7 \
#         --dir /data/inet-multimodal-ai/wolf6245/data/ptb-xl/records500_prepared_w_images/04000



python create_train_test.py \
        -i /data/inet-multimodal-ai/wolf6245/data/ptb-xl/records500_prepared_w_images/05000 \
        -d /data/inet-multimodal-ai/wolf6245/data/ptb-xl/ptbxl_database.csv \
        -o /data/inet-multimodal-ai/wolf6245/data/ptb-xl/Dataset500_Signals \
        --rgba_to_rgb \
        --gray_to_rgb \
        --mask \
        --mask_multilabel \
        --rotate_image \
        --plotted_pixels_key dense_plotted_pixels \
        --num_workers 10
