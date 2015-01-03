package game.gui
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class hard extends Entity
	{
		
		[Embed(source = '../../../assets/hard.PNG')]
		private const HARD:Class;
		
		private var sprHard:Spritemap = new Spritemap(HARD, 91, 31);
		private var xstart:Number;
		private var ystart:Number;
		private var destX:Number;
		private var on:Boolean;
		private var fade:Boolean;
		private var vis:Boolean
		
		public function hard(...args)
		{
			sprHard.add("btnUp", [0], 0, false);
			sprHard.add("btnDown", [1], 0, false);
			graphic = sprHard;
			sprHard.play("btnUp");
			type = "button";
			setHitbox(91, 31);
			on = false;
			fade = false;
			vis = false;
			switch (args.length)
			{
			case 2: // x:int, y:int
				x = args[0];
				y = args[1];
				xstart = x;
				ystart = y;
				break;
			}
		}
		
		public function press():void
		{
			sprHard.play("btnDown");
		}
		
		public function unpress():void
		{
			sprHard.play("btnUp");
		}
		
		public function click():void
		{
			on = true;
		}
		
		public function fadeOut():void
		{
			fade = true;
			on = false;
			vis = false;
		}
		
		public function fadeIn():void
		{
			fade = false;
			on = false;
			vis = true;
		}
		
		public function isVisible():Boolean
		{
			return vis;
		}
		
		override public function update():void
		{
			if (on)
			{
				destX = 81;
			}
			else
			{
				destX = xstart;
			}
			if (fade)
			{
				sprHard.alpha -= sprHard.alpha / 10;
			}
			else
			{
				sprHard.alpha -= (sprHard.alpha - 1) / 10;
			}
			x -= (x - destX) / 10;
		}
	}
}