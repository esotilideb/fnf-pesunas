package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import openfl.Lib;
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
import backend.Song;
import substates.PauseSubState;
typedef PlayerSET =
{
	pX:Int,
	pY:Int,
}

class OverWorld extends MusicBeatState
{
	var map:FlxTilemap;
	//var deco:FlxTilemap;
	var mapData:Array<Int>;
//	var decoData:Array<Int>; parece que flixel no puede hacer eso, que mamada
	var player:FlxSprite;
	var playerJSON:PlayerSET;
	var isRunning:Bool;
	var velocidadVal:Int;
	var horizFloat:Float = 66.5;
	var pasto:FlxSprite;
	var nose:FlxSprite;
	var idk:FlxSprite;
	var plantaR:FlxSprite;
	var plantaG:FlxSprite;
	var plantaB:FlxSprite;
	var casaPepeC:FlxSprite;
	var arbol:FlxSprite;
	var arbol2:FlxSprite;
	var arbusto:FlxSprite;
	
	var drossMail:FlxSprite;
	var drossMailO:FlxSprite;
	var drossMailP:FlxSprite;

	var canWalk:Bool;

	var clickCounter:Int;


	override public function create():Void
	{
		Lib.application.window.title = "Magic Funkin - Overworld";

		playerJSON = tjson.TJSON.parse(Paths.getTextFromFile(Paths.player("overworld")));

		mapData = converter(Paths.level("overworld", "overworld"));
		map = new FlxTilemap();
		map.loadMapFromArray(mapData, 22, 13, Paths.image("overWorld/tilesOverd"), 66, 66);
		map.auto = FULL;
		map.setTileProperties(0, ANY);
		map.setTileProperties(1, NONE);
		map.setTileProperties(2, ANY);
		map.setTileProperties(3, NONE);
		map.setTileProperties(4, NONE);
		map.setTileProperties(5, NONE);
		map.setTileProperties(6, ANY);
		map.setTileProperties(7, ANY);
		map.setTileProperties(8, NONE);
		map.setTileProperties(9, ANY);
		map.setTileProperties(10, ANY);
		map.setTileProperties(11, ANY);
		map.setTileProperties(12, ANY);

	map.setTileProperties(13, ANY);
	map.setTileProperties(14, NONE);
	map.setTileProperties(15, NONE);
	map.setTileProperties(16, ANY);
		add(map);

		var casaPepe:FlxSprite = new FlxSprite(752, 175).loadGraphic(Paths.image("overWorld/pepeCasa"));
		casaPepe.setGraphicSize(Std.int(casaPepe.width * 5.7));
		casaPepe.antialiasing = false;
		add(casaPepe);

		casaPepeC = new FlxSprite(720, 290).loadGraphic(Paths.image("overWorld/checkpoint"));
		casaPepeC.setGraphicSize(Std.int(casaPepeC.width * 0.63));
		casaPepeC.antialiasing = false;
		add(casaPepeC);

		player = new FlxSprite(playerJSON.pX, playerJSON.pY);
		player.frames = Paths.getSparrowAtlas('overWorld/BF_Map');
		player.animation.addByPrefix('up', "Back", 4, false);
		player.animation.addByPrefix('down', "Front", 4, false);
		player.animation.addByPrefix('left', "Left", 4, false);
		player.animation.addByPrefix('right', "Right", 4, false);
		player.animation.play('down');
		player.scale.x = 4.2;
		player.scale.y = 4.2;
		player.x = 130;
		player.y = 400;

		FlxG.sound.playMusic(Paths.music("MapWorld_BETA"));

		function anadirPasto(x:Int, y:Int){
            pasto = new FlxSprite(x, y).loadGraphic(Paths.image("overWorld/decoracion/pasto"));
			pasto.scale.set(0.6, 0.6);
			add(pasto);
		}
		function anadirIdk(x:Int, y:Int){
            idk = new FlxSprite(x, y).loadGraphic(Paths.image("overWorld/decoracion/IDK"));
			idk.scale.set(0.6, 0.6);
			add(idk);
		}
		function anadirNose(x:Int, y:Int){
            nose = new FlxSprite(x, y).loadGraphic(Paths.image("overWorld/decoracion/nose"));
			nose.scale.set(0.8, 0.8);
			add(nose);
		}
		function anadirPlantaR(x:Int, y:Int){
            plantaR = new FlxSprite(x, y).loadGraphic(Paths.image("overWorld/decoracion/PLANTAROSADA"));
			plantaR.scale.set(0.7, 0.7);
			add(plantaR);
		}
		function anadirPlantaG(x:Int, y:Int){
            plantaG = new FlxSprite(x, y).loadGraphic(Paths.image("overWorld/decoracion/plantaVERDE"));
			plantaG.scale.set(0.7, 0.7);
			add(plantaG);
		}
		function anadirPlantaB(x:Int, y:Int){
            plantaB = new FlxSprite(x, y).loadGraphic(Paths.image("overWorld/decoracion/plantaVERDEAGUA"));
			plantaB.scale.set(0.7, 0.7);
			add(plantaB);
		}
		function anadirArbol(x:Int, y:Int){
            arbol = new FlxSprite(x, y).loadGraphic(Paths.image("overWorld/treer"));
            arbol.scale.set(5.2, 5.2);
			add(arbol);
		}
		function anadirArbol2(x:Int, y:Int){
            arbol2 = new FlxSprite(x, y).loadGraphic(Paths.image("overWorld/treeb"));
			arbol2.scale.set(5.2, 5.2);
			add(arbol2);
		}
		function anadirArbusto(x:Int, y:Int){
            arbusto = new FlxSprite(x, y).loadGraphic(Paths.image("overWorld/decoracion/arbusto"));
			arbusto.scale.set(4, 4);
			add(arbusto);
		}
	// mierda para añadir objetos
	//	anadirPlantaG(100, 300);
	//	anadirPlantaG(200, 300);
	anadirPasto(366, 503);
	anadirPlantaR(350, 440);
	//anadirPlantaR(100, 100);
	anadirPasto(226, 144);
	anadirPasto(487, 172);
	anadirPasto(875, 338);
	anadirPlantaR(975, 235);
	anadirPlantaB(393, 112);
	anadirPlantaG(-1, 330);
	anadirPlantaG(240, 330);
	anadirIdk(160, 330);
	anadirIdk(900, 260);
	anadirNose(300, 525);
	anadirNose(116, 592);
	anadirNose(234, 217);
	anadirNose(526, 100);
	anadirNose(650, 240);
	anadirNose(843, 486);
	anadirArbusto(283, 523);
	anadirArbusto(555, 448);
	anadirArbusto(637, 448);
	anadirArbusto(598, 474);
	anadirArbusto(244, 132);

	//jugador

		add(player);
		
	// aksbnjsaiund

		anadirArbol2(100, 0);
		anadirArbol2(20, 45);
		anadirArbol(100, 145);
		anadirArbol2(24, 200);
		anadirArbol(100, 235);
		anadirArbol(300, 730);
		anadirArbol2(510, 630);
		anadirArbol(1050, 624);
		anadirArbol2(945, 50);
		anadirArbol(274, 12);
	//ola

	
	/*var black:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	black.alpha = 0.5;
	add(black);

	drossMail = new FlxSprite(300, 100).loadGraphic(Paths.image("DrossMail"));
	drossMail.frames = Paths.getSparrowAtlas("DrossMail");
	drossMail.animation.addByPrefix('idleM', 'mailDefault');
	drossMail.animation.addByPrefix('open', 'mailOpen', 24, false);
	drossMail.animation.addByPrefix('showingT', 'showingText', 24, false);
	drossMail.animation.play('idleM');

	drossMailO = new FlxSprite(140, 100).loadGraphic(Paths.image("DrossMail"));
	drossMailO.frames = Paths.getSparrowAtlas("DrossMail");
	drossMailO.animation.addByPrefix('idleM', 'mailDefault');
	drossMailO.animation.addByPrefix('open', 'mailOpen', 24, false);
	drossMailO.animation.addByPrefix('showingT', 'showingText', 24, false);

	drossMailP = new FlxSprite(300, 20).loadGraphic(Paths.image("DrossMail"));
	drossMailP.frames = Paths.getSparrowAtlas("DrossMail");
	drossMailP.animation.addByPrefix('idleM', 'mailDefault');
	drossMailP.animation.addByPrefix('open', 'mailOpen', 24, false);
	drossMailP.animation.addByPrefix('showingT', 'showingText', 24, false);
	//drossMail.screenCenter();
	
	add(drossMail);
	add(drossMailO);
	add(drossMailP);
	FlxG.mouse.visible = true;

	drossMailO.visible = false;
	drossMailP.visible = false;*/


		super.create();
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(map, player);
		movePlayer();

	//	trace("x es" +FlxG.mouse.x);
	//	trace("y es" + FlxG.mouse.y);
	//FlxG.camera.y = 350;
//	FlxG.camera.x = -300;
	//FlxG.camera.zoom = 2.5;
	

		if(FlxG.overlap(player, casaPepeC)){
			if (FlxG.keys.justPressed.Z || controls.ACCEPT) {

				PlayState.storyPlaylist = ['Lunar-magic', 'Dark-magic'];
				
				PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase(), StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());  
				PlayState.campaignScore = 0;
				PlayState.isStoryMode = true;
				PlayState.storyDifficulty = 2;
				PauseSubState.isOverworld = true;
				LoadingState.loadAndSwitchState(new PlayState());
				Lib.application.window.title = "Magic Funkin";
			}
		}
		if (FlxG.keys.justPressed.ESCAPE) {
			MusicBeatState.switchState(new MainMenuState());
			Lib.application.window.title = "Magic Funkin";
			FlxG.sound.playMusic(Paths.music("freakyMenu"));
		}
		//FlxG.camera.follow(player);

	//	trace(velocidadVal);
	
	}

	private function movePlayer():Void
	{
		player.velocity.x = 0;
		player.velocity.y = 0;
		if(isRunning = true){
			velocidadVal = 200;
		}
		if(isRunning = false){
			velocidadVal = 130;
		}
		if(FlxG.keys.pressed.K){
			isRunning = true;
		}
		if (FlxG.keys.pressed.LEFT)
			{
				player.animation.play('left');
				player.velocity.x -= velocidadVal;
				isRunning = false;
			}
		if (FlxG.keys.pressed.RIGHT)
			{
				player.animation.play('right');
				player.velocity.x += velocidadVal;
				isRunning = false;
			}
			
		if (FlxG.keys.pressed.UP)
			{
				player.animation.play('up');
				player.velocity.y -= velocidadVal;
				isRunning = false;
			}
		if (FlxG.keys.pressed.DOWN)
			{
				player.animation.play('down');
				player.velocity.y += velocidadVal;
				isRunning = false;
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
/*
CUIDADO
*/