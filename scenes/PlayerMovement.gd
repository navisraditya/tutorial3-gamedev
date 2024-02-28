extends KinematicBody2D

export (int) var speed = 400
const GRAVITY = 1200

const UP = Vector2(0, -1)
const jump = 250
var double_jump = 2
var velocity = Vector2()

func get_input():
	velocity.x = 0
	if Input.is_action_pressed('right'):
		velocity.x += speed
	if Input.is_action_pressed('left'):
		velocity.x -= speed
	if Input.is_action_just_pressed("jump") && double_jump > 0:
		velocity.y = -jump
		double_jump -= 1
	if is_on_floor():
		double_jump = 1

		

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
