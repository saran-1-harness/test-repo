package pipeline

main edited

# Deny pipelines that are missing required steps
# NOTE: Try adding "HarnessApproval" to the 'forbidden_steps' list to see the policy fail
deny[msg] {
	# Find all stages ...
	stage = input.pipeline.stages[_].stage

	# ... that are deployments
	stage.type == "Deployment"

	# Find all steps in each stage ...
	step = stage.spec.execution.steps[_].step

	# ... that use forbidden types
	forbidden_steps[_] = step.type

	# Show a human-friendly error message
	msg := sprintf("deployment stage '%s' has step '%s' that is forbidden type '%s'", [stage.name, step.name, step.type])
}

# Steps that should not used in deployments
forbidden_steps = ["ShellScript"]

contains(arr, elem) {
	arr[_] = elem
}
