package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Slope extends Entity
	{
		[Embed(source = '../../assets/slopes.png')] protected const SLOPE:Class;
		protected var sprSlope:Spritemap = new Spritemap(SLOPE, 16, 16);
		
		public function Slope()
		{
			
		}
		
		public function assignSprites():void
		{
			sprSlope.add("rem", [0], 0, false);
			sprSlope.add("r1s", [1], 0, false);
			sprSlope.add("r1b", [2], 0, false);
			sprSlope.add("rfl", [3], 0, false);
			sprSlope.add("lem", [4], 0, false);
			sprSlope.add("l1s", [5], 0, false);
			sprSlope.add("l1b", [6], 0, false);
			sprSlope.add("lfl", [7], 0, false);
		}
	}

}