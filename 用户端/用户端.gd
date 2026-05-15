extends Control

func set_value(temp):
	$"描述".text = temp[0]
	$"产品名称".text = temp[1]
	$"生产编号".text = temp[2]
	$"生产日期".text = temp[3]
	
	var temp_code = Code.new()
	temp_code.生成(temp[4])
	$"码点图".texture = ImageTexture.create_from_image(temp_code.img)
	
