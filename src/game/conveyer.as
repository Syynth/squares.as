package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	public class conveyer extends Entity
	{
		
		[Embed(source = '../../assets/conveyerR.png')] private const CONVEY:Class;
		
		private var sprConvey:Spritemap = new Spritemap(CONVEY, 16, 16);
		
		public function conveyer(...args)
		{
			sprConvey.add("anim", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 30, true);
			sprConvey.play("anim");
			graphic = sprConvey;
			type = "convey";
			setHitbox(16, 16);
			switch (args.length)
			{
			case 2:
				x = args[0];
				y = args[1];
			case 3:
				x = args[0];
				y = args[1];
				if (args[2] == "left")
				{
					sprConvey.flipped = true;
				}
				break;
			}
		}
		
		public function left():Boolean
		{
			return sprConvey.flipped;
		}
		
		override public function update():void
		{
			super.update();
			if (collide("player", x, y + 1))
			{
				var p:player = player(collide("player", x, y + 1));
				if (left())
				{
					p.move( -5, 0);
				}
				else
				{
					p.move( 5, 0);
				}
			}
			if (collide("player", x, y - 1))
			{
				p = player(collide("player", x, y - 1));
				if (left())
				{
					p.move( -5, 0);
				}
				else
				{
					p.move( 5, 0);
				}
			}
			if (collide("push", x, y + 1))
			{
				var pp:push = push(collide("push", x, y + 1));
				if (left())
				{
					pp.move( -5, 0);
				}
				else
				{
					pp.move( 5, 0);
				}
			}
			if (collide("push", x, y - 1))
			{
				pp = push(collide("push", x, y - 1));
				if (left())
				{
					pp.move( -5, 0);
				}
				else
				{
					pp.move( 5, 0);
				}
			}
		}
			
	}
}