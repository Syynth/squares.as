package game.gui
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class title extends Entity
	{
		
		[Embed(source = '../../../assets/title.PNG')]
		private const TITLE:Class;
		
		private var sprTitle:Spritemap = new Spritemap(TITLE, 160, 31);
		private var xstart:Number;
		private var ystart:Number;
		private var destX:Number;
		private var on:Boolean;
		private var fade:Boolean;
		private var vis:Boolean;
		
		public function title(...args)
		{
			sprTitle.add("btnUp", [0], 0, false);
			sprTitle.add("btnDown", [1], 0, false);
			graphic = sprTitle;
			sprTitle.play("btnUp");
			type = "button";
			setHitbox(160, 31);
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
			sprTitle.play("btnDown");
		}
		
		public function unpress():void
		{
			sprTitle.play("btnUp");
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
				sprTitle.alpha -= (sprTitle.alpha) / 10;
			}
			else
			{
				sprTitle.alpha -= (sprTitle.alpha - 1) / 10;
			}
			x -= (x - destX) / 10;
		}
	}
}