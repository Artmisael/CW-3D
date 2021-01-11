extends Spatial

export (float) var dencidad
var pocicion = Vector3()
var pocicion2 = Vector3()

func _ready():
	randomize()
	$Lima1/Path/Follow.translate_object_local(Vector3(.1,.1,.1))
	pass
	
func _process(delta):
	#pocicion= Vector3(rand_range(-.1, .1),rand_range(-.1, .1),rand_range(-.1, .1))
	#$Lima1/Path/Follow.set_unit_offset(randf())
	#pocicion= $Lima1/Path/Follow.get_offset()
	#$Lima1.translate(Vector3(.1,.1,.1))	
	$Lima1/Path/Follow.translate(Vector3(.1,.1,.1))
	pocicion = $Lima1/Path/Follow.translation
	pocicion2 = $Lima1/Path/Follow.
	pass
