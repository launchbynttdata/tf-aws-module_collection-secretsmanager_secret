package testimpl

import (
	"context"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestSecretsManagerComplete(t *testing.T, ctx types.TestContext) {
	// TODO: Remove this test from your module once you have defined some other tests.
	t.Run("TestARNAndIDPatternMatches", func(t *testing.T) {
		checkARNIDFormat(t, ctx)
	})

	t.Run("TestingSecretExists", func(t *testing.T) {
		testSecretsManager(t, ctx)
	})

}

func checkARNIDFormat(t *testing.T, ctx types.TestContext) {
	expectedPatternARN := `^arn:aws:secretsmanager:[a-z0-9-]+:\d{12}:secret:[a-zA-z0-9/_+=.@-]+$`

	actualID := terraform.Output(t, ctx.TerratestTerraformOptions(), "id")
	assert.NotEmpty(t, actualID, "ARN ID is empty")
	assert.Regexp(t, expectedPatternARN, actualID, "ID does not match expected pattern")

	actualARN := terraform.Output(t, ctx.TerratestTerraformOptions(), "arn")
	assert.NotEmpty(t, actualARN, "ARN is empty")
	assert.Regexp(t, expectedPatternARN, actualARN, "ARN does not match expected pattern")
}

func testSecretsManager(t *testing.T, ctx types.TestContext) {
	input := &secretsmanager.DescribeSecretInput{
		SecretId: aws.String(terraform.Output(t, ctx.TerratestTerraformOptions(), "arn")),
	}

	client := GetSecretsManagerClient(t)

	result, err := client.DescribeSecret(context.TODO(), input)
	assert.NoError(t, err, "The expected secret was not found")

	actualARN := result.ARN

	expectedARN := terraform.Output(t, ctx.TerratestTerraformOptions(), "arn")
	assert.NoError(t, err)
	assert.Equal(t, expectedARN, *actualARN, "Secret ARN doesn't match")
}

func GetAWSConfig(t *testing.T) (cfg aws.Config) {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	require.NoErrorf(t, err, "unable to load SDK config, %v", err)
	return cfg
}

func GetSecretsManagerClient(t *testing.T) *secretsmanager.Client {
	secretsManagerClient := secretsmanager.NewFromConfig(GetAWSConfig(t))
	return secretsManagerClient
}
