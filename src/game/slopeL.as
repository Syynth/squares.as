package game
{
	
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Pixelmask;
	
	public class slopeL extends Slope
	{
		
		[Embed(source = '../../assets/slopeL.png')] protected const SLOPEM:Class;
		protected var sprMask:Pixelmask = new Pixelmask(SLOPEM, 0, 0);
		
		public function slopeL(...args)
		{
			type = "slope";
			mask = sprMask;
			graphic = sprSlope;
			assignSprites();
			if (args.length == 2)
			{
				x = args[0];
				y = args[1];
			}
		}
		
		public function assignSprite():void
		{			
			var s:int = 0; var b:int = 0;
			if (collide("wall", x - 1, y) || collide("slope", x - 1, y))
				s = 1;
			if (collide("wall", x, y + 1) || collide("slope", x, y + 1))
				b = 1;
				
			switch (s + b)
			{
			case 0:
				sprSlope.play("lfl");
				break;
			case 1:
				if (s == 0)
					sprSlope.play("l1s");
				else
					sprSlope.play("l1b");
				break;
			case 2:
				sprSlope.play("lem");
				break;
			}
		}
	}
}