package game.gui
{
	import flash.display.BitmapData;
	import game.gui.levelButton;
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import game.gameData;
	
	public class menu extends World
	{
		
		[Embed(source = '../../../assets/hline.png')] private const HLINE:Class;
		[Embed(source = '../../../assets/vline.png')] private const VLINE:Class;
		[Embed(source = '../../../assets/border.png')] private const BORDER:Class;
		[Embed(source = '../../../assets/black.png')] private const BL:Class;
		
		private var c:Canvas = new Canvas(640, 480);
		private var t:title = new title(240, 81);
		private var e:easy = new easy(275, 145);
		private var m:medium = new medium(252, 209);
		private var h:hard = new hard(275, 273);
		private var b:back = new back(100, 400);
		
		private var selectHeight:int;
		private var selectWidth:int;
		
		private var targetHeight:int;
		private var targetWidth:int;
		
		private var buttons:Array;
		
		private var showing:Boolean;
		private var xFin:Boolean;
		private var yFin:Boolean;
		
		public function menu()
		{
			selectHeight = 0;
			selectWidth = 0;
			
			targetHeight = 0;
			targetWidth = 0;
			
			showing = false;
			xFin = false;
			yFin = false;
			
			buttons = new Array;
			
			var i:int;
			if (gameData.isNew) // new game
			{
				gameData.isNew = false;
				for (i = 0; i < gameData.num_easy; i++)
				{
					gameData.easy_lev[i] = false;
				}
				
				for (i = 0; i < gameData.num_med; i++)
				{
					gameData.med_lev[i] = false;
				}
				
				for (i = 0; i < gameData.num_hard; i++)
				{
					gameData.hard_lev[i] = false;
				}
			}
			else // existing save data
			{
				//load();
			}
			
			c.fill(new Rectangle(0, 0, 640, 480), 0x00FFFFFF, .4);
			var vline:Image = new Image(VLINE);
			var hline:Image = new Image(HLINE);
			for (i = 0; i < 640; i += 16)
			{
				c.drawGraphic(0, i, hline);
				c.drawGraphic(i, 0, vline);
			}
			add(t);
			add(e);
			add(m);
			add(h);
			add(b);
		}
		
		override public function update():void
		{
			super.update();
			switch (collidePoint("button", mouseX, mouseY))
			{
			case t:
				t.press();
				if (Input.mousePressed && t.isVisible())
				{
					t.fadeIn();
					t.click();
					e.fadeOut();
					m.fadeOut();
					h.fadeOut();
					b.fadeIn();
					
					showSelect(t);
				}
				break;
			case e:
				e.press();
				if (Input.mousePressed && e.isVisible())
				{
					e.fadeIn();
					e.click();
					t.fadeOut();
					m.fadeOut();
					h.fadeOut();
					b.fadeIn();
					
					showSelect(e);
				}
				break;
			case m:
				m.press();
				if (Input.mousePressed && m.isVisible())
				{
					m.fadeIn();
					m.click();
					t.fadeOut();
					e.fadeOut();
					h.fadeOut();
					b.fadeIn();
					
					showSelect(m);
				}
				break;
			case h:
				h.press();
				if (Input.mousePressed && h.isVisible())
				{
					h.fadeIn();
					h.click();
					t.fadeOut();
					e.fadeOut();
					m.fadeOut();
					b.fadeIn();
					
					showSelect(h);
				}
				break;
			case b:
				b.press();
				if (Input.mousePressed && b.isVisible())
				{
					t.fadeIn();
					e.fadeIn();
					m.fadeIn();
					h.fadeIn();
					b.fadeOut();
					
					hideSelect();
				}
				break;
			default:
				t.unpress();
				e.unpress();
				m.unpress();
				h.unpress();
				b.unpress();
				break;
			}
		}
		
		private function showSelect(o:Object):void
		{
			showing = true;
			var n:int, i:int;
			switch (o)
			{
				case t:
					targetHeight = 10 * 16 + 1;
					targetWidth = 8 * 16 + 1;
					break;
				case e:
					for (i = 0; i < gameData.easy_unl; i++)
					{
						var lb:levelButton = new levelButton(i);
						lb.setButtonPosition();
						buttons.push(lb);
						if (!gameData.easy_lev[i])
						{
							n = i + 1;
							break;
						}
					}
					targetHeight = n * 16 + 1;
					targetWidth = 8 * 16 + 1;
					break;
				case m:
					for (i = 0; i < gameData.med_unl; i++)
					{
						lb = new levelButton(gameData.num_easy + i);
						lb.setButtonPosition();
						buttons.push(lb);
						if (!gameData.med_lev[i])
						{
							n = i + 1;
							break;
						}
						
					}
					targetHeight = n * 16 + 1;
					targetWidth = 8 * 16 + 1;
					break;
				case h:
					for (i = 0; i < gameData.hard_unl; i++)
					{
						lb = new levelButton(gameData.num_easy + gameData.num_med + i);
						lb.setButtonPosition();
						buttons.push(lb);
						if (!gameData.hard_lev[i])
						{
							n = i + 1;
							break;
						}
						
					}
					targetHeight = n * 16 + 1;
					targetWidth = 8 * 16 + 1;
					break;
			}
			for (i = 0; i < buttons.length; i++)
			{
				this.add(buttons[i]);
			}
		}
		
		private function hideSelect():void
		{
			targetHeight = 0;
			targetWidth = 0;
			for (var i:int = 0; i < buttons.length; i++)
			{
				this.remove(buttons[i]);
			}
			buttons = new Array();
		}
		
		override public function render():void
		{			
			var can:Canvas = new Canvas(640, 480);
			can.drawGraphic(0, 0, c);
			can.fill(new Rectangle(Math.floor(mouseX / 16) * 16, Math.floor(mouseY / 16) * 16, 16, 16), 0xFFFF0000, 1);
			can.drawGraphic(0, 0, new Image(BORDER));
			can.render(new Point(0, 0), new Point(0, 0));
			
			if (showing)
			{
				if (selectHeight < targetHeight)
				{
					selectHeight += 10;
					if (selectHeight >= targetHeight)
					{
						selectHeight = targetHeight;
						xFin = true;
					}
				}
				if (selectWidth < targetWidth)
				{
					selectWidth += 10;
					if (selectWidth >= targetWidth)
					{
						selectWidth = targetWidth;
						yFin = true;
					}
				}
				
				if (selectHeight > targetHeight)
				{
					selectHeight -= 10;
					if (selectHeight <= targetHeight)
					{
						selectHeight = targetHeight;
					}
				}
				if (selectWidth > targetWidth)
				{
					selectWidth -= 10;
					if (selectWidth <= targetWidth)
					{
						selectWidth = targetWidth;
					}
				}
				
				if (xFin && yFin)
				{
					// add buttons
					xFin = false;
					yFin = false;
					var j:int = 0;
					for (j = 0; j < buttons.length; j++)
					{
						add(buttons[j]);
					}
				}
				
				if (selectHeight == 0 || selectWidth == 0)
				{
					showing = false;
					selectHeight = 0;
					selectWidth = 0;
				}
				else
				{
					var canSelect:Canvas = new Canvas(selectWidth, selectHeight);
					
					canSelect.fillTexture(new Rectangle(0, 0, selectWidth - 1, 1),
										  new BitmapData(selectWidth, 1, false, 0x00000000));	// top
					canSelect.fillTexture(new Rectangle(0, 0, 1, selectHeight - 1),
										  new BitmapData(1, selectHeight, false, 0x00000000)); 	// left side
					canSelect.fillTexture(new Rectangle(selectWidth - 1, 0, 1, selectHeight - 1),
										  new BitmapData(1, selectHeight, false, 0x00000000)); 	// right side
					canSelect.fillTexture(new Rectangle(0, selectHeight - 1, selectWidth, 1),
										  new BitmapData(selectWidth, 1, false, 0x00000000));	// bottom
					
					if (((targetHeight - 1) / 16) % 2 == 0)
						canSelect.render(new Point(320 - selectWidth / 2 + 1, 240 - selectHeight / 2 + 1), new Point(0, 0));
					else
						canSelect.render(new Point(320 - selectWidth / 2 + 1, 240 - selectHeight / 2 - 7), new Point(0, 0));
				}
			}
			super.render();
		}
	}
}