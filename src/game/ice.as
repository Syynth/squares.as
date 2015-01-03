package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	public class ice extends Entity
	{
		
		[Embed(source = '../../assets/ice.png')] private const ICE:Class;
		
		private var sprIce:Spritemap = new Spritemap(ICE, 16, 16);
		
		public function ice(...args)
		{
			sprIce.add("anim", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
								18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30], 30, true);
			graphic = sprIce;
			sprIce.play("anim");
			type = "ice";
			setHitbox(16, 16);
			switch (args.length)
			{
			case 2: // x:int, y:int;
				x = args[0];
				y = args[1];
			}
		}
	}
}