package states;

import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUISprite;
import flixel.tile.FlxTilemap;

class LevelEditor extends MusicBeatState
{
    var characterX:Int;
    var characterY:Int;
    var mapData:Array<Int>;
    var mapString:Array<Int> = [
        1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
        1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
        1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
        1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,
        1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,
        1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,
        1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,
        1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,
        1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,
        1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
        1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
        ];
    var inputText:FlxUIInputText;
	var map:FlxTilemap;

	override public function create():Void
        {

           // mapString = inputText;

            map = new FlxTilemap();
            map.loadMapFromArray(mapString, 20, 12, Paths.image("bad"), 95, 95);
            add(map);

            inputText = new FlxUIInputText(0, 0, 400, "", 20);
            add(inputText);
        }
}