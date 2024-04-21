package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxTimer;
import flixel.util.FlxSpriteUtil;
import openfl.Lib;

import cutscenes.CutsceneHandler;

#if VIDEOS_ALLOWED
#if (hxCodec >= "3.0.0") import hxcodec.flixel.FlxVideo as VideoHandler;
#elseif (hxCodec >= "2.6.1") import hxcodec.VideoHandler as VideoHandler;
#elseif (hxCodec == "2.6.0") import VideoHandler;
#else import vlc.MP4Handler as VideoHandler; #end
#end

class CastigoVideo extends FlxState
{
    override public function create()
    {
        Lib.application.window.title = "Gumball y Darwin destruyen el canal de Pepe el Mago y son SUPER CASTIGADOS (@GumballCastigad)";

        startVideo('castigo');
        super.create();
        FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
        FlxG.sound.music.fadeIn(0.1, 0, 0);
    }

    override public function update(elapsed){
        super.update(elapsed);
        if (FlxG.keys.justPressed.SPACE) {
            FlxG.switchState(new MainMenuState());
        }    
    }

    public function startVideo(name:String)
        {
            #if VIDEOS_ALLOWED
    
            var filepath:String = Paths.video(name);
            #if sys
            if(!FileSystem.exists(filepath))
            #else
            if(!OpenFlAssets.exists(filepath))
            #end
            {
                FlxG.log.warn('Couldnt find video file: ' + name);
                startAndEnd();
                return;
            }
    
            var video:VideoHandler = new VideoHandler();
                #if (hxCodec >= "3.0.0")
                // Recent versions
                video.play(filepath);
                video.onEndReached.add(function()
                {
                    video.dispose();
                    startAndEnd();
                    return;
                }, true);
                #else
                // Older versions
                video.playVideo(filepath);
                video.finishCallback = function()
                {
                    startAndEnd();
                    return;
                }
                #end
            #else
            FlxG.log.warn('Platform not supported!');
            startAndEnd();
            return;
            #end
        }
    
        function startAndEnd()
        {
        }
}

