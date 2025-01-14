extends CharacterBody2D

var maxSpeed: float = 75.0
var accel: float = 1200.0

var drag: float = 0.1
var ikDrag: float = 20.0
var dragSmooth: float = 0.1

var MaxIKDistance:float = 200
var MinIKDistance:float = 100
var bones: Skeleton2D
var rightArm: Node2D
var leftArm: Node2D
var rightLeg: Node2D
var leftLeg: Node2D

var rightShoulder : Bone2D
var leftShoulder :Bone2D
var rightHip:Bone2D
var leftHip:Bone2D

func _ready() -> void:

	bones = $"Character Container/Bones"
	rightArm = $"Character Container/IK Nodes/IKRArm"
	leftArm = $"Character Container/IK Nodes/IKLArm"
	rightLeg = $"Character Container/IK Nodes/IKRLeg"
	leftLeg = $"Character Container/IK Nodes/IKLLeg"
	rightShoulder =$"Character Container/Bones/Pelvis/Chest/Right_Shoulder"
	leftShoulder =$"Character Container/Bones/Pelvis/Chest/Left_Shoulder"
	rightHip = $"Character Container/Bones/Pelvis/Right_Hip"
	leftHip = $"Character Container/Bones/Pelvis/Left_Hip"

func _process(_delta: float) -> void:
	var v:float = 0.0
	var direction:Vector2 = Input.get_vector("p2_left","p2_right","p2_up","p2_down")
	var velo: Vector2 = velocity
	
	if direction != Vector2.ZERO:
		if (maxSpeed - v) > accel:
			v += accel
			velo += direction * v * _delta
		else:
			v=maxSpeed
			velo+= direction * v * _delta
			
	move_and_slide()
	
	if is_on_wall():
		if get_wall_normal() != Vector2.ZERO:
			if (abs(get_wall_normal().x)> abs(get_wall_normal().y)):
				velo.x = 0
			else:
				velo.y = 0
			
	var collision = move_and_collide(velo * _delta)

	if direction == Vector2.ZERO:
		if collision != null:
			if call_deferred("position.x") == position.x:
				velo.x = 0
			if call_deferred("position.y") == position.y:
				velo.y = 0
	velocity = velo
	
	var dragVector:Vector2 = -velo * drag
	_ApplyDragToIKTarget(rightArm,dragVector,_delta,0)
	_ApplyDragToIKTarget(leftArm,dragVector,_delta,1)
	_ApplyDragToIKTarget(rightLeg,dragVector,_delta,2)
	_ApplyDragToIKTarget(leftLeg,dragVector,_delta,3)
	pass
func _ApplyDragToIKTarget(ikTarget:Node2D,dragVector:Vector2,delta:float,num:int):
	var currentPosition:Vector2 = ikTarget.global_position
	
	var targetPosition = currentPosition + dragVector.normalized()* ikDrag
	
	var newPosition = currentPosition.lerp(targetPosition,dragSmooth)
	
	var bone:Bone2D = null
	var maxAngle:int = 0
	var minAngle:int = 0
	
	var orgin:Vector2 = global_position
	match(num):
		0:
			orgin = rightShoulder.global_position
			bone = rightShoulder
			maxAngle = 70
			minAngle = -30
		1:
			orgin = leftShoulder.global_position
			bone = leftShoulder
			maxAngle = 30
			minAngle = -70
		2:
			orgin = rightHip.global_position
			bone = rightHip
			maxAngle = 10
			minAngle = -30
		3:
			orgin = leftHip.global_position
			bone = leftHip
			maxAngle = 30
			minAngle = -10
	if newPosition.distance_to(orgin) > MaxIKDistance:
		newPosition = orgin + (newPosition - orgin).normalized() * MaxIKDistance
	elif newPosition.distance_to(orgin) <MinIKDistance:
		newPosition = orgin + (newPosition - orgin).normalized() * MinIKDistance
	
	if bone.rotation <= deg_to_rad(maxAngle) and bone.rotation >= deg_to_rad(minAngle):
		ikTarget.global_position = newPosition
	else:
		match(num):
			0:
				newPosition = newPosition + Vector2(3.0,3.0)
			1:
				newPosition = newPosition + Vector2(-3.0,3.0)
			2:
				newPosition = newPosition + Vector2(3.0,3.0)
			3:
				newPosition = newPosition + Vector2(-3.0,3.0)
		ikTarget.global_position = newPosition
