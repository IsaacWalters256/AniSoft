extends Node3D

@onready var mesh_main = get_node("MeshMain")
var current_file = "res://NC/AniSoft/AniFiles/AniHazel1.txt"

var anis = {
	"stand_straight": [[["Big1",[[-90,0,0],[0,0,0],[0,0,0]],3,"none"]]]
	}

func save_data(content):
	#print("have it so i can selecte a file from that folder?") maybe later on handle multiple files
	var file = FileAccess.open(current_file, FileAccess.WRITE)
	
	file.store_line(str(content))
	file.close()

func load_data():
	var file = FileAccess.open(current_file, FileAccess.READ)
	var content = str_to_var(file.get_as_text())
	file.close()
	return content

func _ready() -> void:
	#save_data(anis)
	anis = load_data()
	mesh_main.start()
	get_node("AniMakerUI").load_ani_ui(anis,mesh_main)
