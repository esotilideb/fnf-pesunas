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
import openfl.Lib;
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
		walls.visible = false;
		add(walls);

		invisible = new FlxSprite(81, 30).loadGraphic(Paths.image("overWorld/checkpoint"));
		invisible.setGraphicSize(Std.int(invisible.width * 0.6));
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

		FlxG.camera.x = -70;
	//FlxG.camera.y = -400;
		//FlxG.camera.zoom = -2;

		FlxG.sound.music.fadeIn(0.1, 0, 0);

		next = new FlxText(0, 0, 0, "Press Z to select a stage", 48);
		next.screenCenter();
		next.y += 300;
		next.scrollFactor.set();
		next.visible = false;
		add(next);

	}

	var next:FlxText;
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        FlxG.collide(player, walls);
		//FlxG.camera.updateFramerate();

		trace(player.x, player.y);
		
		if (FlxG.keys.justPressed.ESCAPE) {
            MusicBeatState.switchState(new MainMenuState());
            Lib.application.window.title = "Magic Funkin";
            FlxG.sound.playMusic(Paths.music("freakyMenu"));
        }

		if(FlxG.overlap(player, invisible)){
			next.visible = true;
			if (FlxG.keys.justPressed.Z || FlxG.keys.justPressed.ENTER) {
				LoadingState.loadAndSwitchState(new PlayState());
				PlayState.SONG = Song.loadFromJson("goat-heavyhearted", "goat-heavyhearted");
			}
		} else {
			next.visible = false;
		}
	} //749 726
}