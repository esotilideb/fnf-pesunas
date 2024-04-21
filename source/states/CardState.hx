package states;

import flixel.FlxSprite;
import flixel.FlxG;

class CardState extends MusicBeatState {

    var dross:FlxSprite;
    var canClick:Bool = false;

    override function create()
    {
        super.create();

        trace("inMessage");
        canClick = false;

        FlxG.sound.playMusic(Paths.music('freakyMenu'));
                
        var blackScreenMessage:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        blackScreenMessage.scrollFactor.set();
        add(blackScreenMessage);
                
        dross = new FlxSprite().loadGraphic(Paths.image("DrossMail"));
        dross.frames = Paths.getSparrowAtlas("DrossMail");
        dross.animation.addByPrefix('idleM', 'mailDefault');
        dross.animation.addByPrefix('open', 'mailOpen', 24, false);
        dross.animation.addByPrefix('showingT', 'showingText', 24, false);
        dross.animation.play("idleM");
        add(dross);
        dross.screenCenter();

        dross.y += 300;
        dross.alpha = 0;

        FlxTween.tween(dross, {y: dross.y - 300}, 1.25, {ease: FlxEase.quadOut, 
            onComplete: function (twn:FlxTween)
            {
                canClick = true;
            }
        });

        FlxTween.tween(dross, {alpha: 1}, 1.25);
                
        FlxG.save.data.endMessageShowed = true;
        FlxG.save.flush();
    }

    var drossShit:Bool = false;

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.mouse.justPressed || controls.ACCEPT)
		{
			if (!drossShit) {
                drossShit = true;
				dross.animation.play("open");
				new FlxTimer().start(18 / 24, function (tmr:FlxTimer) {
					dross.animation.play("showingT");
                    dross.y -= 100;
					canClick = true;
				});
			} else {
				trace('WENT BACK TO FREEPLAY??');
				Mods.loadTopMod();
				#if desktop DiscordClient.resetClientID(); #end
				MusicBeatState.switchState(new OverworldDross());
				FlxG.sound.playMusic(Paths.music('MapWorld_BETA'));
			}
		}
    }
}