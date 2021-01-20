extends Spatial

var edificios

func _ready():
	pass # Replace with function body.

func _construir(edificios_anteriores):
	edificios = edificios_anteriores
	$AnimationPlayer.play("Colector")
	pass
	
func _conectar(jugador):
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
