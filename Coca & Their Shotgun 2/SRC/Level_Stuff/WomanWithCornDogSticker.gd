extends Area2D

var collected: bool = false

func _on_WomanWithCornDogSticker_body_entered(body: Node) -> void:
	if body.name == "Coca" && collected == false:
		collected = true
		Globals.Stickers += 1
		Globals.emit_signal("Sticker_Collected")
		$AnimationPlayer2.stop()
		$AnimationPlayer2.play("Collect")
