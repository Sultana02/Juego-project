extends KinematicBody2D

export var velocidad = Vector2(150.0, 150.0)
export var ace_caida = 400
export var fuerza_salto = 3000
export var rebote = 350
export var impulso = -3800
export var acel_caida_power_up = 400

#SE INICIA VALE 0
var movimiento = Vector2.ZERO
var fuerza_salto_original
var acel_caida_original
var puede_moverse = true

#Animacion de movimiento y sonido
onready var animacion = $AnimatedSprite
onready var salto_sound = $SaltoAudio
onready var camara = $Camera2D
onready var respawn_audio = $RespawnAudio
onready var enfriamiento_power_up = $EnfriamientoPupSaltar
onready var enfriamiento_power_up_volar = $EnfriamientoPupVolar
onready var animacion_personaje = $AnimationPlayer


func _ready():
	animacion_personaje.play("aclarar")
	fuerza_salto_original = fuerza_salto
	acel_caida_original = ace_caida


func _physics_process(_delta):
	movimiento.x = velocidad.x * elegir_direccion()
	caer()
	saltar()
	colision_techo()
# warning-ignore:return_value_discarded
	move_and_slide(movimiento,Vector2.UP)
	caida_vacio()


#direccion
func elegir_direccion():
	var direccion = 0
	if puede_moverse:
		direccion = Input.get_action_strength("mov_adelante") - Input.get_action_strength("mov_atras")
		#Cuando quiero que se ejecute default animation
		if direccion == 0:
			animacion.play("Default")
		else:
			if direccion < 0:
				animacion.flip_h = true
			else:
				animacion.flip_h = false
			
			animacion.play("Run")
	
	return direccion


#si no está en el suelo
func caer():
	if not is_on_floor():
		animacion.play("Jump")
		#el motor calcula el mov y 
		movimiento.y += ace_caida
		movimiento.y = clamp(movimiento.y, impulso, velocidad.y)


#Salto
func saltar():
	if Input.is_action_just_pressed("Salto") and is_on_floor() and puede_moverse:
		salto_sound.play()
		animacion.play("Jump")
		saltar_movimiento()


func saltar_movimiento():
	movimiento.y = 0
	movimiento.y -= fuerza_salto


#impacto con techo
func colision_techo():
	if is_on_ceiling():
		movimiento.y = rebote


#salto de impulso
func impulsar():
	movimiento.y = impulso


func cambiar_salto():
	enfriamiento_power_up.start()
	fuerza_salto = -impulso * 0.9


func volar():
	enfriamiento_power_up_volar.start()
	ace_caida = 60
	animacion_personaje.play("Volar")
	saltar_movimiento()


func caida_vacio():
	if position.y > camara.limit_bottom:
		respawn()


#metodo Respawn
func respawn():
	DatosPlayer.restar_vidas()
	respawn_audio.play()
	animacion_personaje.play("oscurecer")
	if DatosPlayer.vidas >= 1:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene() #recarga la escena


#PowerUpSaltar
func _on_EnfriamientoPup_timeout():
	fuerza_salto = fuerza_salto_original


#PowerUpVolar
func _on_EnfriamientoPupVolar_timeout():
	animacion_personaje.play("default")
	ace_caida = acel_caida_original


func play_entrar_portal(posicion_portal):
	puede_moverse = false
	$AnimationPlayer.play("entrar_portal")
	$Tween.interpolate_property(
		self,
		"global_position",
		global_position,
		posicion_portal,
		0.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	$Tween.start()


#cuando una animacion termina oscurece
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "entrar_portal":
		animacion_personaje.play("oscurecer")
