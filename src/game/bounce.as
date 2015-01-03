package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	public class bounce extends Entity
	{
		
		[Embed(source = '../../assets/bounce.png')] private const BOUNCE:Class;
		
		private var sprBounce:Spritemap = new Spritemap(BOUNCE, 16, 16);
		
		public function bounce(...args)
		{
			sprBounce.add("still", [0], 0, false);
			sprBounce.add("anim", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], 60, false);
			graphic = sprBounce;
			type = "bounce";
			setHitbox(16, 16);
			sprBounce.play("still");
			switch (args.length)
			{
			case 2: // x:int, y:int
				x = args[0];
				y = args[1];
				break;
			}
		}
		
		public function play():void
		{
			sprBounce.play("anim", true);
		}
		
		override public function update():void
		{
			super.update();
			if (collide("player", x, y - 1))
			{
				play();
			}
		}
	}
}