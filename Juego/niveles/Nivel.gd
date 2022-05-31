extends Node
signal abrir_portal()

onready var nubes_lejanas = $ParallaxBackground/ParallaxNube
export var menu_game_over = "res://Juego/Menus/GameOver.tscn"
export var nivel_actual = "res://Juego/niveles/Nivel1.tscn"

var numero_zanahorias = 0
var contenedor_zanahorias


func _ready():
# warning-ignore:return_value_discarded
	DatosPlayer.connect("game_over", self, "game_over")
	contenedor_zanahorias = get_node_or_null("Zanahorias")
	if contenedor_zanahorias != null:
		numero_llaves_nivel()


#nubes moverse
func _process(_delta):
	nubes_lejanas.motion_offset.x -= 5


func numero_llaves_nivel():
	numero_zanahorias = contenedor_zanahorias.get_child_count()
	DatosPlayer.contabilizar_llaves(numero_zanahorias)
	for llave in contenedor_zanahorias.get_children():
		llave.connect("consumido", self, "llaves_restantes")


func llaves_restantes():
	numero_zanahorias -= 1
	if numero_zanahorias == 0:
		emit_signal("abrir_portal")
		#abrir portal


func game_over():
	DatosPlayer.nivel_actual = nivel_actual
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_game_over)
