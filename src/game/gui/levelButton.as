package game.gui
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import flash.geom.Point;
	import game.*;
	
	public class levelButton extends Entity
	{
		
		[Embed(source = '../../../assets/redback.PNG')] private const REDBACK:Class;
		[Embed(source = '../../../assets/checkempty.PNG')] private const CHECKEMP:Class;
		[Embed(source = '../../../assets/checkfull.PNG')] private const CHECKFUL:Class;
		
		private var level_id:uint;
		
		private var rback:Image = new Image(REDBACK);
		private var chemp:Image = new Image(CHECKEMP);
		private var chful:Image = new Image(CHECKFUL);
		
		private var complete:Boolean;
		
		private var totalAlpha:Number;
		
		public function levelButton(lv_id:int)
		{
			graphic = rback;
			setHitbox(128, 16);
			complete = gameData.easy_lev[lv_id];
			type = "l_button";
			level_id = lv_id;
			totalAlpha = 0;
			x = 0;
			y = 0;
		}
		
		public function setPosition(x:int, y:int):void
		{
			this.x = x;
			this.y = y;
		}
		
		public override function update():void
		{
			if (Input.mousePressed && collidePoint(x, y, Input.mouseX, Input.mouseY))
			{
				//gameData.Load(level_id);
			}
			if (collidePoint(x, y, Input.mouseX, Input.mouseY))
			{
				rback.alpha = .6;
			}
			else
			{
				rback.alpha = .1;
			}
			if (totalAlpha < 1)
			{
				totalAlpha += .05;
				if (totalAlpha > 1)
					totalAlpha = 1;
			}
		}
		
		public override function render():void
		{
			var a:Number = rback.alpha;
			rback.alpha = a * totalAlpha;
			super.render();
			rback.alpha = a;
			chemp.alpha = totalAlpha;
			chful.alpha = totalAlpha;
			var c:Canvas = new Canvas(16, 16);
			if (!complete)
				c.drawGraphic(0, 0, chemp);
			else
				c.drawGraphic(0, 0, chful);
			c.render(new Point(x + 112, y), new Point());
		}
		
		public function setButtonPosition():void
		{
			x = 240 + 16;
			if (level_id < gameData.num_easy)
			{
				y = 232 - (gameData.easy_unl / 2 - level_id) * 16;
			}
			else if (level_id < (gameData.num_easy + gameData.num_med))
			{
				y = 232 - (gameData.med_unl / 2 - (level_id - gameData.num_easy)) * 16;
			}
			else if (level_id < (gameData.num_easy + gameData.num_med + gameData.num_hard))
			{
				y = 232 - (gameData.hard_unl / 2 - (level_id - (gameData.num_easy + gameData.num_med))) * 16;
			}
			else // menu buttons
			{
				
			}
		}
	}
}