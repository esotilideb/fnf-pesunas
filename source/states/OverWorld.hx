package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import sys.io.File;
import flixel.util.FlxColor;
import openfl.Assets;
import haxe.Json;
import backend.Paths;
import flixel.util.FlxDirectionFlags;
typedef PlayerSET =
{
	pX:Int,
	pY:Int,
}

class OverWorld extends MusicBeatState
{
	var map:FlxTilemap;
    //putos pendejos porque hicieron el tilemap asi pinches pendejos jodanse
	var tile1:FlxTilemap;
	var tile2:FlxTilemap;
	var tile3:FlxTilemap;
	var tile4:FlxTilemap;
	var tile5:FlxTilemap;
	var tile6:FlxTilemap;
	var tile7:FlxTilemap;
	var tile8:FlxTilemap;
	var tile9:FlxTilemap;
	var tile10:FlxTilemap;
	var tile11:FlxTilemap;
	var tile12:FlxTilemap;
	var tile13:FlxTilemap;
	//pene sexo vagina
	var mapData:Array<Int>;
	var player:FlxSprite;
	var playerJSON:PlayerSET;

	override public function create():Void
	{
		playerJSON = tjson.TJSON.parse(Paths.getTextFromFile(Paths.player("overworld")));

		mapData = converter(Paths.level("overworld", "overworld"));
		map = new FlxTilemap();
		map.loadMapFromArray(mapData, 20, 20, Paths.image("overWorld/middleTIERRAPLANA"), 95, 95);
	//	map.setTilePropierties(0, NONE);
	//	map.setTilePropierties(1, ANY);
	//	map.setTilePropierties(2, ANY, Paths.image("overworld"));
	//map.visible = false;
	//map.setTilePropierties(0, NONE);
		add(map);

		tile1 = new FlxTilemap();
		tile1.loadMapFromArray(mapData, 96, 96, Paths.image("overWorld/cornerLEFT"), 96, 96);
		tile1.setTileProperties(0, NONE);
		tile1.setTileProperties(1, ANY);
		add(tile1);

		tile2 = new FlxTilemap();
		tile2.loadMapFromArray(mapData, 96, 96, Paths.image("overWorld/cornerRIGHT"), 96, 96);
		add(tile2);

		tile3 = new FlxTilemap();
	//	tile3.loadMapFromArray(mapData, 96, 96, Paths.image("overWorld/cornerUP"));
		add(tile3);
		
		tile4 = new FlxTilemap();
		tile4.loadMapFromArray(mapData, 3, 3, Paths.image("overWorld/LEFTend"));
		add(tile4);
		
		tile5 = new FlxTilemap();
		tile5.loadMapFromArray(mapData, 3, 3, Paths.image("overWorld/LEFTendTIERRA"), 3, 3);
		add(tile5);

		tile6 = new FlxTilemap();
		tile6.loadMapFromArray(mapData, 3, 3, Paths.image("overWorld/LEFTendTIERRAPLANA"), 3, 3);
		add(tile6);

		tile7 = new FlxTilemap();
		tile7.loadMapFromArray(mapData, 3, 3, Paths.image("overWorld/mar"), 3, 3);
		add(tile7);

		tile8 = new FlxTilemap();
		tile8.loadMapFromArray(mapData, 3, 3, Paths.image("overWorld/middleCOSO"), 3, 3);
		add(tile8);

		tile9 = new FlxTilemap();
		tile9.loadMapFromArray(mapData, 3, 3, Paths.image("overWorld/middleTIERRA"), 3, 3);
		add(tile9);

		tile10 = new FlxTilemap();
		tile10.loadMapFromArray(mapData, 3, 3, Paths.image("overWorld/middleTIERRAPLANA"), 3, 3);
		add(tile10);
		tile11 = new FlxTilemap();
		tile11.loadMapFromArray(mapData, 20, 12, Paths.image("overWorld/RIGHTend"), 95, 95);
		add(tile11);
		tile12 = new FlxTilemap();
		tile12.loadMapFromArray(mapData, 20, 12, Paths.image("overWorld/RIGHTendTIERRA"), 95, 95);
		add(tile12);
		tile13 = new FlxTilemap();
		tile13.loadMapFromArray(mapData, 20, 12, Paths.image("overWorld/RIGHTendTIERRAPLANA"), 95, 95);
		add(tile13);
		player = new FlxSprite(playerJSON.pX, playerJSON.pY);
		player.frames = Paths.getSparrowAtlas('overWorld/BF_Map');
		player.animation.addByPrefix('up', "Back", 4, false);
		player.animation.addByPrefix('down', "Front", 4, false);
		player.animation.addByPrefix('left', "Left", 4, false);
		player.animation.addByPrefix('right', "Right", 4, false);
		player.animation.play('down');
		player.scale.x = 3.5;
		player.scale.y = 3.5;
		add(player);

		super.create();
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(map, player);
		movePlayer();

		if (FlxG.keys.justPressed.D) {
			MusicBeatState.switchState(new OverworldDross());
		}
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

	public static function converter(nombreArchivo:String):Array<Int>
	{
		// Lee el contenido del archivo
		var contenido:String = sys.io.File.getContent(nombreArchivo);

		// Divide la cadena en un array de cadenas usando la coma como delimitador
		var numeros:Array<String> = contenido.split(",");

		// Crea un nuevo Array<Int> para almacenar los números convertidos
		var arrayDeEnteros:Array<Int> = [];

		// Convierte cada cadena a un entero y agrega al Array<Int>
		for (num in numeros)
		{
			arrayDeEnteros.push(Std.parseInt(num));
		}

		// Devuelve el Array<Int> creado a partir del archivo
		return arrayDeEnteros;
	}
}
