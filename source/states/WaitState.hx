package states;

import flixel.FlxSprite;
import flixel.text.FlxText;
//import backend.AntiLeak;
import backend.DiscordBot;
import com.raidandfade.haxicord.types.Message;

class WaitState extends MusicBeatState
{
    override function create()
    {
        super.create();

        var shit:FlxText = new FlxText(0, 0, 0, "Waiting for whitelist", 16);
        shit.screenCenter();
        add(shit);

        DiscordBot.start();
    }

    var timer:Float = 0;

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (timer <= 0)
        {
            //if (AntiLeak.check()) MusicBeatState.switchState(new TitleState());
            //else timer = 1.25;
        } else timer -= elapsed;
    }
}