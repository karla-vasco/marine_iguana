#!/bin/bash --login  
 
########## Define Resources Needed with SBATCH Lines ##########
#SBATCH --job-name=PEAR_merge    # give your job a name for easier identification (same as -J)
#SBATCH --time=168:00:00        # limit of wall clock time - how long will the job take to run? (same as -t)
#SBATCH --ntasks=2           # number of tasks - how many tasks (nodes) does your job require? (same as -n)
#SBATCH --cpus-per-task=5    # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem=100G             # memory required per node - amount of memory (in bytes)
#SBATCH --output=/mnt/scratch/vascokar/marine_iguana/eofiles/pear.%j.out #Standard output
#SBATCH --error=/mnt/scratch/vascokar/marine_iguana/eofiles/pear.%j.err #Standard error log

########## Diplay the job context ######
echo Job: $SLUM_JOB_NAME with ID $SLURM_JOB_ID
echo Running on host `hostname`
echo Job started at `date '+%T %a %d %b %Y'`
echo Directory is `pwd`
echo Using $SLURM_NTASKS processors across $SLURM_NNODES nodes

######### Assign path variables ########

INPUT_DIRECTORY=/mnt/scratch/vascokar/marine_iguana/shotgun/trimmed
OUTPUT_DIRECTORY=/mnt/scratch/vascokar/marine_iguana/shotgun/merged

########## Modules to Load ##########cd 

module purge
module load GCC/5.4.0-2.26  OpenMPI/1.10.3
module load PEAR/0.9.8

########## Code to Run ###########

cd $INPUT_DIRECTORY
for f in *_R1_paired.fastq.gz # for each sample f

do
  n=${f%%_R1_paired.fastq.gz} # strip part of file name

pear \
-f $INPUT_DIRECTORY/${n}_R1_paired.fastq.gz \
-r $INPUT_DIRECTORY/${n}_R2_paired.fastq.gz \
-o $OUTPUT_DIRECTORY/${n}_paired_merged.fastq.gz

done

##### Final time stamp ######
echo Job finished at `date '+%T %a %d %b %Y'`