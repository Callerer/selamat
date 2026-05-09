extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		var scene = load("res://endscene.tscn")
		get_tree().change_scene_to_packed.call_deferred(scene)
