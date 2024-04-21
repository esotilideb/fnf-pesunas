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

	var colision:FlxSprite;

	override public function create():Void
	{
        FlxG.camera.zoom = 4.5;

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('overWorld/drossmap'));
		bg.antialiasing = false;
		bg.updateHitbox();
		add(bg);

        player = new Player(109, 550);
        player.animation.play("up", false);
		add(player);

        map = new FlxOgmo3Loader(AssetPaths.overworlddross__ogmo, AssetPaths.overworlddross__json);
		walls = map.loadTilemap(Paths.image('overWorld/tiles'), "new_layer");
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		walls.visible = true;
		add(walls);

		invisible = new FlxSprite(720, 690).loadGraphic(Paths.image("overWorld/checkpoint"));
		invisible.setGraphicSize(Std.int(invisible.width * 0.20));
		invisible.antialiasing = false;
		invisible.visible = false;
		add(invisible);

		var coso1:FlxSprite = new FlxSprite(48, 93).loadGraphic(Paths.image("overWorld/Dross_Tree"));
		coso1.antialiasing = false;
		add(coso1);

		var coso2:FlxSprite = new FlxSprite(126, 93).loadGraphic(Paths.image("overWorld/Dross_Tree"));
		coso2.antialiasing = false;
		add(coso2);

		var coso3:FlxSprite = new FlxSprite(52, 35).loadGraphic(Paths.image("overWorld/Dross_Tree"));
		coso3.antialiasing = false;
		add(coso3);

		var coso4:FlxSprite = new FlxSprite(78, 73).loadGraphic(Paths.image("overWorld/Barrel"));
		coso4.antialiasing = false;
		add(coso4);

		super.create();

		FlxG.camera.follow(player, LOCKON, 1);

		FlxG.camera.scroll.x = -250;
		FlxG.camera.scroll.y = -590;

		FlxG.camera.x = -75;
	//FlxG.camera.y = -400;
		//FlxG.camera.zoom = -2;

		

	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        FlxG.collide(player, walls);
		//FlxG.camera.updateFramerate();
		
		if(FlxG.overlap(player, invisible)){
			if (FlxG.keys.justPressed.Z) {
				LoadingState.loadAndSwitchState(new PlayState());
				PlayState.SONG = Song.loadFromJson("goat-heavyhearted", "goat-heavyhearted");
			}
		}
	} //749 726
}