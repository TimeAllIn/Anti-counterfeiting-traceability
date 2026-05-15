class_name u_b extends Button

@export var my_name:String

@export var code:Code

@export var 描述:String

@export var 内容:Dictionary

@export var 哈希值:String

func _init(g_name:String) -> void:
	var temp_code = Code.new()
	temp_code.生成(g_name)
	code = temp_code
	哈希值 = code.哈希值返回()
	pass

func _ready() -> void:
	pressed.connect(按钮按下)
	text = my_name

func 按钮按下():
	get_parent().打开(self)
	pass

func 改变名字(new_name):
	my_name = new_name
	text = my_name
