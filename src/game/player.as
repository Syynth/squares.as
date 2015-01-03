package game
{
	import adobe.utils.CustomActions;
	import flash.display.PixelSnapping;
	import flash.utils.Endian;
	import net.flashpunk.Entity;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
		
	public class player extends Entity
	{
		[Embed(source = '../../assets/player.png')]
		private const PLAYER:Class;
		[Embed(source = '../../assets/playermask.png')]
		private const PMASK:Class;
		[Embed(source = '../../assets/rotmask.png')]
		private const PMASKR:Class;
		
		public var sprPlayer:Spritemap = new Spritemap(PLAYER, 16, 16, playerDie);
		public var mskPlayer:Pixelmask = new Pixelmask(PMASK, 0, 0);
		public var mskPlayerR:Pixelmask = new Pixelmask(PMASKR, 0, -11);
		
		private var xspeed:Number;
		private var yspeed:Number;
		private var vspeed:Number;
		private var hp:Boolean;
		private var vp:Boolean;
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
		
		public function player(...args)
		{
			sprPlayer.add("player", [0], 0, false);
			sprPlayer.add("death", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24], 30, true);
			graphic = sprPlayer;
			mask = mskPlayer;
			sprPlayer.play("player");
			type = "player";			
			xspeed = 0;
			yspeed = 0;
			dir = 0;
			gOn = false;
			gDir = gLateral;
			gMove = gUp;
			
			switch (args.length)
			{
			case 2: // x:int, y:int
				x = args[0];
				y = args[1];
				xstart = x;
				ystart = y;
				break;
			default:
				xstart = 0;
				ystart = 0;
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
				get_horizontal_speed();
			}
		}
		
		private function gMotion():void
		{
			get_horizontal_speed();
			vspeed = get_vertical_speed();
			image_angle();
			if (gMove == gLateral || gMove == gDiag)
			{
				if (gMove != gUp)
				for (var i:int = 0; i < Math.abs(xspeed); i++)
				{
					if (!collide("solid", x + sign(xspeed), y) && hp == true)
					{
						x += sign(xspeed);
					}
					yspeed = 0;
				}
				else
					motion();
			}
			if (gMove == gVertical || gMove == gDiag)
			{
				for (i = 0; i < Math.abs(vspeed); i++)
				{
					if (!collide("solid", x, y + sign(vspeed)) && vp == true)
					{
						y += sign(vspeed);
					}
				}
				yspeed = 0;
			}
			
			if (Input.pressed(Key.SPACE))
			{
				if (collide("grav", x + 1, y) && !collide("solid", x - 1, y))
					x -= 1;
				if (collide("grav", x - 1, y) && !collide("solid", x + 1, y))
					x += 1;
				if (collide("grav", x, y - 1) && !collide("solid", x, y + 1))
					y += 1;
			}
		}
		
		public function playerDie():void
		{
			sprPlayer.play("player");
			x = xstart;
			y = ystart;
			xspeed = 0;
			yspeed = 0;
		}
		
		private function get_horizontal_speed():void
		{
			if (Input.pressed(Key.A))
				xspeed = -6;
			if (Input.pressed(Key.D))
				xspeed = 6;
				
			if (Input.released(Key.A) && Input.check(Key.D))
				xspeed = 6;
			if (Input.released(Key.D) && Input.check(Key.A))
				xspeed = -6;
				
			if (Input.check(Key.A) || Input.check(Key.D))
				hp = true;
			else
				hp = false;
		}
		
		private function get_vertical_speed():int
		{
			var r:int = vspeed;
				
			if (Input.pressed(Key.W))
				r = -6;
			if (Input.pressed(Key.S))
				r = 6;
				
			if (Input.released(Key.W) && Input.check(Key.S))
				r = 6;
			if (Input.released(Key.S) && Input.check(Key.W))
				r = -6;
				
			if (Input.check(Key.W) || Input.check(Key.S))
				vp = true;
			else
				vp = false;
				
			return r;
		}
		
		private function sign(n:Number):int
		{
			var r:int;
			r = (Math.abs(n) / n);
			if (n == 0)
				r = 0;
			return r;
		}
		
		public function HP():Boolean
		{
			return hp;
		}
		
		public function YSPEED():Number
		{
			return yspeed;
		}
		
		public function gON():Boolean
		{
			return gOn;
		}
		
		private function Lkp():void
		{
			if (Input.pressed(Key.SPACE) || Math.abs(yspeed) > 2)
			{
				LKP = false;
			}
			if (Input.check(Key.A))
			{
				LKP = true;
				dir = -1;
			}
			if (Input.check(Key.D))
			{
				LKP = true;
				dir = 1;
			}
		}
		
		override public function update():void
		{
			movedBy = -1;
			moved = false;
			vspeed = get_vertical_speed();
			check_death();
			check_win();
			gBlockStates();
			if (gOn == false)
			{
				check_bounce();
				check_ice();
				motion();
			}
			else
			{
				gMotion();
			}
			image_angle();
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
		
		private function check_death():void
		{
			var l:Entity = collide("lava", x, y + 1);
			if (l)
				sprPlayer.play("death");
				
			l = collide("lava", x, y - 1);
			if (l)
				sprPlayer.play("death");
				
			l = collide("lava", x + 1, y);
			if (l)
				sprPlayer.play("death");
				
			l = collide("lava", x - 1, y);
			if (l)
				sprPlayer.play("death");
		}
		
		private function check_win():void
		{
			var l:Entity = collide("goal", x, y + 1);
			if (l)
			{
				var g:goal = goal(l);
				if (g)
					g.execute_callback();
			}
				
			l = collide("goal", x, y - 1);
			if (l)
			{
				g = goal(l);
				if (g)
					g.execute_callback();
			}
				
			l = collide("goal", x + 1, y);
			if (l)
			{
				g = goal(l);
				if (g)
					g.execute_callback();
			}
			
			l = collide("goal", x - 1, y);
			if (l)
			{
				g = goal(l);
				if (g)
					g.execute_callback();
			}
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
		
		private function check_ice():void
		{
			Lkp();
			if (collide("ice", x, y + 1) && !collide("solid_1", x, y + 1))
			{
				for (var i:int = 0; i < 6; i++)
				{
					if (!collide("solid", x + dir, y) && LKP)
					{
						x += dir;
					}
				}
			}
		}
		
		private function motion():void
		{
			if (Input.pressed(Key.F))
				sprPlayer.play("death");
			yspeed += 1;
			
			if (Input.pressed(Key.SPACE) && (collide("solid", x, y+1) || collide("water", x, y)))
			{
				yspeed -= 16;
				yspeed = Math.max( -16, yspeed);
			}
			
			get_horizontal_speed();
			if (hp == false)
				xspeed = 0;
			
			var i:int;
			for (i = 0; i < Math.abs(xspeed); i++)
			{
				if (!collide("solid", x + sign(xspeed), y + 1) && collide("solid", x + sign(xspeed), y + 2))
				{
					x += sign(xspeed);
					y += 1;
				}
				else if (!collide("solid", x + sign(xspeed), y))
				{
					x += sign(xspeed);
				}
				else if (!collide("solid", x + sign(xspeed), y - 1))
				{
					x += sign(xspeed);
					y -= 1;
				}
			}
			
			for (i = 0; i < Math.abs(yspeed); i++)
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
		
		private function image_angle():void
		{
			if (getAngle() == 0)
			{
				if (!collide("solid_0", x, y + 1))
				{
					var e:Entity = collide("slope", x, y + 1);
					if (e)
					{
						setAngle(45);
						var _wall:Entity = collide("solid", x, y);
						if (_wall)
						{
							if (Math.abs(x - _wall.x) > Math.abs(y - _wall.y))
							{
								while (collide("solid", x, y))
								{
									x += sign(x - _wall.x);
								}
							}
							else
							{
								while (collide("solid", x, y))
								{
									y += sign(y - _wall.y);
								}
							}
						}
						while (!collide("slope", x, y + 1) && !collide("solid", x, y + 1))
						{
							y += 1;
						}
						if (!collide("slope", x, y + 1) && collide("solid", x, y + 1))
						{
							var safe:int = 0;
							if (e is slopeR)
							{
								safe = 0;
								while (!collide("slope", x + 1, y) && !collide("solid", x + 1, y) && safe < 10)
								{
									x += 1;
									safe++;
								}
							}
							else if (e is slopeL)
							{
								safe = 0;
								while (!collide("slope", x - 1, y) && !collide("solid", x - 1, y) && safe < 10)
								{
									x -= 1;
									safe++;
								}
							}
						}
					}
				}
			}
			else if (getAngle() == 45)
			{
				if (!collide("slope", x, y + 1))
				{
					setAngle(0);
					while (collide("slope", x, y))
						y -= 1;
					var wall:Entity = collide("solid", x, y);
					while (wall)
					{
						wall = collide("solid", x, y);
						if (wall)
						{
							if (Math.abs(x - wall.x) > Math.abs(y - wall.y))
							{
								while (collide("solid", x, y))
								{
									x += sign(x - wall.x);
								}
							}
							else
							{
								while (collide("solid", x, y))
								{
									y += sign(y - wall.y);
								}
							}
						}
					}
				}
			}
		}
		
		private function setAngle(angle:Number):void
		{
			Spritemap(graphic).angle = angle;
			if (angle == 0)
			{				
				mask = mskPlayer;
			}
			if (angle == 45)
			{				
				mask = mskPlayerR;
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
				var u:Entity = super.collide("push", _x, _y);
				
				if (w) return w;
				if (s) return s;
				if (b) return b;
				if (f) return f;
				if (l) return l;
				if (c) return c;
				if (i) return i;
				if (g) return g;
				if (p) return p;
				if (u) return u;
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
				u = super.collide("push", _x, _y);
				
				if (w) return w;
				if (b) return b;
				if (f) return f;
				if (l) return l;
				if (c) return c;
				if (i) return i;
				if (g) return g;
				if (p) return p;
				if (u) return u;
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
				u = super.collide("push", _x, _y);
				
				if (w) return w;
				if (s) return s;
				if (b) return b;
				if (f) return f;
				if (l) return l;
				if (c) return c;
				if (g) return g;
				if (p) return p;
				if (u) return u;
			}
			return super.collide(type, _x, _y);
		}
		
		private function getAngle():Number
		{
			return Spritemap(graphic).angle;
		}
	}
}