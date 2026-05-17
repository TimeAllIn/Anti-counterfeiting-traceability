class_name Net_gd extends Node

#创建服务器
func create_net(port:int = 2233):
	var peer = ENetMultiplayerPeer.new()
	if peer.create_server(port) == OK:
		self.multiplayer.multiplayer_peer =  peer
		print("成功创建服务器")
		print(self.multiplayer.get_unique_id())
		数据 = load_json_to_dict("user://server_data.json")
	
#客户端连接
func conect_net(ip:String="127.0.0.1",port:int = 2233):
	var peer = ENetMultiplayerPeer.new()
	if peer.create_client(ip,port) == OK:
		self.multiplayer.multiplayer_peer =  peer
		print("成功连接服务器")
		print(self.multiplayer.get_unique_id())
	await get_tree().create_timer(0.5).timeout
	数据传输()

var 数据:Dictionary = {"防伪码Test":{}}
#var 数据
#文件传输
@rpc("any_peer","call_remote")
func data_conect(temp_id):
	print("该信息由该ID发送：",str(self.multiplayer.get_unique_id()))
	print("该信息由该ID发送至：",str(temp_id))
	data_load.rpc_id(temp_id,数据)
	
	pass

@rpc("any_peer","call_remote")
func data_load(temp):
	print("接受至：",str(self.multiplayer.get_unique_id()))
	数据 = temp
	pass

signal 客户端信息发送

@rpc("any_peer","call_remote")
func 下级_load(公司名称:String,value):
	if 数据.get(公司名称) != null:
		if 公司名称 == "防伪码Test":
			数据["防伪码Test"][value.哈希值] = value.内容
			return
		数据[公司名称] = value
		emit_signal("客户端信息发送")
		save_dict_to_json("user://server_data.json",数据)
	pass
	
@rpc("any_peer","call_remote")
func 查询(id,md5):
	if 数据["防伪码Test"].get(md5) != null:
		查询数据接收.rpc_id(id,数据["防伪码Test"][md5])
	else:
		查询数据接收.rpc_id(id,null)
	
	pass
@rpc("any_peer","call_remote")
func 查询数据接收(temp):
	数据 = temp
	pass

func 数据传输():
	data_conect.rpc_id(1,self.multiplayer.get_unique_id())
	pass

func 数据上传(公司名称:String,value):
	下级_load.rpc_id(1,公司名称,value)
	pass

func save_dict_to_json(path: String, data: Dictionary) -> void:
	# 转换为格式化 JSON
	var json_str = JSON.stringify(data, "\t")
	# 写入文件
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(json_str)
		file.close()
		print("保存成功: " + path)
	else:
		print("保存失败")
		
func load_json_to_dict(path: String) -> Dictionary:
	if not FileAccess.file_exists(path):
		return {}
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var json_str = file.get_as_text()
		file.close()
		# 解析 JSON
		var result = JSON.parse_string(json_str)
		if result is Dictionary:
			return result
		else:
			print("JSON 不是字典")
			return {"防伪码Test":{}}
	else:
		print("读取失败")
		return {"防伪码Test":{}}


func 用户查询(md5:String):
	查询.rpc_id(1,self.multiplayer.get_unique_id(),md5)
	pass
