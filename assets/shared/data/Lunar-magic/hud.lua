--script hecho por gameegartxd y cabox, acreditanos por usar esto!!!

function onCreatePost()
    --healthbar / icon / score

    makeLuaSprite('healthBar1','hud/healthBar1', 0, 0)
    setGraphicSize('healthBar1',360,190)
    setObjectCamera('healthBar1','hud')
    addLuaSprite('healthBar1')

    loadGraphic('healthBar.bg','healthBar')
    setGraphicSize('healthBar.bg',198,20)
    setProperty('healthBar.bg.x',135)
    setProperty('healthBar.bg.y',50)
    setProperty('healthBar.bounds.min',0.2) --150
    runHaxeCode([[
        game.healthBar.regenerateClips();
    ]])
    
    setProperty('iconP1.y',getProperty('healthBar.bg.y') - 20)
    setProperty('iconP1.x', -10)
    setProperty('iconP1.flipX', true)

    setProperty('iconP2.visible', false)

    setProperty('scoreTxt.x', 150)
    setProperty('scoreTxt.y', 60)

    --timer
    makeLuaSprite('timer', 'hud/timer', 1000, 0);
	setObjectCamera('timer','hud')
    if downscroll then
        setProperty('timer.y', 0);
    else
        setProperty('timer.y', 350);
    end
	addLuaSprite('timer', false);

	loadGraphic('timeBar.bg','timeBar')
	setProperty("timeBar.visible", false)
    setProperty('timeTxt.x',935)

    if downscroll then
        setProperty('timeTxt.y', 160);
    else
        setProperty('timeTxt.y', 510);
    end

	loadGraphic('songLength.bg','songLength')
	setProperty('songLength.x', getProperty('songLength.x') + 30)
	setProperty('songLength.y', getProperty('songLength.y') + 30)
end

function onUpdate(elapsed)
    if mustHitSection then 
        doTweenAlpha("skibidi", timeTxt, 0.4, 0.25, "linear")
        doTweenAlpha("toilet", timer, 0.4, 0.25, "linear")
    else 
        doTweenAlpha("skibidi", timeTxt, 1, 0.25, "linear")
        doTweenAlpha("toilet", timer, 1, 0.25, "linear")
    end

end