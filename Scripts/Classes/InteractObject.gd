class_name InteractObject
extends StaticBody2D

signal interacted_with(interactor : Node2D)

# This object emits a signal when calling interact() by default.
# Override this method to define custom behaviour(why would you? signals are OP)

func interact(interactor : Node2D = null):
	interacted_with.emit(interactor)
