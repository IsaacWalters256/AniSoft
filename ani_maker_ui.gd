extends Control

var main_mesh = null

func _ready() -> void:
	pass
#base array, which key frame, [body part, [degrees][position][scale], time
#@onready var stand_straight = [[[0,[[-90,0,0],[0,0,0],[0,0,0]],3,"functionToCall"]]]

var current_data = {}

func load_ani_ui(data_pass,main_mesh_ref):
	current_data = data_pass
	get_node("MainTextEdit").text = str(current_data)
	#do we even need the joint buttons with this other stuff?
	
	#select_anis(0)
	main_mesh = main_mesh_ref
	for joint in main_mesh_ref.joints:
		pass
	
	#select_selected?

func update_spinners():
	#print(get_node("AnimationSelectOptions").get_item_text(get_node("AnimationSelectOptions").selected))
	get_node("FrameSelectSpin").max_value = current_data[get_node("AnimationSelectOptions").get_item_text(get_node("AnimationSelectOptions").selected)][0].size()-1
	update_frame(get_node("FrameSelectSpin").value)

func _on_save_button_pressed() -> void:
	get_parent().save_data(str_to_var(get_node("MainTextEdit").text))
	current_data = get_parent().load_data()



func update_frame(new_frame):
	#print(get_node("AnimationSelectOptions").get_item_text(get_node("AnimationSelectOptions").selected))
	#print(current_data[get_node("AnimationSelectOptions").get_item_text(get_node("AnimationSelectOptions").selected)][0][new_frame])
	#str_to_var(get_node("MainTextEdit").text)
	main_mesh.run_single_frame(current_data[get_node("AnimationSelectOptions").get_item_text(get_node("AnimationSelectOptions").selected)][new_frame])
	#need to call a load somewhere or something, its going off of old data even after a save

func _on_animation_select_options_pressed() -> void:
	get_node("AnimationSelectOptions").clear()
	for a in current_data:
		get_node("AnimationSelectOptions").add_item(a)


func _on_load_ani_button_pressed() -> void:
	update_spinners()


func _on_to_this_frame_button_pressed() -> void:
	update_frame(get_node("FrameSelectSpin").value)


func _on_frame_select_spin_changed() -> void:
	update_frame(get_node("FrameSelectSpin").value)
