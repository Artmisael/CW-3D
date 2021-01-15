extends Area

signal selecionaste
signal entrar
var altura = Vector3.ZERO

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _selecionado():
	$selecionado.show()
	
func _entrar():
	$selecionado.hide()
	var padre=get_parent()
	padre.entrar()
	emit_signal("entrar",get_parent(),to_global(altura))
	
	