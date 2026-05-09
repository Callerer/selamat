extends Node




func _on_button_pressed() -> void:
	var scene = load("res://scenes/mainscene.tscn")
	get_tree().change_scene_to_packed.call_deferred(scene)
