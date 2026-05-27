class_name Code extends Resource
var img_width:int
var img_height:int
var img:Image
var black_num:int

#var 紫色测试色:Color = Color.PURPLE
#var 红色测试色:Color = Color.RED
#var 黄色测试色:Color = Color.YELLOW
#var 绿色测试色:Color = Color.GREEN

var 紫色测试色:Color = Color.BLACK
var 红色测试色:Color = Color.BLACK
var 黄色测试色:Color = Color.BLACK
var 绿色测试色:Color = Color.BLACK

func _init(width:int = 22,height:int = 22) -> void:
	#设定码的宽度，默认22像素
	img_width = width
	#设定码的高度，默认22像素
	img_height = height
	
	#创立初始图像
	img = Image.create_empty(img_width, img_height, false, Image.FORMAT_RGBA8)
	#全部涂白
	for x in range(img_height):
		for y in  range(img_width):
			img.set_pixel(x, y, Color.WHITE)
			
	#标准化
	#stander()
	#紫色数据生成()
	#var tt:String
	#for i in 5:
		#var a = randi_range(10000,99999)
		#tt += str(a)
	#绿色数据生成(tt)
	#黄色区生成()
	#红色数据生成()
	#红色区生成()
	#防伪区生成()

func 生成(公司名称:String):
	stander()

	紫色数据生成(str(公司名称.hash()),str(Time.get_date_string_from_system.hash()))
	var tt:String
	for i in 5:
		var a = randi_range(10000,99999)
		tt += str(a)
	绿色数据生成(tt)
	黄色区生成()
	红色数据生成()
	红色区生成()
	防伪区生成()
	print(紫色原数据)
	print(绿色原数据)
	print(黄色原数据)


func 哈希值返回():
	return (紫色原数据 + 绿色原数据).md5_text()

#字符串转换二位制
func _string_to_bit(s_t:String) -> String:
	if s_t.length() > 25:
		print("警告：" +s_t + "超过最大限制")
	var add_data:Array[String]
	for i in s_t:
		match i:
			"0":
				add_data.append("0000")
			"1":
				add_data.append("0001")
			"2":
				add_data.append("0010")
			"3":
				add_data.append("0011")
			"4":
				add_data.append("0100")
			"5":
				add_data.append("0101")
			"6":
				add_data.append("0110")
			"7":
				add_data.append("0111")
			"8":
				add_data.append("1000")
			"9":
				add_data.append("1001")
			":":
				add_data.append("1010")
			".":
				add_data.append("1011")
			"a":
				add_data.append("1100")
	var temp:String
	for data in add_data:
		temp += data
	return temp
func creat_path(path:String = OS.get_user_data_dir()):
	img.save_png(path)	
func stander():
	var draw_color = Color.BLACK
	#左上角
	img.set_pixel(0, 0, draw_color)
	img.set_pixel(0, 1, draw_color)
	img.set_pixel(1, 0, draw_color)
	#左下角
	img.set_pixel(0, img_height-2, draw_color)
	img.set_pixel(1, img_height-1, draw_color)
	#右上角
	img.set_pixel(img_width - 1, 0, draw_color)
	#右下角
	img.set_pixel(img_width - 1, img_height-2, draw_color)
	img.set_pixel(img_width - 2, img_height-1, draw_color)
	img.set_pixel(img_width - 1, img_height-1, draw_color)
	black_num += 9
var 紫色原数据:String
var 紫色生成数据:String
func 紫色数据生成(ip:String = "192.168.1.1",port:String = "25565"):
	紫色原数据 = ip + ":" + port
	if 紫色原数据.length() <	25:
		紫色原数据 += "a"
		var 增添值 = 25 - 紫色原数据.length()
		for i in 增添值:
			紫色原数据 += str(randi_range(0,9))
	紫色生成数据 =  _string_to_bit(紫色原数据)
func 紫色区生成():
	var num:int = 0
	for y in 10:
		for x in 10:
			
			if num < 紫色生成数据.length():
				if 紫色生成数据[num] == "1":
					img.set_pixel(1 + x, 1 + y, 紫色测试色)
			else:
				img.set_pixel(1 + x, 1 + y, Color.BLUE_VIOLET)
			num += 1
	pass
var 绿色原数据:String
var 绿色生成数据:String
func 绿色数据生成(code_img:String = "0"):
	绿色原数据 = code_img
	if 绿色原数据.length() <	25:
		绿色原数据 += "a"
		var 增添值 = 25 - 绿色原数据.length()
		for i in 增添值:
			绿色原数据 += str(randi_range(0,9))
	绿色生成数据 =  _string_to_bit(绿色原数据)
func 绿色区生成():
	var num:int = 0
	for y in 10:
		for x in 10:
			if 绿色生成数据[num] == "1":
				img.set_pixel(11 +  x, 11 +  y, 绿色测试色)
			num += 1
	pass
var 黄色原数据:String
var 黄色生成数据:String
func 黄色区生成(掩码方式:int = 0):
#region 15位日期生成
	# 获取本地时间的字典
	var time_dict = Time.get_datetime_dict_from_system()
	var 时间戳:String = str(time_dict.year) + "."
	if time_dict.month < 10:
		时间戳 += "0" + str(time_dict.month) + "."
	else:
		时间戳 += str(time_dict.month) + "."
	if time_dict.day < 10:
		时间戳 += "0" + str(time_dict.day) + "."
	else:
		时间戳 += str(time_dict.day) + "."
	if time_dict.hour < 10:
		时间戳 += "0" + str(time_dict.hour) + "."
	else:
		时间戳 += str(time_dict.hour) + "."
	if time_dict.minute < 10:
		时间戳 += "0" + str(time_dict.minute) + "."
	else:
		时间戳 += str(time_dict.minute) + "."
	if time_dict.second < 10:
		时间戳 += "0" + str(time_dict.second)
	else:
		时间戳 += str(time_dict.second)
#endregion
	var 掩码:String
	##开始掩码
	match 掩码方式:
		0:
			var 掩码偏移:int = randi_range(1,9)
			var 多余偏移:int = randi_range(10,99)
			掩码 = ":0" + str(掩码偏移)+str(多余偏移)+ ":"
			
			var 临时紫色:String
			print("紫色原数据:" + 紫色原数据)
			for i in 紫色原数据:
				if i.is_valid_int():
					var 临时数字 = i.to_int() + 掩码偏移
					if 临时数字 >= 10 :
						临时数字 -= 10
					临时紫色 += str(临时数字)
					pass
				else:
					临时紫色 += i
			print("紫色修正数据：",临时紫色)
			紫色生成数据 =  _string_to_bit(临时紫色)
			紫色区生成()
			
			var 临时绿色:String
			print("绿色原数据:" + 绿色原数据)
			for i in 绿色原数据:
				if i.is_valid_int():
					var 临时数字 = i.to_int() + 掩码偏移
					if 临时数字 >= 10 :
						临时数字 -= 10
					临时绿色 += str(临时数字)
					pass
				else:
					临时绿色 += i
			print("绿色修正数据：",临时绿色)
			绿色生成数据 =  _string_to_bit(临时绿色)
			绿色区生成()
			
			pass
	var 掩码定位 = randi_range(1,21)
	时间戳 = 时间戳.insert(掩码定位,掩码)
	黄色原数据 = 时间戳
	print("黄色原数据:" + 黄色原数据)
	黄色生成数据 = _string_to_bit(黄色原数据)
	print("黄色生成数据:" + 黄色生成数据)
	var num:int = 0
	for y in 10:
		for x in 10:
			if 黄色生成数据[num] == "1":
				img.set_pixel(1 + x, 11 + y, 黄色测试色)
			num += 1
	pass
var 红色生成数据:String
func 红色数据生成():
	for i in 100:
		if 紫色生成数据[i] == 绿色生成数据[i]:
			红色生成数据 += "1"
		else:
			红色生成数据 += "0"
	pass
func 红色区生成():
	var num:int = 0
	for y in 10:
		for x in 10:
			if num < 红色生成数据.length():
				if 红色生成数据[num] == "1":
					img.set_pixel(11 + x, 1 + y, 红色测试色)
			num += 1
	pass


func 侧边防伪码生成(原始数据):
	var data  = []
	#紫色区域
	var num:int = 0
	for y in 10:
		data.append([])
		for x in 10:
			data[y].append(原始数据[num])
			num += 1 
	var out_data = {}
	out_data[0] = []
	out_data[1] = []
	for i in 10:
		num = 0
		for i_d in data[i]:
			num += int(i_d)
		out_data[0].append(num % 2)
	for x in 10:
		num = 0
		for y in 10:
			num += int(data[x][y])
		out_data[1].append(num % 2)
	
	return out_data

func 防伪区生成():
	var 紫色侧边防伪码 = 侧边防伪码生成(紫色生成数据)
	var 绿色侧边防伪码 = 侧边防伪码生成(紫色生成数据)
	var 黄色侧边防伪码 = 侧边防伪码生成(黄色生成数据)
	var 红色侧边防伪码 = 侧边防伪码生成(红色生成数据)
	
	#紫色:
	for i in 10:
			if 紫色侧边防伪码[0][i] == 1 and i != 0:
				img.set_pixel(0, 1 + i, Color.BLACK)
			if 紫色侧边防伪码[1][i] == 1 and i != 0:
				img.set_pixel(1 + i, 0, Color.BLACK)
			
			if 红色侧边防伪码[0][i] == 1 and i != 0:
				img.set_pixel(21, 1 + i, Color.BLACK)
			if 红色侧边防伪码[1][i] == 1 and i != 9:
				img.set_pixel(11 + i, 0, Color.BLACK)
			
			if 黄色侧边防伪码[0][i] == 1 and i != 9:
				img.set_pixel(0, 11 + i, Color.BLACK)
			if 黄色侧边防伪码[1][i] == 1 and i != 0:
				img.set_pixel(1 + i, 21, Color.BLACK)
			
			if 绿色侧边防伪码[0][i] == 1 and i != 9:
				img.set_pixel(21, 11 + i, Color.BLACK)
			if 绿色侧边防伪码[1][i] == 1 and i != 9:
				img.set_pixel(11 + i, 21, Color.BLACK)
	pass
