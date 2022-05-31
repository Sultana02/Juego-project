extends Area2D

var esta_activo = false
export var next_level = ""


#conecta la señal de abrir_portal
func _ready():
# warning-ignore:return_value_discarded
	get_parent().connect("abrir_portal", self, "play_animacion")


#cambia de nivel y tiempo de entrada al portal
func _on_body_entered(body):
	if esta_activo:
		body.play_entrar_portal(global_position)
		yield(get_tree().create_timer(1.0), "timeout")
		cambiar_nivel()


func cambiar_nivel():
# warning-ignore:return_value_discarded
	get_tree().change_scene(next_level)


func play_animacion():
	esta_activo = true
	$AnimatedSprite.play("default")
	$AnimationPlayer.play("Activado")
