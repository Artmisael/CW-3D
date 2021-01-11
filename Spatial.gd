extends Area


func _ready():
	var b
	var a
	a = $MeshInstance.get_surface_material(0)
	$MeshInstance.set_surface_material(1,a)
	b = $MeshInstance.get_surface_material(1)
	print(a)
	print(b)
	pass # Replace with function body."marial/0","albedo_color"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
