extends Area

signal selecionaste
signal entrar
var edificio_inicial = false
var altura = Vector3.ZERO
var camara = null



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():	
	emit_signal("edificio_nuevo",self)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _seleccionado():
	$selecionado.show()
	
func _deselecionar():
	$selecionado.hide()	
	
func _entrar():
	$selecionado.hide()
	return([to_global(altura),get_parent(),camara])
	
	
	
