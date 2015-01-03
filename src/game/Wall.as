package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	
	public class Wall extends Entity
	{
		[Embed(source = '../../assets/wall.png')] private const WALL:Class;
		
		public var sprWall:Spritemap = new Spritemap(WALL, 16, 16);
		
		public function Wall(...args)
		{
			type = "wall";
			setHitbox(16, 16);
			sprWall.add("full", [0], 0, false);
			sprWall.add("vsd",  [1], 0, false);
			sprWall.add("hsd",  [2], 0, false);
			sprWall.add("emp",  [3], 0, false);
			sprWall.add("cur",  [4], 0, false);
			sprWall.add("cul",  [5], 0, false);
			sprWall.add("cdl",  [6], 0, false);
			sprWall.add("cdr",  [7], 0, false);
			sprWall.add("sdd",  [8], 0, false);
			sprWall.add("sdl",  [9], 0, false);
			sprWall.add("sdu", [10], 0, false);
			sprWall.add("sdr", [11], 0, false);
			sprWall.add("c2u", [12], 0, false);
			sprWall.add("c2l", [13], 0, false);
			sprWall.add("c2r", [14], 0, false);
			sprWall.add("c2d", [15], 0, false);
			
			graphic = sprWall;
			sprWall.play("full");
			switch (args.length)
			{
			case 2:
				x = args[0];
				y = args[1];
			}
		}
		
		public function assignSprite():void
		{
			var l:int = 0; var r:int = 0; var u:int = 0; var d:int = 0;
			if (collide("wall", x - 1, y) || collide("slope", x - 1, y))
				l = 1;
			if (collide("wall", x + 1, y) || collide("slope", x + 1, y))
				r = 1;
			if (collide("wall", x, y - 1) || collide("slope", x, y - 1))
				u = 1;
			if (collide("wall", x, y + 1) || collide("slope", x, y + 1))
				d = 1;
				
			switch (l + r + d + u)
			{
			case 4:
				sprWall.play("emp");
				break;
			case 3:
				if (u == 0)
					sprWall.play("sdu");
				else if (l == 0)
					sprWall.play("sdl");
				else if (r == 0)
					sprWall.play("sdr");
				else
					sprWall.play("sdd");
				break;
			case 2:
				if (u == 0 && d == 0)
					sprWall.play("hsd");
				if (l == 0 && r == 0)
					sprWall.play("vsd");
				if (u == 0 && l == 0)
					sprWall.play("cul");
				if (u == 0 && r == 0)
					sprWall.play("cur");
				if (d == 0 && l == 0)
					sprWall.play("cdl");
				if (d == 0 && r == 0)
					sprWall.play("cdr");
				break;
			case 1:
				if (u == 1)
					sprWall.play("c2d");
				else if (l == 1)
					sprWall.play("c2r");
				else if (r == 1)
					sprWall.play("c2l");
				else
					sprWall.play("c2u");
				break;
			case 0:
				sprWall.play("full");
				break;
			}
			
		}
	}
}