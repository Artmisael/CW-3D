extends Spatial

signal entrar
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$seleccion.altura = Vector3(0,2,0)
	pass # Replace with function body.


func _deselecionar():
	$seleccion/selecionado.hide()
	print("selec")
	
func _entrar():
	emit_signal("entrar",to_global(Vector3.ZERO))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
