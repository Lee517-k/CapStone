#!/bin/bash
set -e
SCRIPT_DIR=$(dirname ${BASH_SOURCE})
export RESOURCE_NAME="IsaacSim"
export OLD_PYTHONPATH=$PYTHONPATH
exec "$SCRIPT_DIR/kit/kit" "$SCRIPT_DIR/apps/omni.isaac.sim.kit" --ext-folder "$SCRIPT_DIR/apps"  "$@"
