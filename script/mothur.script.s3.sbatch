#!/bin/bash
#SBATCH --job-name=mothur_s3
#SBATCH --output=mothur_s3_%j.out
#SBATCH --error=mothur_s3_%j.err
#SBATCH --time=04:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=12

curr_path=/home/a.onnis-hayden/scratch/PROJECTS/J5506_KYLIE_CLOSE_AOEHMEN_GROUP/Amplicon_Sequencing_Analysis
/home/a.onnis-hayden/opt/mothur/1.48.0/bin/mothur $curr_path/script/mothur.script.s3 > $curr_path/s3.output       
