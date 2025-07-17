  local module = {}
--use these functions if you want
function module.getPointCircle(i)
	local r=0.5
	local x=(2*i)-r
	local takePositive=false
	if 2*i>1 then
		takePositive=true
		x=1-x
	end
	local y=math.sqrt((r^2)-(x^2))
	if takePositive==false then
		y*=-1
	end
	return {x+0.5,y+0.5}
end
function module.getPointCurvedBar(i)
	local r=0.5 --constant
	local circlePercent=0.4
	local takePositive=false
	local x=((1-circlePercent)+(2*i*circlePercent))/2
	if (i*2)>1 then
		takePositive=true
		x=(2*r)-x
	end
	local y=math.sqrt((r^2)-(x^2))
	if takePositive==false then
		y*=-1
	end
	return {x+0.4,y+0.5}
end
function module.getPointCurvedBar2(i)
	local r=0.3
	local lowerAngle=0 --bounded by 0 to 360
	local upperAngle=360 --boudned by 0 to 360 but has to be greater than lowerAngle
	local lowToUp=upperAngle-lowerAngle
	local curAngle=lowerAngle+(i*lowToUp)
	local gradient=math.tan(math.rad(curAngle))
	local x=math.sqrt((r^2)/(1+(gradient^2)))
	local y=x*gradient
	if curAngle%360>90 and curAngle%360<270 then
		x*=-1
	end
	if curAngle%360>0 and curAngle%360<180 then
		if y>0 then
			y*=-1
		end
	else
		if y<0 then
			y*=-1
		end
	end
	return {x+0.5,y+0.5}
end
function module.getPointSpiral(i)
	local r=0.5*i
	local lowerAngle=0 --bounded by 0 to 360
	local upperAngle=3000 --boudned by 0 to 360 but has to be greater than lowerAngle
	local lowToUp=upperAngle-lowerAngle
	local curAngle=lowerAngle+(i*lowToUp)
	local gradient=math.tan(math.rad(curAngle))
	local x=math.sqrt((r^2)/(1+(gradient^2)))
	local y=x*gradient
	if curAngle%360>90 and curAngle%360<270 then
		x*=-1
	end
	if curAngle%360>0 and curAngle%360<180 then
		if y>0 then
			y*=-1
		end
	else
		if y<0 then
			y*=-1
		end
	end
	return {x+0.5,y+0.5}
end
function module.getPointSpiralDouble(i)
	local r=0.5*(0.5-i)
	local lowerAngle=-180 --bounded by 0 to 360
	local upperAngle=-180+(360*2) --boudned by 0 to 360 but has to be greater than lowerAngle
	local lowToUp=upperAngle-lowerAngle
	local curAngle=lowerAngle+(i*lowToUp)
	if i>=0.5 then
		curAngle+=180
	end
	local gradient=math.tan(math.rad(curAngle))
	local x=math.sqrt((r^2)/(1+(gradient^2)))
	local y=x*gradient
	print(i)
	print(curAngle)
	if curAngle%360>90 and curAngle%360<270 then
		x*=-1
	end
	if curAngle%360>0 and curAngle%360<180 then
		if y>0 then
			y*=-1
		end
	else
		if y<0 then
			y*=-1
		end
	end
	return {x+0.5,y+0.5}
end
function module.initEquationBar(frameForBar,width,color,accuracy,equationOfPoint,initVal)
	local barSectionFrame=Instance.new("Frame")
	local barVal=Instance.new("NumberValue")
	barVal.Name="barPercent"
	barVal.Value=initVal
	barVal.Parent=frameForBar
	barSectionFrame.BackgroundColor3=color
	barSectionFrame.Size=UDim2.fromScale(0,width)
	barSectionFrame.AnchorPoint=Vector2.new(0.5,0.5)
	barSectionFrame.BorderSizePixel=0
	local curBarSections={}
	local numOfBars=accuracy
	local currentIndex=numOfBars
	for barNum=1,numOfBars do
		local curPos=equationOfPoint(barNum/accuracy)
		local nextPos=equationOfPoint((barNum+1)/accuracy)
		local curX=curPos[1]
		local curY=curPos[2]
		local nextX=nextPos[1]
		local nextY=nextPos[2]
		local angle=math.deg(math.atan((nextY-curY)/(nextX-curX)))
		local mag=((((curX-nextX)^2)+((curY-nextY)^2))^(1/2))+0.01 --for safety
		local curBar=barSectionFrame:Clone()
		curBar.Parent=frameForBar
		curBar.Position=UDim2.fromScale(curX,curY)
		curBar.Rotation=angle
		curBar.Size=UDim2.fromScale(mag,width)
		table.insert(curBarSections,curBar)
	end
	local function refreshBar()
		local barNum=1+(accuracy*barVal.Value)//1
		local visible=barNum>currentIndex
		for i=math.max(math.min(barNum,currentIndex),1),math.min(math.max(barNum,currentIndex),numOfBars) do
			curBarSections[i].Visible=visible
		end
		currentIndex=barNum
	end
	refreshBar()
	barVal.Changed:Connect(function()
		refreshBar()
	end)
	return barVal
end
return module
