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
typedef PlayerSET =
{
	pX:Int,
	pY:Int,
}

class OverWorld extends MusicBeatState
{
	var map:FlxTilemap;
	var mapData:Array<Int>;
	var player:FlxSprite;
	var playerJSON:PlayerSET;

	override public function create():Void
	{
		playerJSON = tjson.TJSON.parse(Paths.getTextFromFile(Paths.player("overworld")));

		mapData = converter(Paths.level("overworld", "overworld"));
		map = new FlxTilemap();
		map.loadMapFromArray(mapData, 20, 12, Paths.image("bad"), 95, 95);
		add(map);

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
