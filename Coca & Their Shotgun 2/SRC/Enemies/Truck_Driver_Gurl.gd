extends Area2D

var Velocity: Vector2 = Vector2.ZERO
var SPEED: float = 175
var Distance: float = 0
var dir: int = 1

func _process(delta: float) -> void:
	Velocity.x = SPEED * dir * delta
	Distance += 1
	if Distance >= 170:
		queue_free()
	
	scale.x = -dir
	translate(Velocity)


func _on_Truck_Driver_Gurl_body_entered(body: Node) -> void:
	if body.name == "Coca":
		body.ouch()
