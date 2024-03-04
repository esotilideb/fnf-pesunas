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

	loadGraphic('songLength.bg','songLength')
	setProperty('songLength.x', getProperty('songLength.x') + 30)
	setProperty('songLength.y', getProperty('songLength.y') + 30)
end


end