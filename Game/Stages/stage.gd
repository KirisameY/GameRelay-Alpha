class_name Stage
extends Node

@export
var Homes: Array[Home]

@export
var WavesEnd:bool = false

@export var MaxLife:int = 3
@onready var Life := MaxLife

var Enemies: Array[Node]
func add_enemy(enemy: Node):
	Enemies.append(enemy)
	enemy.tree_exiting.connect(func(): remove_enemy(enemy), ConnectFlags.CONNECT_ONE_SHOT)

func remove_enemy(enemy: Node):
	Enemies.erase(enemy)
	if Enemies.size() == 0:
		stage_win.emit(MaxLife, Life)

func  _ready():
	for home in Homes:
		home.enemy_entered.connect(func(_enemy):
			Life -= 1
			if Life<=0: stage_lose.emit()
		)


signal stage_win(max_life:int, final_life:int)
signal stage_lose()
