extends Node3D

#var character_height = 1.032
var joints = []
var current_tween = null

var current_ani = "stand_straight"
var looping = false
#var current_ani_counter = 0

func start():
	get_all_joints(self.get_children()[0])


func get_all_joints(node):
	#could have a counter to save index of joint
	for n in node.get_children():
		if n.get_class() == "Node3D":#get_name().begins_with("PJ"):
			if n.get_child_count() > 0:
				joints.append([n,n.get_name()])
				#joints.append_array(get_all_joints(n))
				get_all_joints(n)
			else:
				joints.append([n,n.get_name()])
	#return joints

func find_joint_in_array(joint_name):
	var found_joint = self.get_children()[0]
	for j in joints:
		if j[1] == joint_name:
			found_joint = j[0]
	return found_joint

#base array, which key frame, [body part, [[degrees][position][scale]], time, funciton to call]
#@onready var stand_straight = [[[0,[[-90,0,0],[0,0,0],[0,0,0]],3,"none"]]]


func run_single_frame(new_frame):
	for t in new_frame:
		var t_trans = find_joint_in_array(t[0])
		var new_needs = [[false,Vector3(t_trans.rotation.x,t_trans.rotation.y,t_trans.rotation.z)],[false,Vector3(t_trans.position.x,t_trans.position.y,t_trans.position.z)],[false,Vector3(t_trans.scale.x,t_trans.scale.y,t_trans.scale.z)]]
		
		var no_zero = -0.055
		for nn in new_needs.size():#need to convert rotation from deg to rad somehwere else
			if t[1][nn][0] != no_zero:
				new_needs[nn][1].x = t[1][nn][0]
				new_needs[nn][0] = true
			if t[1][nn][1] != no_zero:
				new_needs[nn][1].y = t[1][nn][1]
				new_needs[nn][0] = true
			if t[1][nn][2] != no_zero:
				new_needs[nn][1].z = t[1][nn][2]
				new_needs[nn][0] = true
		
		if new_needs[0][0] || new_needs[1][0] || new_needs[2][0]:
			if current_tween:#probably needs changed to not kill that last one but idk maybe an option
				current_tween.kill()
			var tween = get_tree().create_tween()
			current_tween = tween
			var run_para = false
			
			if new_needs[0][0]:
				tween.tween_property(t_trans, "rotation", new_needs[0][1], t[2])#.set_trans(Tween.TRANS_SINE)
				run_para = false
			if new_needs[1][0]:
				if run_para:
					tween.tween_property(t_trans, "position", new_needs[1][1], t[2])
				else:
					tween.parallel().tween_property(t_trans, "position", new_needs[1][1], t[2])
					run_para = false
			if new_needs[2][0]:
				if run_para:
					tween.tween_property(t_trans, "scale", new_needs[2][1], t[2])
				else:
					tween.parallel().tween_property(t_trans, "scale", new_needs[2][1], t[2])


func stop_current_animation():#instead of doing this have an animation stop ani that sets them all to where they are
	if current_tween:
		current_tween.kill()

#a key of 0 means no change
func run_animation(new_animation, is_looping):
	if is_looping == true:
		looping = true#maybe replace this with a check after ani done that sees what to play next?
	for kf in new_animation:
		run_single_frame(kf)
		
		#tween.tween_callback(self.animation_ended)
		#current_ani_counter

func animation_ended():#temp_ani_counter):
	print("don")
	#if looping == true:
	#	run_animation(current_ani, looping)
		






#d
