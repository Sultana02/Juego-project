extends Area2D
signal consumido()


func _on_body_entered(_body):
	DatosPlayer.restar_llaves()
	emit_signal("consumido")
	$DetectaPersonaje.set_deferred("disabled", true)
	$AnimationPlayer.play("consumir")
