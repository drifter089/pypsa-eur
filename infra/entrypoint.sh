
# Set the URL of the Git repository
GIT_REPO_URL="https://github.com/PyPSA/pypsa-eur.git"
# Set the path to the environment file relative to the git repository root
ENV_FILE_PATH="envs/environment.yaml"

ENV_NAME="pypsa-eur"

# Update package lists
sudo apt-get update -y

sudo apt-get install wget -y

# Install Git
sudo apt-get install git -y

# Clone the specified Git repository
git clone $GIT_REPO_URL
# Assuming the repository's name is the last part of the URL
REPO_NAME=$(basename $GIT_REPO_URL .git)
# Change directory to the repository
cd $REPO_NAME

# Install Mamba package manager
# We first install Miniconda which is a minimal installer for Conda
# Then we use Conda to install Mamba
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
sudo bash miniconda.sh -b -p $HOME/miniconda
source "$HOME/miniconda/etc/profile.d/conda.sh"
conda install mamba -n base -c conda-forge

# Cleanup downloaded files
rm miniconda.sh

# Create the environment using Mamba and the environment file
mamba env create -f $ENV_FILE_PATH

# Activate the environment
# The name of the environment is assumed to be the first line in the environment file after the name: key
conda activate $ENV_NAME

snakemake -call results/test-elec/networks/elec_s_6_ec_lcopt_Co2L-24H.nc --configfile config/test/config.electricity.yaml


