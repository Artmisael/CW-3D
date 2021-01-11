extends MeshInstance

export (float) var dencidad
var pocicion = Vector3()

func _ready():
	randomize()
	pass
	
func _process(delta):
	#pocicion= Vector3(rand_range(-.1, .1),rand_range(-.1, .1),rand_range(-.1, .1))
	#$Path/Follow.set_offset(randi())
	#pocicion= $Path/Follow.translation
	#translate(Vector3(.1,.1,.1))
	pass
