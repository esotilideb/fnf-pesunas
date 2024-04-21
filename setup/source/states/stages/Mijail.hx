package states.stages;

import openfl.filters.ShaderFilter;
import states.stages.objects.*;
import flixel.FlxSprite;
import backend.TVShader;

class Mijail extends BaseStage
{
	// BUENA. MATADOR!!
	var shader:TVShader;
	var shaderHUD:TVShader;
	override function create()
	{
		trace("el pepe");

		game.camGame.bgColor = 0x00000000;
		shader = new TVShader();
		shaderHUD = new TVShader();
		
		game.camGame.setFilters([new ShaderFilter(shader.shader)]);
		game.camHUD.setFilters([new ShaderFilter(shaderHUD.shader)]);

		game.ayudaShader = true;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		game.camGame.setFilters([new ShaderFilter(shader.shader)]);
		game.camHUD.setFilters([new ShaderFilter(shaderHUD.shader)]);
	}
}