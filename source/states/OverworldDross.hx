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
import backend.Song;

class OverworldDross extends FlxState
{
	var player:Player;

    var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var invisible:FlxSprite;

	override public function create():Void
	{
        FlxG.camera.zoom = 2;

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
		walls.visible = false;
		add(walls);

		invisible = new FlxSprite(720, 690).loadGraphic(Paths.image("overWorld/checkpoint"));
		invisible.setGraphicSize(Std.int(invisible.width * 0.20));
		invisible.antialiasing = false;
		invisible.visible = false;
		add(invisible);

		super.create();

		FlxG.camera.follow(player, TOPDOWN, 1);

		FlxG.camera.scroll.x = -250;
		FlxG.camera.scroll.y = -400;

		FlxG.camera.x = -150;
	//FlxG.camera.y = -400;
		//FlxG.camera.zoom = -2;

		

	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        FlxG.collide(player, walls);
		//FlxG.camera.updateFramerate();
		

		if (FlxG.keys.justPressed.TWO) {
			player.x = FlxG.mouse.x;
			player.y = FlxG.mouse.y;
			trace('player x is' + player.x + 'player y is' + player.y);
		}

		if(FlxG.overlap(player, invisible)){
			if (FlxG.keys.justPressed.Z) {
				LoadingState.loadAndSwitchState(new PlayState());
				PlayState.SONG = Song.loadFromJson("goat-heavyhearted", "goat-heavyhearted");
			}
		}
	} //749 726
}