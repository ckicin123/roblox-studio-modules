local module={}

function module.startFootShadow(footPart,toFilterOut)
	
	--footPart should be a foot of a character
	--toFilterOut should be a table of objects to filter out
	
	local footPartFolder=Instance.new("Folder",workspace)
	footPartFolder.Name="footPartFolder"
	local rayParams=RaycastParams.new()
	rayParams:AddToFilter(footPartFolder)
	for i,v in pairs(toFilterOut) do
		rayParams:AddToFilter(v)
	end
	rayParams.FilterType=Enum.RaycastFilterType.Exclude
	local nextFootRayResult=nil
	local wasTouchingFloor=false
	rs.RenderStepped:Connect(function() 		
		local rayDir=(footPart.CFrame*CFrame.Angles(-math.pi/2,0,0)).LookVector*footPart.Size.Y
		local rayResult=workspace:Raycast(
			footPart.Position-(rayDir*0.5),
			rayDir,
			rayParams
		)
		if rayResult then
			nextFootRayResult=rayResult
			wasTouchingFloor=true
			print("WE GOT THE FLOOR")
		else
			if wasTouchingFloor==false then return end
			wasTouchingFloor=false
			
			local normalToSurface=nextFootRayResult.Normal
			local footPartLV=footPart.CFrame.LookVector
			local normalLVDot=footPartLV:Dot(normalToSurface)
			local shadowLV=footPartLV-normalLVDot*normalToSurface	


			local footShadowCFrame=CFrame.new(
				nextFootRayResult.Position,
				nextFootRayResult.Position+shadowLV
			)
			
			--runs when a new part to represent the foot's shadow is made
      --can be changed to change how the shadow appears
			local shadowPart=Instance.new("Part")
			shadowPart.Parent=footPartFolder
			shadowPart.Anchored=true
			shadowPart.CanCollide=false
			shadowPart.Material=Enum.Material.Neon
			shadowPart.Color=Color3.new(0.3,0.3,0.3)
			shadowPart.Transparency=0.5
			shadowPart.Size=footPart.Size
			shadowPart.CFrame=footShadowCFrame
			
			
			task.wait(10)
			local dissapearTween=tweenService:Create(
				shadowPart,
				TweenInfo.new(1),
				{Transparency=1})
			dissapearTween:Play()
			dissapearTween.Ended:Wait()
			shadowPart:Destroy()
			
		end
	end)
end

return module
