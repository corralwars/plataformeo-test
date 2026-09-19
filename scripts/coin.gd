extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_collect()

func _collect():
	var ui = get_tree().get_first_node_in_group("ui")
	if ui:
		ui.coin_collected()
	queue_free()
