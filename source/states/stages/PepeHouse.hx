package states.stages;

import states.stages.objects.*;

class PepeHouse extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var fg:BGSprite;
	var arbol:BGSprite;
	var arbol1:BGSprite;
	var luz:BGSprite;
	var arbustos:BGSprite;
	var piso:BGSprite;
	var water:BGSprite;
	var people:BGSprite;

	var normalBG:FlxSpriteGroup;
	var pixelBG:FlxSpriteGroup;

	override function create()
	{

		normalBG = new FlxSpriteGroup();
		add(normalBG);

		pixelBG = new FlxSpriteGroup();
		add(pixelBG);

		fg = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'fg', -600, -200, 0.9, 0.9);
		fg.updateHitbox();
		normalBG.add(fg);

		arbol = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'arbol', -600, -200, 0.9, 0.9);
		arbol.updateHitbox();
		normalBG.add(arbol);

		arbol1 = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'arboles', -600, -200, 0.9, 0.9);
		arbol1.updateHitbox();
		normalBG.add(arbol1);

		luz = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'luz2', -600, -200, 0.9, 0.9);
		luz.updateHitbox();
		normalBG.add(luz);

		arbustos = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'arbustos', -650, -200, 0.9, 0.9);
		normalBG.add(arbustos);

		if (backend.BaseStage.exe == "but.exe/") {
			var puas2:BGSprite = new BGSprite('stages/pepe-casa/but.exe/coso2', -600, -200, 0.9, 0.9);
			puas2.updateHitbox();
			normalBG.add(puas2);
		}

		piso = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'piso-casa', -600, -200, 0.9, 0.9);
		piso.updateHitbox();
		piso.scrollFactor.set(0.95, 0.95); //@Andree1x puto
		normalBG.add(piso);

		water = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'agua', -600, -200, 0.9, 0.9, ['idle'], true);
		water.updateHitbox();
		normalBG.add(water);

		people = new BGSprite('stages/pepe-casa/bg_characters', 0, 460, 0.9, 0.9, ['bg_characters'], true);
		people.setGraphicSize(Std.int(people.width * 2.5));
		people.antialiasing = true;
		people.updateHitbox();
		normalBG.add(people);

		//coders le mandan un saludo a mi amigaso meloxd

		var bgPIXEL = new BGSprite('stages/pepe-casa/retro/BG1',800, 700, 0.9, 0.9);
		bgPIXEL.antialiasing = false;
		bgPIXEL.setGraphicSize(Std.int(bgPIXEL.width * 10));
		bgPIXEL.scrollFactor.set(0.95, 0.95);
		pixelBG.add(bgPIXEL);

		var casaPIXEL = new BGSprite('stages/pepe-casa/retro/BG2', 800, 800, 0.9, 0.9, ['BG2'], true);
		casaPIXEL.antialiasing = false;
		casaPIXEL.setGraphicSize(Std.int(casaPIXEL.width * 8));
		pixelBG.add(casaPIXEL);

		var pisoPIXEL = new BGSprite('stages/pepe-casa/retro/B3', 800, 800, 0.9, 0.9);
		pisoPIXEL.antialiasing = false;
		pisoPIXEL.scrollFactor.set(0.95, 0.95);
		pisoPIXEL.setGraphicSize(Std.int(pisoPIXEL.width * 8));
		pixelBG.add(pisoPIXEL);
		pixelBG.visible = false;

		if (backend.BaseStage.exe == "but.exe/") {
			people.visible = false;

			var puas3:BGSprite = new BGSprite('stages/pepe-casa/but.exe/coso3', -600, -200, 0.9, 0.9);
			puas3.updateHitbox();
			normalBG.add(puas3);
		}
			
	}

	override function stepHit() // me cago wn
		{

			if (curStep == 1514){
				FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom + 0.5}, 1.8, {
					ease: FlxEase.quadInOut,
					onComplete: function(twn:FlxTween)
						{
							game.triggerEvent('Change Character', 'bf', 'bf_pixel', 0);
							game.triggerEvent('Change Character', 'gf', 'gfpixel', 0);
							game.triggerEvent('Change Character', 'dad', 'Pepe_Pixel', 0);

							game.boyfriend.y = boyfriend.y + 50;
							game.dad.y = dad.y + 50;
							game.gf.y = gf.y + 50;

							normalBG.visible = false;
							pixelBG.visible = true;
						}
				});
				FlxG.camera.flash(FlxColor.WHITE, 2);
			}
		}

	override function createPost() //crear post pa que se ponga encima...
		{ 
			var blackScreen = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFF000000);
			blackScreen.screenCenter();
			blackScreen.cameras = [game.camHUD];
			add(blackScreen);
			
			var sol:BGSprite = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'luz', -600, -200, 0.9, 0.9);
			sol.updateHitbox();
			sol.alpha = 0.65; //sin alpha parece sol en chile🔥
			add(sol);

			if (backend.BaseStage.exe == "but.exe/") {
				var puas:BGSprite = new BGSprite('stages/pepe-casa/but.exe/coso', -600, 0, 0.9, 0.9);
				puas.updateHitbox();
				puas.scrollFactor.set(0.5, 0.5); //@Andree1x puto
				add(puas);
			}

			new FlxTimer().start(1.2, function(deadTime:FlxTimer)
				{
					if (backend.BaseStage.exe == "but.exe/") {
						new FlxTimer().start(11, function(deadTime:FlxTimer)
							{
								game.skipCountdown = true;
								blackScreen.alpha = 0;
								FlxG.camera.flash(FlxColor.WHITE, 1);
							});
					}
					else
						FlxTween.tween(blackScreen, {alpha: 0}, 20, { ease: FlxEase.quadInOut});
				});
		}
}