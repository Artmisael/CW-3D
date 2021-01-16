extends Spatial

export (bool) onready var inicial = false
var edificios = []

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _entrar():
	pass

func _construir(edificios_anteriores):
	for i in edificios_anteriores:
		edificios.append(i)
	pass
	
func _conectar(jugador):
	pass

func _deselecionar():
	$seleccion/selecionado.hide()
	print("selec")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
