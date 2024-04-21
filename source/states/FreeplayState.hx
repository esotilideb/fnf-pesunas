package states;

import backend.WeekData;
import backend.Highscore;
import backend.Song;

import objects.HealthIcon;
import objects.MusicPlayer;
import flixel.input.keyboard.FlxKey;

import substates.GameplayChangersSubstate;
import openfl.events.KeyboardEvent;
import substates.ResetScoreSubState;

import flixel.math.FlxMath;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

import openfl.Lib;

class FreeplayState extends MusicBeatState
{
    var scoreBG:FlxSprite;
    var scoreText:FlxText;
    var holdTime:Float = 0;
    var bottomString:String = "";
	var bottomText:FlxText;
	var bottomBG:FlxSprite;
    public static var vocals:FlxSound = null;


    private static var curSelected:Int = 0;
    var curDifficulty:Int = 1;
    var black:FlxSprite;

    var portrait:FlxSprite;
    var title:FlxSprite;

    var songs:Array<SongMetadata> = [];
    var arrows:FlxTypedGroup<FlxSprite>;

    var missingTextBG:FlxSprite;
    var missingText:FlxText;

    override function create()
    {
        #if desktop
          DiscordClient.changePresence("In the menus", "logo");
        #end

        
        var songArray:Array<Array<String>> = [
            ['Lunar-magic', "WEEK 1 - Mago VS BF"],
            ['Dark-magic', "WEEK 1 - Mago VS Mago?"],
            ['Tops', "EXTRA - Pepe VS Nerd"],
            ['dreams-awakened', "EXTRA - ..."]/*,
            ['horror-pepe', "EXTRA - HORROR PEPAURI"]*/
        ];

        for (i in 0...songArray.length)
        {
            addSong(songArray[i][0], 1, "dad", songArray[i][1]);
        }

		var bg = new FlxSprite().makeGraphic(1280, 720, 0xFF0500B1);
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.screenCenter();
        add(bg);

        var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0xFF002FFF, FlxColor.TRANSPARENT));
		grid.velocity.set(40, 40);
        grid.alpha = 0.5;
		add(grid);

        var fre:FlxSprite = new FlxSprite().loadGraphic(Paths.image("freeplayshit/freeplay", "shared"));
        add(fre);

        arrows = new FlxTypedGroup<FlxSprite>();
        add(arrows);

        for (i in 0...2)
        {
            var spr:FlxSprite = new FlxSprite().loadGraphic(Paths.image("freeplayshit/Key_Freeplay", "shared"));
            spr.screenCenter(Y);
            if (i == 1) spr.x = (FlxG.width - spr.width) - 15;
            else spr.x = 15;

            if (i == 0) spr.flipX = true;
            arrows.add(spr);
        }

        portrait = new FlxSprite().loadGraphic(Paths.image("freeplayshit/portraits", "shared"), true, 1280, 1280);
        portrait.scale.set(0.35, 0.35);
        portrait.updateHitbox();

        title = new FlxSprite().loadGraphic(Paths.image("freeplayshit/titles", "shared"), true, 516, 277);
        
        for (i in 0...songArray.length)
        {
            portrait.animation.add(songArray[i][0], [i]);
            title.animation.add(songArray[i][0], [i]);
        }

        portrait.animation.play(songArray[0][0]);
        title.animation.play(songArray[0][0]);
        add(portrait);
        add(title);

        portrait.screenCenter();
        title.screenCenter();

        portrait.x += (portrait.width / 2) + 20;
        title.x -= (portrait.width / 2) + 20;

        portrait.y += 20;
        title.y += 40;

        black = new FlxSprite(FlxG.width).loadGraphic(Paths.image("freeplayshit/blackbar", "shared"));
        black.x -= black.width;
        add(black);

        scoreText = new FlxText(0, 10, 0, songArray[0][1].toLowerCase(), 32);
		scoreText.setFormat(Paths.font("PhantomMuff.ttf"), 32, FlxColor.WHITE);
        add(scoreText);

        scoreText.setPosition(black.x + 19 + ((black.width - 19) / 2) - (scoreText.width / 2), (black.height / 2) - (scoreText.height / 2));

        var blackShit:FlxSprite = new FlxSprite(0, FlxG.height).loadGraphic(Paths.image("freeplayshit/blackbar2", "shared"));
        blackShit.y -= blackShit.height;
        add(blackShit);

        missingTextBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		missingTextBG.alpha = 0.6;
		missingTextBG.visible = false;
		add(missingTextBG);
		
		missingText = new FlxText(50, 0, FlxG.width - 100, '', 24);
		missingText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		missingText.scrollFactor.set();
		missingText.visible = false;
		add(missingText);

        changeSelection(0, true, true);
        Difficulty.list = Difficulty.defaultList;

        var playedAllSongs:Bool = true;
        for (i in 0...4)
        {
            if (!FlxG.save.data.songBool[i][1])
                playedAllSongs = false;
        }
            
        if (playedAllSongs)
            FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyCheck);
        
        super.create();
    }
    
    private function keyCheck(event:KeyboardEvent):Void
    {
        var key:FlxKey = event.keyCode;
            
        if (curNumCode > 0) 
        {
            if (key == codes[0][curNumCode])
            {
                if (curNumCode == codes[0].length-1)
                {
                    persistentUpdate = false;
                    var songLowercase:String = Paths.formatToSongPath("horror-pepe");
                    var poop:String = Highscore.formatSong('horror-pepe', curDifficulty);
            
                    try
                    {
                        PlayState.SONG = Song.loadFromJson(poop, songLowercase);

                        PlayState.isStoryMode = false;
                        PlayState.storyDifficulty = curDifficulty;
            
                        trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
                        trace(poop);

                        LoadingState.loadAndSwitchState(new PlayState());
                        FlxG.sound.music.volume = 0;       

                        #if (MODS_ALLOWED && cpp)
                        DiscordClient.loadModRPC();
                        #end
                    }
                    catch(e:Dynamic)
                    {
                        trace('ERROR! $e');
            
                        var errorStr:String = e.toString();
                        if(errorStr.startsWith('[file_contents,assets/data/')) errorStr = 'Missing file: ' + errorStr.substring(34, errorStr.length-1); //Missing chart
                        missingText.text = 'ERROR WHILE LOADING CHART:\n$errorStr';
                        missingText.screenCenter(Y);
                        missingText.visible = true;
                        missingTextBG.visible = true;
                        FlxG.sound.play(Paths.sound('cancelMenu'));
                    }
                }
                else
                {
                    curNumCode += 1;
                }
            }
            else
            {
                curNumCode = 0;
            }
        }
            
        if (curNumCode == 0) 
        {
            for (i in 0...codes.length)
            {
                if (key == codes[i][0])
                {
                    curNumCode = 1;
                }
            }
        }
    }

    var codes:Array<Array<FlxKey>> = [[H, O, R, R, O, R]];
    var curNumCode:Int = 0;

    var changing:Bool = false;
    override function update(elapsed:Float)
    {
        if (FlxG.sound.music.volume < 0.7)
        {
            FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
        }

        scoreText.x = (black.x + 19 + ((black.width - 19) / 2) - (scoreText.width / 2));

        if (controls.UI_LEFT_R)
        {
            arrows.members[0].scale.set(1, 1);
            arrows.members[0].alpha = 1;
        }
            
        if (controls.UI_RIGHT_R)
        {
            arrows.members[1].scale.set(1, 1);
            arrows.members[1].alpha = 1;
        }
        
        if (!changing) {
            if (controls.UI_LEFT_P)
            {
                arrows.members[0].scale.set(0.5, 0.5);
                arrows.members[0].alpha = 0.5;

                changeSelection(-1);
            }
            else if (controls.UI_RIGHT_P)
            {
                arrows.members[1].scale.set(0.5, 0.5);
                arrows.members[1].alpha = 0.5;

                changeSelection(1);
            }
        
            if (controls.BACK)
            {
                persistentUpdate = false;
                FlxG.sound.play(Paths.sound('cancelMenu'));
                MusicBeatState.switchState(new MainMenuState());
                Lib.application.window.title = "Magic Funkin";
            }
            else if(FlxG.keys.justPressed.CONTROL)
            {
                persistentUpdate = false;
                openSubState(new GameplayChangersSubstate());
            }
            else if (controls.ACCEPT)
            {
                Lib.application.window.title = "Magic Funkin";

                persistentUpdate = false;
                var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
                var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
        
                try
                {
                    PlayState.SONG = Song.loadFromJson(poop, songLowercase);

                    PlayState.isStoryMode = false;
                    PlayState.storyDifficulty = curDifficulty;
        
                    trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
                    trace(poop);

                    if (poop == 'dark-magic')
                        backend.BaseStage.exe = 'but.exe/';
                    else
                        backend.BaseStage.exe = '';

                    LoadingState.loadAndSwitchState(new PlayState());
                    FlxG.sound.music.volume = 0;       

                    #if (MODS_ALLOWED && cpp)
                    DiscordClient.loadModRPC();
                    #end
                }
                catch(e:Dynamic)
                {
                    trace('ERROR! $e');
        
                    var errorStr:String = e.toString();
                    if(errorStr.startsWith('[file_contents,assets/data/')) errorStr = 'Missing file: ' + errorStr.substring(34, errorStr.length-1); //Missing chart
                    missingText.text = 'ERROR WHILE LOADING CHART:\n$errorStr';
                    missingText.screenCenter(Y);
                    missingText.visible = true;
                    missingTextBG.visible = true;
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                }
            }
        }
        
        super.update(elapsed);
    }
    
    public function addSong(songName:String, weekNum:Int, songCharacter:String, desc:String)
    {
        songs.push(new SongMetadata(songName, weekNum, songCharacter, desc));
    }
    
    function changeSelection(change:Int = 0, playSound:Bool = true, pene:Bool = false)
    {
        if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
        curSelected += change;
    
        changing = !pene;

        Lib.application.window.title = "Magic Funkin - " + songs[curSelected].songName;

        if (curSelected < 0)
            curSelected = songs.length - 1;
        if (curSelected >= songs.length)
            curSelected = 0;
        
        if (!pene) {
            FlxTween.tween(portrait, {y: portrait.y + 500}, 0.75, {ease: FlxEase.quadIn,
                onComplete: function(twn:FlxTween)
                {
                    portrait.animation.play(songs[curSelected].songName);
                    title.animation.play(songs[curSelected].songName);
                    scoreText.text = songs[curSelected].desc.toLowerCase();
                    scoreText.updateHitbox();

                    FlxTween.tween(portrait, {y: portrait.y - 500}, 0.75, {ease: FlxEase.quadOut});
                    FlxTween.tween(title, {y: title.y - 500}, 0.75, {ease: FlxEase.quadOut,
                        onComplete: function(twn2:FlxTween)
                        {
                            changing = false;
                        }
                    });
                    
                    FlxTween.tween(scoreText, {y: scoreText.y + 50}, 0.75, {ease: FlxEase.quadOut});

                    new FlxTimer().start(0.25, function(tmr:FlxTimer)
                    {
                        FlxTween.tween(scoreText, {alpha: 1}, 0.5);
                        FlxTween.tween(title, {alpha: 1}, 0.5);
                        FlxTween.tween(portrait, {alpha: 1}, 0.5);
                    });
                }
            });

            FlxTween.tween(portrait, {alpha: 0}, 0.5);

            FlxTween.tween(title, {y: title.y + 500}, 0.75, {ease: FlxEase.quadIn});
            FlxTween.tween(title, {alpha: 0}, 0.5);

            FlxTween.tween(scoreText, {y: scoreText.y - 50}, 0.75, {ease: FlxEase.quadIn});
            FlxTween.tween(scoreText, {alpha: 0}, 0.5);
        } else {
            portrait.animation.play(songs[curSelected].songName);
            title.animation.play(songs[curSelected].songName);
            scoreText.text = songs[curSelected].desc.toLowerCase();
            scoreText.updateHitbox();
        }

        Mods.currentModDirectory = songs[curSelected].folder;
        PlayState.storyWeek = songs[curSelected].week;
    }

    // COSAS INNECESARIAS QUE ME PIDE PQ SINO NO COMPILA LOL
    //-------------------------------------------------
    private function positionHighscore() {
		/*scoreText.x = FlxG.width - scoreText.width;
		scoreBG.scale.x = FlxG.width - scoreText.x + 6;
		scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);*/
        trace("LOL");
	}

    public static function destroyFreeplayVocals() {
		/*if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;*/
        trace("LOL");
	}
    //-------------------------------------------------
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var desc:String = "";
	public var songCharacter:String = "";
	public var folder:String = "";
	public var lastDifficulty:String = null;

	public function new(song:String, week:Int, songCharacter:String, desc:String)
	{
		this.songName = song;
		this.week = week;
		this.desc = desc;
		this.songCharacter = songCharacter;
		this.folder = Mods.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}