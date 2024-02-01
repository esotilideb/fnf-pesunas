package states;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.7.2h'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'options',
	];

	var people:FlxSprite;
	var chaval:FlxSprite;
	var camFollow:FlxObject;

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var bg = new FlxSprite(600, 300);
        bg.frames = Paths.getSparrowAtlas('mainmenu/menu_estrellas');
		bg.scrollFactor.set(0);
        bg.screenCenter();
        bg.antialiasing = false;
        bg.animation.addByPrefix('ostia', 'Estrellas', 16, true);
        bg.animation.play('ostia');
        add(bg);

		chaval = new FlxSprite(-900,-200);
		chaval.frames = Paths.getSparrowAtlas('mainmenu/pibes/' + optionShit[curSelected]);
		chaval.scrollFactor.set(0);
		chaval.screenCenter(Y);
		chaval.setGraphicSize(Std.int(chaval.width * 0.27));
		chaval.animation.addByPrefix('Manos en el ano', 'idle', 24); //nothing
		chaval.animation.play('Manos en el ano');
		chaval.antialiasing = ClientPrefs.data.antialiasing;
		add(chaval);
		
		var actualBG = new FlxSprite(600, 300).loadGraphic(Paths.image('mainmenu/bg'));
		actualBG.screenCenter();
		actualBG.scrollFactor.set(0);
		add(actualBG);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140) + offset);
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', "menu_" + optionShit[i], 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + "_select", 24);
			menuItem.animation.play('idle');
			menuItem.setGraphicSize(Std.int(menuItem.width * 0.95));
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0);
			menuItem.updateHitbox();
			switch (i)
			{
				case 0:
				 menuItem.setPosition(25,25);		
				case 1:
				 menuItem.setPosition(40,15);	
				case 2:
				 menuItem.setPosition(60,50);	
				/*case 3:
				 menuItem.setPosition(520, -40);	
				 menuItem.setGraphicSize(Std.int(menuItem.width * 0.5));*/

			}
		}

		people = new FlxSprite(-950, -100);
		people.frames = Paths.getSparrowAtlas('mainmenu/people');
		people.screenCenter();
		people.scrollFactor.set(0);
		people.setGraphicSize(Std.int(people.width * 0.5));
		people.antialiasing = false;
		people.animation.addByPrefix('idle', 'people-normal', 24, true); //nothing
		people.animation.addByPrefix('rebote', 'rebote', 24, true); //nothing
		people.animation.addByPrefix('selected', 'seleccionado', 24, true); //nothing
		people.animation.play('idle');
		add(people);	

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		// Unlocks "Freaky on a Friday Night" achievement if it's a Friday and between 18:00 PM and 23:59 PM
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
			Achievements.unlock('friday_night_play');

		#if MODS_ALLOWED
		Achievements.reloadList();
		#end
		#end

		super.create();

		FlxG.camera.follow(camFollow, null, 0.15);
	}

	var selectedSomethin:Bool = false;
	var canClick:Bool = true;
	var usingMouse:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (!selectedSomethin)
		{
			/*FlxG.mouse.visible = true;
			if(usingMouse)
				{
					if(!FlxG.mouse.overlaps(people))
						people.animation.play('idle');
				}
			
			if (FlxG.mouse.overlaps(people))
				{
					if(canClick)
					{
						curSelected = people.ID;
						usingMouse = true;
						people.animation.play('selected');
					}
							
					if(FlxG.mouse.pressed && canClick)
						goToState();
				}
			
				people.updateHitbox();*/
				
			if (controls.UI_UP_P)
				changeItem(-1);

			if (controls.UI_DOWN_P)
				changeItem(1);

			if(controls.UI_UP || controls.UI_DOWN)
				{
					chaval.x = 1200;
					new FlxTimer().start(0.2, function(tmr:FlxTimer)
						{
							chaval.frames = Paths.getSparrowAtlas('mainmenu/pibes/' + optionShit[curSelected]);
							chaval.animation.play('Manos en el ano');
							FlxTween.tween(chaval,{x: -900},0.2,{ease:FlxEase.cubeOut});
						});
				}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;

					FlxFlicker.flicker(menuItems.members[curSelected], 1, 0.06, false, false, function(flick:FlxFlicker)
					{
						switch (optionShit[curSelected])
						{
							case 'story_mode':
								MusicBeatState.switchState(new OverWorld());
							case 'freeplay':
								MusicBeatState.switchState(new FreeplayState());
							case 'credits':
								MusicBeatState.switchState(new CreditsState());
							case 'options':
								MusicBeatState.switchState(new OptionsState());
								OptionsState.onPlayState = false;
								if (PlayState.SONG != null)
								{
									PlayState.SONG.arrowSkin = null;
									PlayState.SONG.splashSkin = null;
									PlayState.stageUI = 'normal';
								}
						}
					});

					for (i in 0...menuItems.members.length)
					{
						if (i == curSelected)
							continue;
					}
				}
			}
			#if desktop
			if (controls.justPressed('debug_1'))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}

			if (FlxG.keys.justPressed.Q)
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new OverWorld());
			}
			#end
		}

		super.update(elapsed);
	}

	function goToState()
		{
			canClick = false;
			selectedSomethin = true;

			FlxG.switchState(new CreditsState());	
		}

	function changeItem(huh:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));
		menuItems.members[curSelected].animation.play('idle');
		menuItems.members[curSelected].updateHitbox();

		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.members[curSelected].animation.play('selected');
		menuItems.members[curSelected].centerOffsets();

		camFollow.setPosition(menuItems.members[curSelected].getGraphicMidpoint().x,
			menuItems.members[curSelected].getGraphicMidpoint().y - (menuItems.length > 4 ? menuItems.length * 8 : 0));
	}
}
