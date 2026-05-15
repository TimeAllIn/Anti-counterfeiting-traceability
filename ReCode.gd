class_name ReCode extends Resource

var data = {}

var 紫色数据:String
var 红色数据:String
var 黄色数据:String
var 绿色数据:String

#字符串转换二位制
func _bit_to_string(s_t:String) -> String:
	var return_str:String
	
	for all in 25:
		var text_string:String
		for num in 4:
			text_string += s_t[all * 4 + num]
		match text_string:
			"0000":
				return_str += "0"
			"0001":
				return_str += "1"
			"0010":
				return_str += "2"
			"0011":
				return_str += "3"
			"0100":
				return_str += "4"
			"0101":
				return_str += "5"
			"0110":
				return_str += "6"
			"0111":
				return_str += "7"
			"1000":
				return_str += "8"
			"1001":
				return_str += "9"
			"1010":
				return_str += ":"
			"1011":
				return_str += "."
			"1100":
				return_str += "a"
	return return_str

func 解密(img:Image):
	var timg = 旋转(img)
	解码(timg)

	解决污损()
	if 防伪区防伪(img) == false:
		print("防伪检测失败")
		return
	解掩码()
	掩码解密()
	哈希值()
	pass

var 自身哈希:String = ""

func 哈希值():
	自身哈希 = (紫色数据 + 绿色数据).md5_text()
	print(自身哈希)
	

func 旋转(img:Image):
	var return_img:Image = img
	while return_img.get_pixel(0,0) != Color.BLACK or return_img.get_pixel(0,21) != Color.WHITE:
		print("旋转")
		return_img.rotate_90(0)
	return return_img
	pass

func 解码(img:Image):
	for y in 10:
		for x in 10:
			
			match img.get_pixel(1 + x,1 + y):
				Color.WHITE:
					紫色数据 += "0"
				Color.BLACK:
					紫色数据 += "1"
				_:
					紫色数据 += "2"
			
			match img.get_pixel(11 + x,1 + y):
				Color.WHITE:
					红色数据 += "0"
				Color.BLACK:
					红色数据 += "1"
				_:
					红色数据 += "2"

			match img.get_pixel(1 + x,11 + y):
				Color.WHITE:
					黄色数据 += "0"
				Color.BLACK:
					黄色数据 += "1"
				_:
					黄色数据 += "2"

			match img.get_pixel(11 + x,11 + y):
				Color.WHITE:
					绿色数据 += "0"
				Color.BLACK:
					绿色数据 += "1"
				_:
					绿色数据 += "2"
				
	
	print("紫色1解码数据" + str(紫色数据))
	print("红色1解码数据" + str(红色数据))
	print("黄色1解码数据" + str(黄色数据))
	print("绿色1解码数据" + str(绿色数据))

func 解决污损():

	for i in 100:

		# =================================================
		# 紫色损坏
		# =================================================
		if 紫色数据[i] == "2":

			# 红色正常
			if 红色数据[i] != "2":

				# 绿色正常
				if 绿色数据[i] != "2":

					match 绿色数据[i]:

						# 紫色与红色相反
						"0":
							if 红色数据[i] == "1":
								紫色数据[i] = "0"
							else:
								紫色数据[i] = "1"

						# 紫色与红色相同
						"1":
							紫色数据[i] = 红色数据[i]

				# 绿色损坏
				else:

					# 无法判断规则
					# 默认复制红色
					紫色数据[i] = 红色数据[i]

			# 红色也损坏
			else:

				# 绿色正常
				if 绿色数据[i] != "2":

					var rand_bit = str(randi_range(0, 1))
					紫色数据[i] = rand_bit

					match 绿色数据[i]:

						# 红色与紫色相反
						"0":
							if rand_bit == "1":
								红色数据[i] = "0"
							else:
								红色数据[i] = "1"

						# 红色与紫色相同
						"1":
							红色数据[i] = rand_bit

				# 三个全坏
				else:

					var rand_bit = str(randi_range(0, 1))

					紫色数据[i] = rand_bit
					红色数据[i] = rand_bit
					绿色数据[i] = str(randi_range(0, 1))

		# =================================================
		# 红色损坏
		# =================================================
		elif 红色数据[i] == "2":

			# 绿色正常
			if 绿色数据[i] != "2":

				match 绿色数据[i]:

					# 红色与紫色相反
					"0":
						if 紫色数据[i] == "1":
							红色数据[i] = "0"
						else:
							红色数据[i] = "1"

					# 红色与紫色相同
					"1":
						红色数据[i] = 紫色数据[i]

			# 绿色损坏
			else:

				# 默认复制
				红色数据[i] = 紫色数据[i]

		# =================================================
		# 绿色损坏
		# =================================================
		elif 绿色数据[i] == "2":

			# 根据紫红关系恢复绿色

			if 紫色数据[i] == 红色数据[i]:
				绿色数据[i] = "1"
			else:
				绿色数据[i] = "0"

		# =================================================
		# 全正常时校验一致性
		# =================================================
		else:

			match 绿色数据[i]:

				# 应该相反
				"0":

					if 紫色数据[i] == 红色数据[i]:

						# 冲突时修正紫色
						if 红色数据[i] == "1":
							紫色数据[i] = "0"
						else:
							紫色数据[i] = "1"

				# 应该相同
				"1":

					if 紫色数据[i] != 红色数据[i]:

						# 冲突时修正紫色
						紫色数据[i] = 红色数据[i]
	print("紫色2解码数据" + str(紫色数据))
	print("红色2解码数据" + str(红色数据))
	print("黄色2解码数据" + str(黄色数据))
	print("绿色2解码数据" + str(绿色数据))
	pass
func 解掩码():
	var 掩码解密:String
	# 紫色
	紫色数据 = _bit_to_string(紫色数据)
	print("紫色解码数据" + str(紫色数据))
	# 红色
	红色数据 = _bit_to_string(红色数据)
	print("红色解码数据" + str(红色数据))
	# 黄色
	黄色数据 = _bit_to_string(黄色数据)
	print("黄色解码数据" + str(黄色数据))
	# 绿色
	绿色数据 = _bit_to_string(绿色数据)
	print("绿色解码数据" + str(绿色数据))
	
	

	pass

func 掩码解密():
	var parts = 黄色数据.split(":")
	print(parts)
	
	match parts[1][0]:
		"0":
			var 临时数据:String
			for i in 紫色数据:
				if i.is_valid_int():
					var 临时数字 = i.to_int() - int(parts[1][1])
					if 临时数字 < 0 :
						临时数字 += 10
					临时数据 += str(临时数字)
					pass
				else:
					临时数据 += i
			紫色数据 = 临时数据
			
			临时数据 = ""
			for i in 绿色数据:
				if i.is_valid_int():
					var 临时数字 = i.to_int() - int(parts[1][1])
					if 临时数字 < 0 :
						临时数字 += 10
					临时数据 += str(临时数字)
					pass
				else:
					临时数据 += i
			绿色数据 = 临时数据
	
	print("修正后紫色数据" + 紫色数据)
	print("修正后绿色数据" + 绿色数据)
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

func 防伪区防伪(img:Image):
	var 紫色侧边防伪码 = 侧边防伪码生成(紫色数据)
	var 绿色侧边防伪码 = 侧边防伪码生成(紫色数据)
	var 黄色侧边防伪码 = 侧边防伪码生成(黄色数据)
	var 红色侧边防伪码 = 侧边防伪码生成(红色数据)
	
	#紫色:
	for i in 10:
		if 紫色侧边防伪码[0][i] == 0 and i != 0:
			if img.get_pixel(0, 1 + i) != Color.WHITE:
				return false
		if 紫色侧边防伪码[1][i] == 0 and i != 0:
			if img.get_pixel(1 + i, 0) != Color.WHITE:
				return false
		if 红色侧边防伪码[0][i] == 0 and i != 0:
			if img.get_pixel(21, 1 + i) != Color.WHITE:
				return false
		if 红色侧边防伪码[1][i] == 0 and i != 9:
			if img.get_pixel(11 + i, 0) != Color.WHITE:
				return false
		if 黄色侧边防伪码[0][i] == 0 and i != 9:
			if img.get_pixel(0, 11 + i) != Color.WHITE:
				return false
		if 黄色侧边防伪码[1][i] == 0 and i != 0:
			if img.get_pixel(1 + i, 21) != Color.WHITE:
				return false
		if 绿色侧边防伪码[0][i] == 0 and i != 9:
			if img.get_pixel(21, 11 + i) != Color.WHITE:
				return false
		if 绿色侧边防伪码[1][i] == 0 and i != 9:
			if img.get_pixel(11 + i, 21) != Color.WHITE:
				return false
	return true
	pass
