extends Node

@export var test:String

#在程序唤醒的第一帧运行，且只运行一次
func _ready() -> void:
	Net.create_net()
	#match  testa:
		#0:
			#Net.create_net()
		#1:
			#Net.conect_net()
	#var code = Code.new()
	##code.creat_path("aa")
	#$TextureRect.texture = ImageTexture.create_from_image(code.img)
#	

	#var recode = ReCode.new()
	#recode.解密(code.img)

	pass
