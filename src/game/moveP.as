package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	public class moveP extends Entity
	{
		
		[Embed(source = '../../assets/moveplat.png')] private const MOVE:Class;
		
		private var sprMove:Spritemap = new Spritemap(MOVE, 17, 16);
		
		private var rev:Boolean;
		private var dir:int;
		private var dis:int;
		private var x1:int;
		private var x2:int;
		private var xstart:int;
		private const speed:int = 2;
		private static var count:int = 0;
		private var id:int;
		
		public function moveP(...args)
		{
			sprMove.add("anim", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 30, true);
			sprMove.play("anim");
			graphic = sprMove;
			setHitbox(16, 16);
			type = "move";
			rev = false;
			dis = 0;
			count++;
			id = count;
			
			switch (args.length)
			{
			case 2:
				x = args[0];
				xstart = x;
				y = args[1];
				break;
			case 4:
				x = args[0];
				xstart = x;
				y = args[1];
				rev = args[2];
				dis = args[3];
				break;
			}
			findPoints();
		}
		
		private function findPoints():void
		{
			x1 = xstart;
			if (rev == true)
			{
				x1 = xstart - dis * 16;
				x2 = xstart;
				dir = -1;
			}
			else
			{
				x2 = xstart + dis * 16;
				dir = 1;
			}
			if (dis == -1)
			{
				x1 = 0;
				x2 = 640;
			}
		}
		
		override public function update():void
		{
			super.update();
			for (var i:int = 0; i < 2; i++)
			{
				if (!collide("solid", x + dir, y))
				{
					if (!collide("player", x + dir, y) && !collide("push", x + dir, y))
					{
						x += dir;
						if (collide("player", x - dir, y - 1))
						{
							var p:player = player(collide("player", x - dir, y - 1));
							p.pmove(dir, id);
						}
						if (collide("push", x - dir, y - 1))
						{
							var u:push = push(collide("push", x - dir, y - 1));
							u.pmove(dir, id);
						}
					}
					else if (!collide("push", x + dir, y))
					{
						p = player(collide("player", x + dir, y));
						if (p.pmove(dir, id))
						{
							x += dir;
						}
						else
						{
							dir *= -1;
						}
					}
					else
					{
						u = push(collide("push", x + dir, y));
						if (u.pmove(dir, id))
						{
							x += dir;
						}
						else
						{
							dir *= -1;
						}
					}
				}
				else
				{
					dir *= -1;
				}
			}
			if (x >= x2)
				dir = -1;
			if (x <= x1)
				dir = 1;
		}
		
		override public function collide(type:String, _x:Number, _y:Number):Entity
		{
			if (type == "solid")
			{
				var w:Entity = super.collide("wall", _x, _y);
				var s:Entity = super.collide("slope", _x, _y);
				var b:Entity = super.collide("bounce", _x, _y);
				var f:Entity = super.collide("fall", _x, _y);
				var l:Entity = super.collide("lava", _x, _y);
				var c:Entity = super.collide("convey", _x, _y);
				var i:Entity = super.collide("ice", _x, _y);
				var g:Entity = super.collide("grav", _x, _y);
				var p:Entity = super.collide("move", _x, _y);
				
				if (w) return w;
				if (s) return s;
				if (b) return b;
				if (f) return f;
				if (l) return l;
				if (c) return c;
				if (i) return i;
				if (g) return g;
				if (p) return p;
			}
			else if (type == "solid_0")
			{
				w = super.collide("wall", _x, _y);
				b = super.collide("bounce", _x, _y);
				f = super.collide("fall", _x, _y);
				l = super.collide("lava", _x, _y);
				c = super.collide("convey", _x, _y);
				i = super.collide("ice", _x, _y);
				g = super.collide("grav", _x, _y);
				p = super.collide("move", _x, _y);
				
				if (w) return w;
				if (b) return b;
				if (f) return f;
				if (l) return l;
				if (c) return c;
				if (i) return i;
				if (g) return g;
				if (p) return p;
			}
			else if (type == "solid_1")
			{
				w = super.collide("wall", _x, _y);
				s = super.collide("slope", _x, _y);
				b = super.collide("bounce", _x, _y);
				f = super.collide("fall", _x, _y);
				l = super.collide("lava", _x, _y);
				c = super.collide("convey", _x, _y);
				g = super.collide("grav", _x, _y);
				p = super.collide("move", _x, _y);
				
				if (w) return w;
				if (s) return s;
				if (b) return b;
				if (f) return f;
				if (l) return l;
				if (c) return c;
				if (g) return g;
				if (p) return p;
			}
			return super.collide(type, _x, _y);
		}
	}
}