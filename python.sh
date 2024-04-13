#!/bin/bash

set -e

error_exit()
{
    echo "There was an error running python"
    exit 1
}

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# MY_DIR="$(realpath -s "$SCRIPT_DIR")"

# Setup python env from generated file (generated by tools/repoman/build.py)
export CARB_APP_PATH=$SCRIPT_DIR/kit
export ISAAC_PATH=$SCRIPT_DIR
export EXP_PATH=$SCRIPT_DIR/apps
source ${SCRIPT_DIR}/setup_python_env.sh

# By default use our python, but allow overriding it by checking if PYTHONEXE env var is defined:
python_exe=${PYTHONEXE:-"${SCRIPT_DIR}/kit/python/bin/python3"}


if ! [[ -z "${CONDA_PREFIX}" ]]; then
  echo "Warning: running in conda env, please deactivate before executing this script"
  echo "If conda is desired please source setup_conda_env.sh in your python 3.10 conda env and run python normally"
fi

# Check if we are running in a docker container
if [ -f /.dockerenv ]; then
  # Check for vulkan in docker container
  if [[ -f "${SCRIPT_DIR}/vulkan_check.sh" ]]; then
    ${SCRIPT_DIR}/vulkan_check.sh
  fi
fi

# Show icon if not running headless
export RESOURCE_NAME="IsaacSim"
# WAR for missing libcarb.so
export LD_PRELOAD=$SCRIPT_DIR/kit/libcarb.so
$python_exe "$@" $args || error_exit
