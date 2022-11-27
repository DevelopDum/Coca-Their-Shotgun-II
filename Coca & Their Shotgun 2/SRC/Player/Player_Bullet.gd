extends RigidBody2D

onready var Explosion: PackedScene = preload("res://SRC/Particles_And_Such/Explosion.tscn")
onready var Blood_Splat: PackedScene = preload("res://SRC/Particles_And_Such/Blood_Splat.tscn")
func _on_VisibilityEnabler2D_screen_exited() -> void:
	queue_free()


func _on_Hitbox_body_entered(body: Node) -> void:
	if body.name != "Coca":
		if body.is_in_group("ENEMY"):
			var Blood_Splat_Inst: CPUParticles2D = Blood_Splat.instance()
			get_parent().add_child(Blood_Splat_Inst)
			Blood_Splat_Inst.global_position = (global_position + Vector2(0, 12))
			Blood_Splat_Inst.rotation = rotation
			body.ouch()
		
		var Explosion_Inst: Sprite = Explosion.instance()
		get_parent().add_child(Explosion_Inst)
		Explosion_Inst.global_position = global_position
		queue_free()
