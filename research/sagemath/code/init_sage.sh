#!/bin/bash

# Check if Conda is installed
if ! command -v conda &> /dev/null
then
    echo "Conda is not installed. Please install Miniconda or Anaconda first."
    exit 1
fi

# Activate the Sage environment
echo "Activating the Sage environment..."
source $(conda info --base)/etc/profile.d/conda.sh
conda activate sage

# Check if Sage is available in the environment
if ! command -v sage &> /dev/null
then
    echo "SageMath is not available in the 'sage' Conda environment. Please check your installation."
    exit 1
fi

echo "SageMath initialized. Launching Sage..."
sage
