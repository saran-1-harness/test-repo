package pipeline

# opa-main-2

# Deny pipelines that are missing required steps
# NOTE: Try adding "ShellScript" to the 'required_steps' list to see the policy fail
deny[msg] {
	# Find all stages ...
	stage = input.pipeline.stages[_].stage

	# ... that are deployments
	stage.type == "Deployment"

	# ... and create a list of all step types in use
	existing_steps := [s | s = stage.spec.execution.steps[_].step.type]

	# For each required step ...
	required_step := required_steps[_]

	# ... check if it's present in the existing steps
	not contains(existing_steps, required_step)

	# Show a human-friendly error message
	msg := sprintf("deployment stage '%s' is missing required step '%s'", [stage.name, required_step])
}

# Steps that must be present in every deployment
required_steps = ["JiraUpdate","HarnessApproval"]

contains(arr, elem) {
	arr[_] = elem
}
