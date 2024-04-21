package states.stages;

import states.stages.objects.*;

class Apoco extends BaseStage
{
	// apoco wey

	override function create()
		{
	
			var bg:BGSprite = new BGSprite('stages/smb1/piso', -600, -200, 0.9, 0.9);
			bg.updateHitbox();
			add(bg);
	
			var nubes:BGSprite  = new BGSprite('stages/smb1/nubes', -600, -200, 0.9, 0.9);
			nubes.updateHitbox();
			add(nubes);
	
			var blocks:BGSprite  = new BGSprite('stages/smb1/bloque', -650, -200, 0.9, 0.9);
			add(blocks);
	

			/*retro = new BGSprite('stages/1-1/retro', -600, -200, 0.9, 0.9);
			retro.updateHitbox();
			retro.visible = true;
			add(retro);*/
		}
}