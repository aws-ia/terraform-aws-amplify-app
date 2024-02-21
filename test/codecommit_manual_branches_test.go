package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCodeCommitManualBranches(t *testing.T) {

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/codecommit-deployment/manual-branch-creation",

	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}
