# introduction of concept

you will notice that in every video game almost all progression bars are straight lines, this includes health bars, stamina bar, mana bars, loading bars. so on..

i wasn't satisfied with this, if i wanted a bar that fit the shape of a cubic equation, i wanted to be able to get that bar and use it easily in a short time.

make the following observation about how roblox studio's frames work

here is an empty frame:

<img width="300" height="300" alt="emptyFrame" src="https://github.com/user-attachments/assets/581da3dd-ea1a-4602-95c1-ac6dfa60df7d" />

roblox studio allows you to add frames at any position, size, and rotation. allowing for such

<img width="300" height="300" alt="FrameWithSingleFrame" src="https://github.com/user-attachments/assets/5455c8cb-8ede-4440-af4d-7ba97b90a768" />

but of course, you can have multiple and put them all together to form some sort of image

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/024dd1a2-9bd6-4bc9-add2-30e713b3220e" />

suppose this cubic equation represented a health bar, if the player then took damage you could represent it by taking the last frames at the right end of the cubic
and making them invisible

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/0f2fde09-5925-40dc-9e3a-5fde7d8ccece" />

doing this with enough frames accurately placed would allow for a smooth health bar in the shape of a cubic

so the goal here is, given an equation. make a bar that can have it's value (value being health in the example above) easily.

# using the module 

when using the module to make a cubic health bar the result is:

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/9c56b496-4640-4e54-a4b2-b9c5c68ef94a" />

and when you set this to a 25% value (think of this as 25% health if this were a health bar) you get:

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/790f5091-58cd-489a-a8d5-e2eb9cf42911" />

and all i had to write was the following
```lua
local equationBarMod=require(game.ReplicatedStorage.Modules.equationBarModule)

local frameForBar=script.Parent.Frame
--frame is black
local function equationBarFunction(i)
	--works by parametric equations
	return {
		0.5+((i-0.5)*0.8), --x coordinate
		0.5-(1.5*(i-0.5))^3 --y coordinate
	}
	--note that the center of the frame is (0.5,0.5)
end

local barVal=equationBarMod.initEquationBar(
	frameForBar,
	0.1, --thickness
	Color3.new(1,1,1), --white
	100, --accuracy (number of frames used)
	equationBarFunction, --function used to define the cubic
	1 --initial value of bar
)
```
which took no more than a few minutes to figure out the function at the top.

to understand what's going on with that function lets take a simpler example

```lua
local function equationBarFunction(i)
	--works by parametric equations
	return {
		i, --x coordinate
		i^3 --y coordinate
	}
	--note that the center of the frame is (0.5,0.5)
end	
```

this function is meant to define the shape of the line drawn
the function is called with a single parameter (being i) being a value between 0 and 1 inclusive
0 represents when the bar is at value 0 (empty)
1 represents when the bar is at value 1 (full)
0.5 represents when the bar is at value 0.5 (half full)

and it's more or less continuous values depending on the accuracy level you set

the expected return is a table with 2 elements, an x and y coordinate. cororrsponding to a point representing the value

for the function above, when the module is getting the coordinate of the point that is AT value 1. it will call the function with parameter 1 and use the return
this allows you to effectively define any line, even a sine way or spiral.

the module will connect each point for you to form a smooth bar.

to give an example of this, here is an image of what the full bar looks like for the function above

notes about roblox studio gui if your unfamiliar (skip if your familiar):
```
this uses scaling which means that
an x coordinate of 0 is all the way on the left, of 1 is all the way on the right,
same applies to the y coordinate. 

y coordinates go from top to bottom instead, 0 on the y is the top, 1 on the y is the bottom
```
end of notes

(using less thick line so shape is easier to see)

<img width="688" height="679" alt="image" src="https://github.com/user-attachments/assets/023948b0-c237-4dac-bed1-18fbcd5c1ec8" />


you can see it doesn't resemble a cubic

(function again for reference)

```lua
local function equationBarFunction(i)
	--works by parametric equations
	return {
		i, --x coordinate
		i^3 --y coordinate
	}
	--note that the center of the frame is (0.5,0.5)
end	
```

when getting the coordinate of the 0 value point, you'd want it to be something around (0,1) which is the bottom right,
but the function returns (0,0) which is the top left
it's also not going to take any negative values of the cubic as the perameter passed in will always be from 0 to 1
so the whole left side of the cubic is ignored

so this shape is the right side of a cubic flipped upside down (cuz y is flipped)

for now we will ignore this as it can be flipped easily at the end

to show the left side of the cubic we want the cubic to be shifted 0.5 to the right
which can be done by making the following change

```lua
local function equationBarFunction(i)
	--works by parametric equations
	return {
		i, --x coordinate
		(i-0.5)^3 --y coordinate
	}
	--note that the center of the frame is (0.5,0.5)
end	
```

this gives

<img width="661" height="692" alt="image" src="https://github.com/user-attachments/assets/05b095ac-7207-4ae1-8388-c776adf315df" />

which now shows the left side of the cubic but is very high up, from here we can shift all y coordinates down by 0.5 (half way down the frame) 
so what would usually be at the origin of a cubic is at the center of the frame

```lua
local function equationBarFunction(i)
	--works by parametric equations
	return {
		i, --x coordinate
		0.5+(i-0.5)^3 --y coordinate
	}
	--note that the center of the frame is (0.5,0.5)
end	
```

which gives

<img width="680" height="661" alt="image" src="https://github.com/user-attachments/assets/c1ae6195-3e2a-4bb1-876c-dbdd5ca8b520" />

which is much closer to the desired result


