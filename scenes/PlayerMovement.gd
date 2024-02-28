extends KinematicBody2D

export (int) var speed = 400
const GRAVITY = 10

const UP = Vector2(0, -1)
const jump = 250
var velocity = Vector2()

func get_input():
	velocity.x = 0
	if Input.is_action_pressed('right'):
		velocity.x += speed
	if Input.is_action_pressed('left'):
		velocity.x -= speed
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump

func _physics_process(delta):
	velocity.y += GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
