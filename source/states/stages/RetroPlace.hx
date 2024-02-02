package states.stages;

import states.stages.objects.*;

class RetroPlace extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	override function create()
	{

		var bg:BGSprite = new BGSprite('stages/1-1/piso', -600, -200, 0.9, 0.9);
		bg.updateHitbox();
		add(bg);

		var nubes:BGSprite  = new BGSprite('stages/1-1/nubes', -600, -200, 0.9, 0.9);
		nubes.updateHitbox();
		add(nubes);

		var blocks:BGSprite  = new BGSprite('stages/1-1/bloque', -650, -200, 0.9, 0.9);
		add(blocks);

		/*retro = new BGSprite('stages/1-1/retro', -600, -200, 0.9, 0.9);
		retro.updateHitbox();
		retro.visible = true;
		add(retro);*/
	}
}