package states;

import backend.WeekData;
import backend.Highscore;

import flixel.input.keyboard.FlxKey;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import haxe.Json;

class BuildBroma extends MusicBeatState

{
    override public function create(){
          var gato:FlxSprite = new FlxSprite(Paths.image('xd'));
          gato.screenCenter();
          gato.setGraphicSize(Std.int(gato.width * 2));
          add(gato);

          FlxG.sound.play(Paths.sound('v'));
          FlxG.sound.playMusic(Paths.music('hamster'));

    }
}