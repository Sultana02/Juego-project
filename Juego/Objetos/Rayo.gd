extends Area2D

export var velocidad = 400.0

var mi_pos = Vector2.ZERO

onready var animacion = $Animacion


func crear(pos):
	mi_pos = pos


func _ready():
	global_position = mi_pos
	animacion.play("cae")

#para que se mueva el rayo
#se mueva cuadro a cuadro
func _process(delta):
	global_position.y += velocidad * delta


func _on_VisibilityNotifier2D_screen_exited():
	destruirse()


func destruirse():
	queue_free()


func _on_body_entered(body):
	destruirse()
	if body.is_in_group("player"):
		body.respawn()

