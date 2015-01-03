package game.gui
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class back extends Entity
	{
		
		[Embed(source = '../../../assets/back.PNG')]
		private const BACK:Class;
		
		private var sprBack:Spritemap = new Spritemap(BACK, 91, 31);
		private var xstart:Number;
		private var ystart:Number;
		private var fade:Boolean;
		private var vis:Boolean;
		
		public function back(...args)
		{
			sprBack.add("btnUp", [0], 0, false);
			sprBack.add("btnDown", [1], 0, false);
			graphic = sprBack;
			sprBack.play("btnUp");
			type = "button";
			setHitbox(91, 31);
			fade = true;
			sprBack.alpha = 0;
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
			sprBack.play("btnDown");
		}
		
		public function unpress():void
		{
			sprBack.play("btnUp");
		}
		
		public function fadeOut():void
		{
			fade = true;
			vis = false;
		}
		
		public function fadeIn():void
		{
			fade = false;
			vis = true;
		}
		
		public function isVisible():Boolean
		{
			return vis;
		}
		
		override public function update():void
		{
			if (fade)
			{
				sprBack.alpha -= (sprBack.alpha) / 10;
			}
			else
			{
				sprBack.alpha -= (sprBack.alpha - 1) / 10;
			}
		}
	}
}