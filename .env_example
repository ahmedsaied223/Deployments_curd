#!/bin/bash

# Description: This script exports environment variables for various tokens and configuration files.
# Author: Ahmed
# Date: 2024-11-10

# Export environment variables
export ARTIFACTORY_TOKEN= "token"
export TF_TOKEN_artifactory_comcast_com="token"
export TG_TF_REGISTRY_TOKEN="token"
export RDEI_TOKEN="token"
export TF_VAR_rdei_token="token"
export TF_VAR_rdei_personal_token="token"
export TF_CLI_CONFIG_FILE=~/.terraformrc
export SOPS_AGE_KEY_FILE=~/.sops-age-key 

echo "Ahmed's Environment variables have been exported."


# Description: This script tests if the environment variables are correctly set.

# Function to test if an environment variable is set
test_env_var() {
    local var_name=$1
    local var_value=$(printenv "$var_name")

    if [ -z "$var_value" ]; then
        echo "FAIL: Environment variable $var_name is not set."
        return 1
    else
        echo "PASS: Environment variable $var_name is set."
        return 0
    fi
}

# Test each environment variable
test_env_var "ARTIFACTORY_TOKEN"
test_env_var "TF_TOKEN_artifactory_comcast_com"
test_env_var "TG_TF_REGISTRY_TOKEN"
test_env_var "RDEI_TOKEN"
test_env_var "TF_VAR_rdei_token"
test_env_var "TF_VAR_rdei_personal_token"
test_env_var "TF_CLI_CONFIG_FILE"
test_env_var "SOPS_AGE_KEY_FILE"

# Exit with success if all tests pass
echo "All tests completed."
