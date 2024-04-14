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
	var player:Player;

    var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	override public function create():Void
	{
        FlxG.camera.zoom = 2.5;

        var bg:FlxSprite = new FlxSprite(640, 664).loadGraphic(Paths.image('overWorld/drossmap'));
		bg.antialiasing = false;
		bg.updateHitbox();
		add(bg);

        player = new Player(736, 1208);
        player.animation.play("up", false);
		add(player);

        map = new FlxOgmo3Loader(AssetPaths.overworlddross__ogmo, AssetPaths.overworlddross__json);
		walls = map.loadTilemap(Paths.image('overWorld/tiles'), "new_layer");
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		walls.visible = true;
		add(walls);

		super.create();

		FlxG.camera.follow(player, TOPDOWN, 1);
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        FlxG.collide(player, walls);

		if (FlxG.keys.justPressed.TWO) {
			player.x = FlxG.mouse.x;
			player.y = FlxG.mouse.y;
			trace('player x is' + player.x + 'player y is' + player.y);
		}
	}
}