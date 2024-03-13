extends KinematicBody2D

export (int) var speed = 400
const GRAVITY = 1200

const UP = Vector2(0, -1)
const jump = 250
var max_speed = 2000
var curr_speed : float = 0
var sliding : bool = false
var dash_amount = 1
var double_jump = 2
var velocity = Vector2()

func get_input():
	var animation = "diri_kanan"
	
	var input_direction = Input.get_axis("left", "right")
	velocity.x = 0
	
	if Input.is_action_pressed('right'):
		animation = "jalan_kanan"
		velocity.x += speed
	if Input.is_action_pressed('left'):
		animation = "jalan_kiri"
		velocity.x -= speed
	if Input.is_action_just_pressed("jump") && double_jump > 0:
		animation = "lompat"
		velocity.y = -jump
		double_jump -= 1
	
	if Input.is_action_pressed("slide"):
		curr_speed -= velocity.normalized().x * 20
		
	if !Input.is_action_pressed("slide"):
		curr_speed =  input_direction * speed
	if Input.is_action_just_pressed("slide") && dash_amount > 0:
		curr_speed += input_direction * speed * 2
		dash_amount -= 1
		
	if !Input.is_action_just_pressed("slide"):
		if !is_on_floor():
			if(input_direction != 0):
				curr_speed += input_direction * speed * 0.5
				curr_speed = min(curr_speed, speed)
				curr_speed = max(curr_speed, speed)
			else:
				curr_speed -= velocity.normalized().x * 10
		else:
			if !sliding:
				curr_speed = input_direction * speed
	
	curr_speed = min(curr_speed, max_speed)
	curr_speed = max(curr_speed, -max_speed)
	
	if is_on_floor():
		double_jump = 1
		
	if $AnimatedSprite.animation != animation:
		$AnimatedSprite.play(animation)

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)

func dash(dash_force):
	print("dash")
	if(curr_speed != 0):
		curr_speed += (curr_speed / abs(curr_speed)) * dash_force
		
