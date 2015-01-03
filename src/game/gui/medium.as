package game.gui
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class medium extends Entity
	{
		
		[Embed(source = '../../../assets/medium.PNG')]
		private const MEDIUM:Class;
		
		private var sprMed:Spritemap = new Spritemap(MEDIUM, 137, 31);
		private var xstart:Number;
		private var ystart:Number;
		private var destX:Number;
		private var on:Boolean;
		private var fade:Boolean;
		private var vis:Boolean;
		
		public function medium(...args)
		{
			sprMed.add("btnUp", [0], 0, false);
			sprMed.add("btnDown", [1], 0, false);
			graphic = sprMed;
			sprMed.play("btnUp");
			type = "button";
			setHitbox(137, 31);
			on = false;
			fade = false;
			vis = true;
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
			sprMed.play("btnDown");
		}
		
		public function unpress():void
		{
			sprMed.play("btnUp");
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
				sprMed.alpha -= sprMed.alpha / 10;
			}
			else
			{
				sprMed.alpha -= (sprMed.alpha - 1) / 10;
			}
			x -= (x - destX) / 10;
		}
	}
}