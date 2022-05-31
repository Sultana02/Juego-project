extends StaticBody2D

func _on_DetectaPersonaje_body_entered(_body):
	$DetectaPersonaje/CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("romper")


func deshabilitar_colisionador():
	$Colisionador.set_deferred("disabled", true)
