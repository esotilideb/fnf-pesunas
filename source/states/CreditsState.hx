package states;

import flixel.addons.display.FlxBackdrop;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.frontEnds.SoundFrontEnd;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 0;

	private var iconGrp:FlxTypedGroup<FlxSprite>;
	private var creditsStuff:Array<Array<Dynamic>> = [];

	var descText:FlxText;
	var frase:FlxText;

	var intendedColor:Int;
	var colorTween:FlxTween;

	var offsetThing:Float = -75;
	
	var arrowL:FlxSprite;
	var arrowR:FlxSprite;

	var bg:FlxSprite;
	var grid:FlxBackdrop;

	var colorGuide:FlxSprite;
	var lol:FlxSprite;

	override function create()
	{
		persistentUpdate = true;


		colorGuide = new FlxSprite().makeGraphic(1, 1, FlxColor.WHITE);
		colorGuide.alpha = 0;
		add(colorGuide);

		bg = new FlxSprite().loadGraphic(Paths.image("menu", "shared"));
		bg.screenCenter();
        add(bg);

        grid = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0xFF002FFF, FlxColor.TRANSPARENT));
		grid.velocity.set(40, 40);
        grid.alpha = 0.5;
		add(grid);
		
		var tv = new FlxSprite().loadGraphic(Paths.image("creditAssets/tv", "shared"));
		tv.screenCenter();
		tv.y -= 50;
		add(tv);

		var barUp = new FlxSprite().loadGraphic(Paths.image("creditAssets/barUp", "shared"));
		barUp.screenCenter(X);
		add(barUp);

		var barDown = new FlxSprite().loadGraphic(Paths.image("creditAssets/barDown", "shared"));
		barDown.screenCenter(X);
		barDown.y = FlxG.height - barDown.height;
		add(barDown);

		iconGrp = new FlxTypedGroup<FlxSprite>();
		add(iconGrp);

		var pisspoop:Array<Array<Dynamic>> = [ //Name - Icon name - Trabajo - Frase - BG Color
			["AngieGB", "angie", "Director, Animador y Artista", "Vas a caer pixel art", 0xFF9be330],
			["Luk9as", "yo", 'Coder', "Pene", 0xFFFF3931],
			["Denger", "yo", 'Coder', "Pene", 0xFFFF3931]
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}

		grid.color = creditsStuff[0][4];
		bg.color = creditsStuff[0][4];
	
		for (i in 0...creditsStuff.length)
		{
			var icon:FlxSprite = new FlxSprite().loadGraphic(Paths.image("papuIcons/" + creditsStuff[i][1], "shared"));
			var scale:Float = 0;

			if (icon.width > icon.height) scale = 200 / icon.width;
			else if (icon.height > icon.width) scale = 200 / icon.height;
			else if (icon.height == icon.width) scale = 1;

			icon.scale.set(scale, scale);
			icon.updateHitbox();
			icon.screenCenter();
			icon.antialiasing = true;
			iconGrp.add(icon);
		}
		
		arrowL = new FlxSprite(tv.x - 50).loadGraphic(Paths.image("freeplayshit/Key_Freeplay", "shared"));
		arrowL.screenCenter(Y);
		arrowL.x -= arrowL.width;
		arrowL.flipX = true;
		arrowL.scale.set(0.75, 0.75);
		add(arrowL);
		
		arrowR = new FlxSprite((tv.x + tv.width) + 50).loadGraphic(Paths.image("freeplayshit/Key_Freeplay", "shared"));
		arrowR.screenCenter(Y);
		arrowR.scale.set(0.75, 0.75);
		add(arrowR);

		descText = new FlxText(50, FlxG.height + offsetThing + 50, 1180, "", 48);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		add(descText);

		frase = new FlxText(50, 75, 1180, "", 48);
		frase.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		frase.scrollFactor.set();
		add(frase);

		var animShit:Array<Int> = [];

		for (i in 0...126) animShit.push(i);
			
		lol = new FlxSprite().loadGraphic(Paths.image("creditAssets/lol", "shared"), true, 466, 360);
		lol.animation.add("ol", animShit, 24, true);
		lol.animation.play("ol");
		lol.scale.set(775 / lol.width, 75 / lol.height);
		lol.updateHitbox();
		lol.setPosition(barUp.x + (barUp.width / 2) - (775 / 2), barUp.y + (barUp.height / 2) - (75 / 2));
		lol.visible = false;
		add(lol);

		musicalol = FlxG.sound.play(Paths.sound("audiolol", "shared"), 0.7, true);
		musicalol.volume = 0;
		
		changeSelection();
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	var musicalol:FlxSound;
	override function update(elapsed:Float)
	{
		if (lol.visible) {
			if (musicalol.volume < 1)
			{
				musicalol.volume += 0.5 * FlxG.elapsed;
			}
			FlxG.sound.music.volume = 0;
		} else {
			if (FlxG.sound.music.volume < 0.7)
			{
				FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			}
			musicalol.volume = 0;
		}

		grid.color = colorGuide.color;
		bg.color = colorGuide.color;

		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var upP = controls.UI_LEFT_P;
				var downP = controls.UI_RIGHT_P;
				
				var upR = controls.UI_LEFT_R;
				var downR = controls.UI_RIGHT_R;

				if (upP)
				{
					changeSelection(-1);
					holdTime = 0;

					arrowL.scale.set(0.5, 0.5);
					arrowL.alpha = 0.5;
				}
				if (downP)
				{
					changeSelection(1);
					holdTime = 0;

					arrowR.scale.set(0.5, 0.5);
					arrowR.alpha = 0.5;
				}
				
				if (upR) {
					arrowL.scale.set(0.75, 0.75);
					arrowL.alpha = 1;
				}
				
				if (downR) {
					arrowR.scale.set(0.75, 0.75);
					arrowR.alpha = 1;
				}
			}
			
			var bac = controls.BACK;
			
			if (bac)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
				quitting = true;
			}
		}
		super.update(elapsed);
	}

	var moveTween:FlxTween = null;
	var fraseTween:FlxTween = null;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var bullShit:Int = 0;

		descText.text = creditsStuff[curSelected][0] + "\n" + creditsStuff[curSelected][2];
		descText.y = FlxG.height - descText.height + offsetThing + 5;

		if(moveTween != null) moveTween.cancel();
		moveTween = FlxTween.tween(descText, {y : descText.y + 30}, 0.25, {ease: FlxEase.sineOut});
		

		frase.text = creditsStuff[curSelected][3];
		frase.y = 5;

		if(fraseTween != null) fraseTween.cancel();
		fraseTween = FlxTween.tween(frase, {y : frase.y + 15}, 0.25, {ease: FlxEase.sineOut});

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Credits:", creditsStuff[curSelected][0]);
		#end
		
		iconGrp.forEachAlive(function(spr:FlxSprite) {
			spr.alpha = 0;
		});

		if(colorTween != null) {
			colorTween.cancel();
		}
		colorTween = FlxTween.color(colorGuide, 0.25, colorGuide.color, creditsStuff[curSelected][4], {
			onComplete: function(twn:FlxTween) {
				colorTween = null;
			}
		});

		lol.visible = (frase.text == "Pene");
		
		iconGrp.members[curSelected].alpha = 1;
		iconGrp.members[curSelected].screenCenter(Y);
		iconGrp.members[curSelected].y -= 50;
		FlxTween.tween(iconGrp.members[curSelected], {y: iconGrp.members[curSelected].y + 50}, 0.25, {ease: FlxEase.sineOut});
	}

	#if MODS_ALLOWED
	private var modsAdded:Array<String> = [];
	function pushModCreditsToList(folder:String)
	{
		if(modsAdded.contains(folder)) return;

		var creditsFile:String = null;
		if(folder != null && folder.trim().length > 0) creditsFile = Paths.mods(folder + '/data/credits.txt');
		else creditsFile = Paths.mods('data/credits.txt');

		if (FileSystem.exists(creditsFile))
		{
			var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
			for(i in firstarray)
			{
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				if(arr.length >= 5) arr.push(folder);
				creditsStuff.push(arr);
			}
			creditsStuff.push(['']);
		}
		modsAdded.push(folder);
	}
	#end
	
	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}