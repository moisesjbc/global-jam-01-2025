extends TextureButton


export var text: String = ""


func _ready():
	$label.text = text
