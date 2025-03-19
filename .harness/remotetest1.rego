package pipeline

# Deny pipelines that don't have an approval step
# NOTE: Try removing the HarnessApproval step from your input to see the policy fail
deny[msg] {
	# Find all stages that are Deployments ...
	input.pipeline.stages[i].stage.type == "Deployment"

	# ... that are not in the set of stages with HarnessApproval steps
	not stages_with_approval[i]

	# Show a human-friendly error messageve
	# edited 1
	# edited 2.2.1.1.5
	# edited 3.1.1
	# edited 4.1
	# edited 5
	# edited 6
	msg := sprintf("deployment stages '%s' does not have aa HarnessaaaAAApprhoval step", [input.pipeline.stages[i].stage.name])
}

# Find the set of stages that contain a HarnessApproval step
stages_with_approval[i] {
	input.pipeline.stages[i].stage.spec.execution.steps[_].step.type == "HarnessApproval"
}
