package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	public class water extends Entity
	{
		
		[Embed(source = '../../assets/water.png')] private const WATER:Class;
		[Embed(source = '../../assets/water_ud.png')] private const WATER_UD:Class;
		
		private var sprWater:Spritemap = new Spritemap(WATER, 16, 16);
		private var sprWater_UD:Spritemap = new Spritemap(WATER_UD, 16, 16);
		
		public function water(...args)
		{
			sprWater.add("anim", [0, 1, 2, 3, 4, 5, 6, 7], 30, true);
			sprWater_UD.add("anim", [0, 1, 2, 3, 4, 5, 6, 7], 30, true);
			type = "water";
			setHitbox(16, 16);
			switch (args.length)
			{
			case 2:
				x = args[0];
				y = args[1];
				if ((x-8) % 32 == 0)
				{
					sprWater.flipped = true;
					sprWater_UD.flipped = true;
				}
				if ((y-8) % 32 == 0)
				{
					graphic = sprWater;
					sprWater.play("anim");
				}
				else
				{
					graphic = sprWater_UD;
					sprWater_UD.play("anim");
				}
				break;
			}
		}
	}
}