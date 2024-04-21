package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	static inline var SPEED:Float = 105;

	public static var isUpdown:Bool = false;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas('overWorld/BF_Map');
		animation.addByPrefix('up', "Back", 4, false);
		animation.addByPrefix('down', "Front", 4, false);
		animation.addByPrefix('left', "Left", 4, false);
		animation.addByPrefix('right', "Right", 4, false);
		scale.set(1, 1);
		offset.set(0, 0);

        antialiasing = false;

		drag.x = drag.y = 800;
	}

	function updateMovement()
	{
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		if (up || down || left || right)
		{
			var newAngle:Float = 0;
			if (up)
			{
				isUpdown = true;
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;
				facing = UP;
			}
			else if (down)
			{
				isUpdown = true;
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;
				facing = DOWN;
			}
			else if (left)
			{
				isUpdown = false;
				newAngle = 180;
				facing = LEFT;
				setFacingFlip(LEFT, false, false);
			}
			else if (right)
			{
				isUpdown = false;
				newAngle = 0;
				facing = RIGHT;
				setFacingFlip(RIGHT, false, false);
			}

			// determine our velocity based on angle and speed

			velocity.setPolarDegrees(SPEED, newAngle);
		}

		switch (facing)
		{
			case RIGHT:
				animation.play("right");
			case LEFT:
				animation.play("left");
			case UP:
				animation.play("up");
			case DOWN:
				animation.play("down");
			case _:
		}
	}

	override function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
	}
}
