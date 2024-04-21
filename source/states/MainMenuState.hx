package states;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import flixel.input.keyboard.FlxKey;
import states.PlayState;
import backend.Song;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

class MainMenuState extends MusicBeatState
{
	var magosexual:Array<String> = [
		'magicfunkin'
	];
	var horrorpepe:Array<String> = [
		'horror'
	];
	var castigo:Array<String> = [
		'caztigo'
	];
	var castigoBuffer:String = '';
	var allowedKeys:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	var magosexualBuffer:String = '';
	var horrorBuffer:String = '';
	
	public static var psychEngineVersion:String = '0.7.2h'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	var chavalitems:FlxTypedGroup<FlxSprite>;

	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'options',
		'credits'
	];

	var people:FlxSprite;
	var camFollow:FlxObject;
	var bg:FlxSprite;
	var catTween:FlxTween;
	var cat:FlxSprite;

	var discord:FlxSprite;

	var chavalOgPos:Array<Array<Float>> = [];
	var chavalOffset:Array<Array<Int>> = [[0, 127], [0, 46], [0, 42], [325, 355]];

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		bgColor = 0xFF000000;
		Conductor.bpm = 121;

		if (FlxG.save.data.endMessageShowed == null) FlxG.save.data.endMessageShowed = false;

		if (FlxG.save.data.songBool == null)
		{
			FlxG.save.data.songBool = [
				['Lunar-magic', false],
				['Dark-magic', false],
				['Tops', false],
				['dreams-awakened', false],
				['horror-pepe', false],
				['Goat-Heavyhearted', false]
			];
		}
	
		FlxG.save.flush();
		
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite(600, 300);
        bg.frames = Paths.getSparrowAtlas('mainmenu/menu_estrellas');
		bg.scrollFactor.set(0);
        bg.screenCenter();
        bg.antialiasing = false;
        bg.animation.addByPrefix('ostia', 'Estrellas0000', 16, true);
        bg.animation.play('ostia');
        add(bg);

		chavalitems = new FlxTypedGroup<FlxSprite>();
		add(chavalitems);
		
		var actualBG = new FlxSprite(600, 300).loadGraphic(Paths.image('mainmenu/bg'));
		actualBG.screenCenter();
		actualBG.scrollFactor.set(0);
		add(actualBG);

		cat = new FlxSprite().loadGraphic(Paths.image('fuck u'));
		cat.screenCenter();
		cat.alpha = 0;
		cat.antialiasing = false;

		discord = new FlxSprite(710, -265).loadGraphic(Paths.image('discord'));
		discord.scale.set(0.3, 0.3);
		discord.updateHitbox();
		discord.setPosition(FlxG.width - discord.width - 50, 50);
		discord.scrollFactor.set();
		add(discord);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var spr:FlxSprite = new FlxSprite();
			spr.frames = Paths.getSparrowAtlas('mainmenu/pibes/' + optionShit[i]);
			spr.animation.addByPrefix('Manos en el ano', 'idle', 24, (i == 3)); //nothing
			spr.animation.play('Manos en el ano', true);
			spr.antialiasing = ClientPrefs.data.antialiasing;
			spr.alpha = 0;
			spr.scale.set(600 / spr.height, 600 / spr.height);
			spr.scrollFactor.set();
			spr.updateHitbox();
			spr.setPosition(FlxG.width, FlxG.height - spr.width);
			chavalitems.add(spr);

			chavalOgPos.push([spr.x - spr.width, spr.y]);
			
			if (i != 3) {
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
			} else {
				spr.scale.set(650 / spr.height, 650 / spr.height);
				spr.updateHitbox();
				spr.setPosition(FlxG.width, FlxG.height - spr.width);
				
				people = new FlxSprite().loadGraphic(Paths.image('mainmenu/people', "shared"), true, 541, 483);
				people.scrollFactor.set();
				people.antialiasing = false;
				people.animation.add('idle', [0], 24, true); //nothing
				people.animation.add('selected', [0, 1, 1, 2, 2, 3], 24, false); //nothing
				people.animation.play('idle');
				people.scale.set(0.5, 0.5);
				people.updateHitbox();
				people.setPosition(FlxG.width - people.width, FlxG.height - people.height);
				menuItems.add(people);
			}
		}
		add(cat);

		for (i in 0...optionShit.length)
		{
			chavalitems.members[i].setPosition(chavalOgPos[i][0] + chavalOffset[i][0], chavalOgPos[i][1] + chavalOffset[i][1]);
		}


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
		FlxG.mouse.visible = true;
	}

	var selectedSomethin:Bool = false;
	var canClick:Bool = true;
	var usingMouse:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.mouse.overlaps(discord)) {
			discord.scale.set(0.25, 0.25);
			discord.alpha = 0.5;
			if (FlxG.mouse.justPressed)
			{
				CoolUtil.browserLoad('https://discord.gg/4c6hKFAc3V');
			}
		} else {
			discord.scale.set(0.3, 0.3);
			discord.alpha = 1;
		}

		if (FlxG.keys.firstJustPressed() != FlxKey.NONE)
		{
			var keyPressed:FlxKey = FlxG.keys.firstJustPressed();
			var keyName:String = Std.string(keyPressed);
			if(allowedKeys.contains(keyName)) {
				magosexualBuffer += keyName;
				if(magosexualBuffer.length >= 32) magosexualBuffer = magosexualBuffer.substring(1);

				for (wordRaw in magosexual)
				{
					var word:String = wordRaw.toUpperCase();
					if (magosexualBuffer.contains(word))
					{
							MusicBeatState.switchState(new MagicVideo());
					}
				}
			}
		}

		if (FlxG.keys.firstJustPressed() != FlxKey.NONE)
			{
				var keyPressed:FlxKey = FlxG.keys.firstJustPressed();
				var keyName:String = Std.string(keyPressed);
				if(allowedKeys.contains(keyName)) {
					horrorBuffer += keyName;
					if(horrorBuffer.length >= 32) horrorBuffer = horrorBuffer.substring(1);
	
					for (wordRaw in horrorpepe)
					{
						var word:String = wordRaw.toUpperCase();
						if (horrorBuffer.contains(word))
						{
							LoadingState.loadAndSwitchState(new PlayState());
							PlayState.SONG = Song.loadFromJson("horror-pepe", "horror-pepe");
						}
					}
				}
			}

			if (FlxG.keys.firstJustPressed() != FlxKey.NONE)
				{
					var keyPressed:FlxKey = FlxG.keys.firstJustPressed();
					var keyName:String = Std.string(keyPressed);
					if(allowedKeys.contains(keyName)) {
						castigoBuffer += keyName;
						if(castigoBuffer.length >= 32) castigoBuffer = castigoBuffer.substring(1);
		
						for (wordRaw in castigo)
						{
							var word:String = wordRaw.toUpperCase();
							if (castigoBuffer.contains(word))
							{
									MusicBeatState.switchState(new CastigoVideo());
							}
						}
					}
				}
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}
		
		if (!selectedSomethin)
		{
			for (i in 0...optionShit.length)
			{
				chavalitems.members[i].setPosition(chavalOgPos[i][0] + chavalOffset[i][0], chavalOgPos[i][1] + chavalOffset[i][1]);
			}
			
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
								FlxG.switchState(new OverWorld());
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
				if (catTween != null)
					catTween.cancel(); //esto es lo ultimo en bromas xdxdxd
		
				FlxG.sound.play(Paths.sound('vine boom'), 1);
				catTween = FlxTween.tween(cat, {alpha: 1}, 0.15, {ease: FlxEase.sineOut, onComplete: function(twn:FlxTween)
					{
						catTween = FlxTween.tween(cat, {alpha : 0}, 2, {ease: FlxEase.sineOut});
					}});
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

		var oldGuy = chavalitems.members[curSelected];
		var oldX = chavalOgPos[curSelected][0] + chavalOffset[curSelected][0];

		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		var newGuy = chavalitems.members[curSelected];
		var newX = chavalOgPos[curSelected][0] + chavalOffset[curSelected][0] + newGuy.width;

		selectedSomethin = true;

		if (huh != 0) {
			FlxTween.tween(oldGuy, {x: oldX + oldGuy.width}, 0.5, {ease: FlxEase.quadIn});
			FlxTween.tween(oldGuy, {alpha: 0}, 0.5, {
				onComplete: function(twn:FlxTween)
				{
					newGuy.x += newGuy.width;
					FlxTween.tween(newGuy, {x: newX - newGuy.width}, 0.5, {ease: FlxEase.quadOut});
					FlxTween.tween(newGuy, {alpha: 1}, 0.5, {
						onComplete: function(twn2:FlxTween)
						{
							selectedSomethin = false;
						}
					});
				}
			});
		} else {
			newGuy.x += newGuy.width;
			FlxTween.tween(newGuy, {x: newX - newGuy.width}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(newGuy, {alpha: 1}, 0.5, {
					onComplete: function(twn2:FlxTween)
					{
						selectedSomethin = false;
					}
			});
		}

		menuItems.members[curSelected].animation.play('selected');
		menuItems.members[curSelected].centerOffsets();

		camFollow.setPosition(menuItems.members[curSelected].getGraphicMidpoint().x,
			menuItems.members[curSelected].getGraphicMidpoint().y - (menuItems.length > 4 ? menuItems.length * 8 : 0));
	}

	override function beatHit()
	{
		super.beatHit();

		for (i in 0...chavalitems.members.length) {
			var spr = chavalitems.members[i];
			var beatEvery:Int = 1;

			if (i == 2) beatEvery = 3;

			if (curBeat % beatEvery == 0 && i != 3) spr.animation.play('Manos en el ano', true);
		}
	}
}
