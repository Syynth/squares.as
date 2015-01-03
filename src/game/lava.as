package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	public class lava extends Entity
	{
		[Embed(source = '../../assets/lava.png')]
		private const LAVA:Class;
		private var sprLava:Spritemap = new Spritemap(LAVA, 16, 16);
		
		public function lava(...args)
		{
			sprLava.add("anim", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21], 30, true);
			graphic = sprLava;
			sprLava.play("anim");
			setHitbox(16, 16);
			type = "lava";
			switch (args.length)
			{
			case 2:
				x = args[0];
				y = args[1];
				break;
			}
		}
	}
}