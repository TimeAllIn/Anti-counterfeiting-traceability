class_name Net_gd extends Node

#创建服务器
func create_net(port:int = 2233):
	var peer = ENetMultiplayerPeer.new()
	if peer.create_server(port) == OK:
		self.multiplayer.multiplayer_peer =  peer
		print("成功创建服务器")
		print(self.multiplayer.get_unique_id())
	数据 = load_from_json("user://save_data.json")
#客户端连接
func conect_net(ip:String="127.0.0.1",port:int = 2233):
	var peer = ENetMultiplayerPeer.new()
	if peer.create_client(ip,port) == OK:
		self.multiplayer.multiplayer_peer =  peer
		print("成功连接服务器")
		print(self.multiplayer.get_unique_id())
	await get_tree().create_timer(0.5).timeout
	数据传输()

#var 数据:Dictionary = {"防伪码Test":{}}
var 数据
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
			save_to_json(数据, "user://save_data.json")
			return
		数据[公司名称] = value
		save_to_json(数据, "user://save_data.json")
		emit_signal("客户端信息发送")
	pass
	
@rpc("any_peer","call_remote")
func 查询(id):
	查询数据接收.rpc_id(id,数据["防伪码Test"])
	pass

signal 返回

@rpc("any_peer","call_remote")
func 查询数据接收(temp):
	数据 = temp
	emit_signal("返回")
	pass

func 数据传输():
	data_conect.rpc_id(1,self.multiplayer.get_unique_id())
	pass

func 数据上传(公司名称:String,value):
	下级_load.rpc_id(1,公司名称,value)
	pass


func 用户查询():
	查询.rpc_id(1,self.multiplayer.get_unique_id())
	pass


# 保存字典为JSON
func save_to_json(data: Dictionary, path: String) -> bool:
	# 1. 将字典转换为 JSON 字符串
	var json_string = JSON.stringify(data, "\t")  # 第二个参数为缩进格式（可选）
	
	# 2. 打开文件（写入模式）
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		print("错误：无法打开文件进行写入 - ", path)
		return false
	
	# 3. 写入字符串
	file.store_string(json_string)
	file.close()
	return true


## 从 JSON 文件读取并转换为字典
## @param path: 文件路径
## @return: 成功返回 Dictionary，失败返回空字典（可自行修改为返回 null 并检查错误）
func load_from_json(path: String) -> Dictionary:
	# 1. 检查文件是否存在
	if not FileAccess.file_exists(path):
		print("错误：文件不存在 - ", path)
		return {"防伪码Test":{}}
	
	# 2. 打开文件（读取模式）
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		print("错误：无法打开文件进行读取 - ", path)
		return {"防伪码Test":{}}
	
	# 3. 读取全部文本
	var content = file.get_as_text()
	file.close()
	
	# 4. 解析 JSON
	var result = JSON.parse_string(content)
	
	# 5. 检查解析结果是否为字典（也可允许数组，根据需求调整）
	if typeof(result) != TYPE_DICTIONARY:
		print("错误：JSON 内容不是合法的字典格式 - ", path)
		return {"防伪码Test":{}}
	
	return result
