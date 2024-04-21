package states.stages;

import states.stages.objects.*;

class Dross extends BaseStage
{
	// EL COÑO DE TU MADRE...

	override function create()
	{
		//game.camGame.bgColor = 0xffffff;
		trace("COÑOOOOOOOOOOOO");

		var bg:FlxSprite = new FlxSprite(100, 200).loadGraphic(Paths.image("dross"));
		bg.setGraphicSize(Std.int(bg.width * 1.55));
		bg.scrollFactor.set(0.9, 0.9);
		add(bg);
	}
}