package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	public class fall extends Entity
	{
		
		[Embed(source = '../../assets/fall.png')] private const FALL:Class;
		
		private var sprFall:Spritemap = new Spritemap(FALL, 16, 16, fill);
		
		private var ystart:Number;
		private var yspeed:int;
		private var time:int;
		
		private var falling:Boolean;
		
		public function fall(...args)
		{
			sprFall.add("emp", [0], 0, false);
			sprFall.add("anim", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
								 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30], 30, false);
			sprFall.add("full", [31], 0, false);
			graphic = sprFall;
			sprFall.play("emp");
			setHitbox(16, 16);
			type = "fall";
			falling = false;
			time = 0;
			yspeed = 0;
			switch (args.length)
			{
			case 2:
				x = args[0];
				y = args[1];
				ystart = y;
				break;
			}
		}
		
		public function start():void
		{
			sprFall.play("anim");
		}
		
		private function fill():void
		{
			sprFall.play("full");
			falling = true;
			setHitbox(0, 0);
		}
		
		override public function update():void
		{
			super.update();
			if (collide("player", x, y - 1) || collide("push", x, y - 1) )
			{
				start();
			}
			if (falling)
			{
				time++;
				yspeed++;
				y += yspeed;
			}
			if (time > 60)
			{
				setHitbox(16, 16);
				if (!collide("player", x, ystart) && !collide("push", x, ystart))
				{
					sprFall.play("emp");
					time = 0;
					falling = false;
					y = ystart;
					yspeed = 0;
				}
			}
		}
	}
}