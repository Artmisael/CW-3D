extends Spatial

signal edificio_nuevo

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():	
	emit_signal("edificio_nuevo",$puente_de_mando/Repetidor/seleccion)
	emit_signal("edificio_nuevo",$CSGTorus/metrallas/Metralla)
	emit_signal("edificio_nuevo",$CSGTorus/metrallas/Metralla2)
	emit_signal("edificio_nuevo",$CSGTorus/metrallas/Metralla3)
	emit_signal("edificio_nuevo",$CSGTorus/metrallas/Metralla4)
	emit_signal("edificio_nuevo",$CSGTorus/recolectores/Colector)
	emit_signal("edificio_nuevo",$CSGTorus/recolectores/Colector2)
	emit_signal("edificio_nuevo",$CSGTorus/recolectores/Colector3)
	emit_signal("edificio_nuevo",$CSGTorus/recolectores/Colector4)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
