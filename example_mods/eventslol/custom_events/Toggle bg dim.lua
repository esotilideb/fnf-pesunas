function onCreate()
	makeLuaSprite('nig','',0,0)
	makeGraphic('nig',640,360,'000000')
	addLuaSprite('nig',true)
	setScrollFactor('nig',0)
	setObjectCamera('nig', 'hud');
	scaleObject('nig', 2, 2);
end
function onEvent(name,v1,v2)
	if name == 'Toggle bg dim' then
			doTweenAlpha('on','nig',v1,v2,'linear')
	end
end
	if name == 'Toggle bg dim' and string.lower(v1) == 'off' then
		doTweenAlpha('off','nig',0,v2,'linear')
		
	end
