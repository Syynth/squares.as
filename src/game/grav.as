package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	public class grav extends Entity
	{
		
		[Embed(source = '../../assets/grav.png')] private const GRAV:Class;
		
		private var sprGrav:Spritemap = new Spritemap(GRAV, 16, 16, replay);
		private var animDir:String;
		
		public function grav(...args)
		{
			sprGrav.add("down", [0, 1, 2, 3, 4, 5, 6, 7], 30, false);
			sprGrav.add("right", [8, 9, 10, 11, 12, 13, 14, 15], 30, false);
			sprGrav.add("up", [16, 17, 18, 19, 20, 21, 22, 23], 30, false);
			sprGrav.add("left", [24, 25, 26, 27, 28, 29, 30, 31], 30, false);
			sprGrav.add("stil", [0], 0, false);
			sprGrav.play("stil");
			graphic = sprGrav;
			setHitbox(16, 16);
			type = "grav";
			animDir = "up";
			
			switch (args.length)
			{
			case 2:
				x = args[0];
				y = args[1];
				break;
			}
		}
		
		private function replay():void
		{
			var SET:Boolean = false;
			if (animDir == "up")
			{
				if (collide("player", x, y - 1))
				{
					sprGrav.play("up", true);
					SET = true;
				}
			}
			else if (animDir == "down")
			{
				if (collide("player", x, y + 1))
				{
					sprGrav.play("down", true);
					SET = true;
				}
			}
			else if (animDir == "left")
			{
				if (collide("player", x - 1, y))
				{
					sprGrav.play("left", true);
					SET = true;
				}
			}
			else
			{
				if (collide("player", x + 1, y))
				{
					sprGrav.play("right", true);
					SET = true;
				}
			}
			if (SET == false)
			{
				sprGrav.play("stil", true);
			}
		}
		
		private function play(dir:String):void
		{
			if (animDir == "up")
			{
				sprGrav.play("up");
			}
			else if (animDir == "down")
			{
				sprGrav.play("down");
			}
			else if (animDir == "left")
			{
				sprGrav.play("left");
			}
			else
			{
				sprGrav.play("right");
			}
		}
		
		override public function update():void
		{
			super.update();
			if (collide("player", x, y - 1))
			{
				animDir = "up";
				play(animDir);
			}
			if (collide("player", x, y + 1))
			{
				animDir = "down";
				play(animDir);
			}
			if (collide("player", x - 1, y))
			{
				animDir = "left";
				play(animDir);
			}
			if (collide("player", x + 1, y))
			{
				animDir = "right";
				play(animDir);
			}
		}
	}
}