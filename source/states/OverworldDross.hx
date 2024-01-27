package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.FlxObject;
import sys.io.File;
import flixel.util.FlxColor;
import openfl.Assets;
import haxe.Json;
import backend.Paths;

class OverworldDross extends FlxState
{
	var player:FlxSprite;

    var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	override public function create():Void
	{
        FlxG.camera.zoom = 2.1;

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('overWorld/drossmap'));
		bg.antialiasing = false;
		bg.updateHitbox();
		add(bg);

		player = new FlxSprite(101, 576);
		player.frames = Paths.getSparrowAtlas('overWorld/BF_Map');
		player.animation.addByPrefix('up', "Back", 4, false);
		player.animation.addByPrefix('down', "Front", 4, false);
		player.animation.addByPrefix('left', "Left", 4, false);
		player.animation.addByPrefix('right', "Right", 4, false);
		player.animation.play('down');
		add(player);

        map = new FlxOgmo3Loader(AssetPaths.overworlddross__ogmo, AssetPaths.overworlddross__json);
		walls = map.loadTilemap(Paths.image('overWorld/tiles'), "walls");
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		//walls.visible = false;
		add(walls);

        FlxG.camera.follow(player, TOPDOWN, 1);

		super.create();
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        FlxG.collide(player, walls);
		movePlayer();
	}

	private function movePlayer():Void
	{
		player.velocity.x = 0;
		player.velocity.y = 0;
		if (FlxG.keys.pressed.LEFT)
			{
				player.animation.play('left');
				player.velocity.x -= 130;
			}
		if (FlxG.keys.pressed.RIGHT)
			{
				player.animation.play('right');
				player.velocity.x += 130;
			}
		if (FlxG.keys.pressed.UP)
			{
				player.animation.play('up');
				player.velocity.y -= 130;
			}
		if (FlxG.keys.pressed.DOWN)
			{
				player.animation.play('down');
				player.velocity.y += 130;
			}
	}
}
