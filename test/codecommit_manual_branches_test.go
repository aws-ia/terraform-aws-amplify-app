package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCodeCommitManualBranches(t *testing.T) {

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/codecommit-deployment/manual-branch-creation",
		// Vars: map[string]interface{}{
		// 	"myvar":     "test",
		// 	"mylistvar": []string{"list_item_1"},
		// },
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}
