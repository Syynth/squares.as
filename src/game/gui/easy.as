package game.gui
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	public class easy extends Entity
	{
		
		[Embed(source = '../../../assets/easy.PNG')]
		private const EASY:Class;
		
		private var sprEasy:Spritemap = new Spritemap(EASY, 91, 31);
		private var xstart:Number;
		private var ystart:Number;
		private var destX:Number;
		private var on:Boolean;
		private var fade:Boolean;
		private var vis:Boolean;
		
		public function easy(...args)
		{
			sprEasy.add("btnUp", [0], 0, false);
			sprEasy.add("btnDown", [1], 0, false);
			graphic = sprEasy;
			sprEasy.play("btnUp");
			type = "button";
			setHitbox(91, 31);
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
			sprEasy.play("btnDown");
		}
		
		public function unpress():void
		{
			sprEasy.play("btnUp");
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
				sprEasy.alpha -= sprEasy.alpha / 10;
			}
			else
			{
				sprEasy.alpha -= (sprEasy.alpha - 1) / 10;
			}
			x -= (x - destX) / 10;
		}
	}
}