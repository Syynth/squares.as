package game
{	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class push extends Entity
	{
		
		[Embed(source = '../../assets/push.png')] private const PUSH:Class;
		
		private var sprPush:Spritemap = new Spritemap(PUSH, 16, 16);
		
		private var yspeed:Number;
		
		private var moved:Boolean;
		private var xstart:Number;
		private var ystart:Number;
		private var LKP:Boolean;
		private var dir:int;
		private var movedBy:int;
		
		private var gOn:Boolean;
		private var gMove:int;
		private var gDir:int;
		
		private const gLateral:int = 0;
		private const gVertical:int = 1;
		private const gDiag:int = 2;
		
		private const gLeft:int = 3;
		private const gRight:int = 4;
		private const gUp:int = 5;
		private const gDown:int = 6;

		
		public function push(...args)
		{
			sprPush.add("anim", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 30, true);
			sprPush.play("anim");
			graphic = sprPush;
			setHitbox(16, 16);
			type = "push";
			yspeed = 0;
			movedBy = -1;
			
			switch (args.length)
			{
			case 2:
				x = args[0];
				y = args[1];
				break;
			}
		}
		
		private function gBlockStates():void
		{
			if (collide("grav", x - 1, y))
			{
				gOn = true;
				gMove = gVertical;
				gDir = gLeft;
			}
			if (collide("grav", x + 1, y))
			{
				gOn = true;
				gMove = gVertical;
				gDir = gRight;
			}
			if (collide("grav", x, y - 1))
			{
				gOn = true;
				if (gDir == gLeft || gDir == gRight)
				{
					gMove = gDiag;
				}
				else
				{
					gMove = gLateral;
				}
				gDir = gUp;
			}
			if (collide("grav", x, y + 1) && gOn == false)
			{
				gOn = false;
				gMove = gLateral;
				gDir = gDown;
			}
			
			if (!collide("grav", x + 1, y) && !collide("grav", x - 1, y) && !collide("grav", x, y + 1) && !collide("grav", x, y - 1))
			{
				gOn = false;
			}
		}
		
		private function gMotion():void
		{
			if (gMove == gVertical)
			{
				if (collide("player", x, y + 1))
				{
					var p:player = player(collide("player", x, y + 1));
					if (p.gON() && Input.check(Key.W))
					{
						if (!collide("solid", x, y - 1))
							y -= 1;
					}
				}
				if (collide("player", x, y - 1))
				{
					p = player(collide("player", x, y - 1));
					if (p.gON() && Input.check(Key.S))
					{
						if (!collide("solid", x, y + 1))
							y += 1;
						if (!collide("solid", x, y + 1))
							y += 1;
					}
					if (!p.gON())
					{
						if (collide("grav", x + 1, y))
							if (!collide("solid", x - 1, y))
								x -= 1;
						if (collide("grav", x - 1, y))
							if (!collide("solid", x + 1, y))
								x += 1;
					}
				}
			}
			else if (gMove == gLateral)
			{
				move_by_push();
			}
		}
		
		private function sign(n:Number):int
		{
			var r:int;
			r = (Math.abs(n) / n);
			if (n == 0)
				r = 0;
			return r;
		}
		
		private function check_bounce():void
		{
			var l:Entity = collide("bounce", x, y + 1);
			if (l)
			{
				var g:bounce = bounce(l);
				if (g)
				{
					yspeed = -20;
				}
			}
		}
		
		override public function update():void
		{
			super.update();
			moved = false;
			movedBy = -1;
			
			gBlockStates();
			
			if (gOn == false)
			{
				check_bounce();
				motion();
				move_by_push();
			}
			else
			{
				gMotion();
			}
			
			check_bounce();
		}
		
		public function move(xdis:int, ydis:int):void
		{
			var i:int;
			if (moved == false)
			{
				for (i = 0; i < Math.abs(xdis); i++)
				{
					if (!collide("solid", x + sign(xdis), y))
						x += sign(xdis);
				}
				for (i = 0; i < Math.abs(ydis); i++)
				{
					if (!collide("solid", x, y + sign(xdis)))
						y += sign(ydis);
				}
			}
			moved = true;
		}
		
		public function pmove(xdis:int, id:int):Boolean
		{
			for (var i:int = 0; i < Math.abs(xdis); i++)
			{
				if (!collide("solid", x + sign(xdis), y) && !gOn && (movedBy == id || movedBy == -1))
				{
					x += sign(xdis);
					movedBy = id;
				}
				else
					return false;
			}
			return true;
		}
		
		private function motion():void
		{
			yspeed++;
			for (var i:int = 0; i < Math.abs(yspeed); i++)
			{
				if (!collide("solid", x, y + sign(yspeed)))
				{
					y += sign(yspeed);
				}
				else
				{
					yspeed = 0;
				}
			}
		}
		
		private function move_by_push():void
		{
			if (collide("player", x - 1, y))
			{
				if (player(collide("player", x - 1, y)).HP())
				{
					if (!collide("solid", x + 1, y))
					{
						x += 1;
					}
					else if (!collide("solid", x + 1, y - 1))
					{
						x += 1;
						y -= 1;
					}
					if (!collide("solid", x + 1, y))
					{
						x += 1;
					}
					else if (!collide("solid", x + 1, y - 1))
					{
						x += 1;
						y -= 1;
					}
				}
			}
			if (collide("player", x + 1, y))
			{
				if (player(collide("player", x + 1, y)).HP())
				{
					if (!collide("solid", x - 1, y))
					{
						x -= 1;
					}
					else if (!collide("solid", x - 1, y - 1))
					{
						x -= 1;
						y -= 1;
					}
					if (!collide("solid", x - 1, y))
					{
						x -= 1;
					}
					else if (!collide("solid", x - 1, y - 1))
					{
						x -= 1;
						y -= 1;
					}
				}
			}
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
				var q:Entity = super.collide("player", _x, _y);
				
				if (w) return w;
				if (s) return s;
				if (b) return b;
				if (f) return f;
				if (l) return l;
				if (c) return c;
				if (i) return i;
				if (g) return g;
				if (p) return p;
				if (q) return q;
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
				q = super.collide("player", _x, _y);
				
				if (w) return w;
				if (b) return b;
				if (f) return f;
				if (l) return l;
				if (c) return c;
				if (i) return i;
				if (g) return g;
				if (p) return p;
				if (q) return q;
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
				q = super.collide("player", _x, _y);
				
				if (w) return w;
				if (s) return s;
				if (b) return b;
				if (f) return f;
				if (l) return l;
				if (c) return c;
				if (g) return g;
				if (p) return p;
				if (q) return q;
			}
			return super.collide(type, _x, _y);
		}
	}
}