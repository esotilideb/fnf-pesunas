package states.stages;

import states.stages.objects.*;

class PepeHouse extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{

		var fg:BGSprite = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'fg', -600, -200, 0.9, 0.9);
		fg.updateHitbox();
		add(fg);

		var arbol:BGSprite = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'arbol', -600, -200, 0.9, 0.9);
		arbol.updateHitbox();
		add(arbol);

		var arbol1:BGSprite = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'arboles', -600, -200, 0.9, 0.9);
		arbol1.updateHitbox();
		add(arbol1);

		var luz:BGSprite = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'luz2', -600, -200, 0.9, 0.9);
		luz.updateHitbox();
		add(luz);

		var arbustos:BGSprite = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'arbustos', -650, -200, 0.9, 0.9);
		add(arbustos);

		if (backend.BaseStage.exe == "but.exe/") {
			var puas2:BGSprite = new BGSprite('stages/pepe-casa/but.exe/coso2', -600, -200, 0.9, 0.9);
			puas2.updateHitbox();
			add(puas2);
		}

		var piso:BGSprite = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'piso-casa', -600, -200, 0.9, 0.9);
		piso.updateHitbox();
		piso.scrollFactor.set(0.95, 0.95); //@Andree1x puto
		add(piso);

		var water = new BGSprite('stages/pepe-casa/' + backend.BaseStage.exe + 'agua', -600, -200, 0.9, 0.9, ['idle'], true);
		water.updateHitbox();
		add(water);

		var people = new BGSprite('stages/pepe-casa/bg_characters', 0, 460, 0.9, 0.9, ['bg_characters'], true);
		people.setGraphicSize(Std.int(people.width * 2.5));
		people.antialiasing = true;
		people.updateHitbox();
		add(people);

		if (backend.BaseStage.exe == "but.exe/") {
			people.visible = false;

			var puas3:BGSprite = new BGSprite('stages/pepe-casa/but.exe/coso3', -600, -200, 0.9, 0.9);
			puas3.updateHitbox();
			add(puas3);
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