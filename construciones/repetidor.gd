extends Spatial

signal entrar
export onready var camara = "repetidor"
var edificios

# Called when the node enters the scene tree for the first time.
func _ready():
	$seleccion.altura = Vector3(0,2,0)
	$seleccion.camara = camara
	pass # Replace with function body.

func _construir(edificios_anteriores):
	edificios = edificios_anteriores
	$CPUParticles.show()
	pass
	
func _conectar(jugador):
	pass


func _deselecionar():
	$seleccion/selecionado.hide()
	print("selec")
	
func _entrar():
	emit_signal("entrar",to_global(Vector3.ZERO))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
