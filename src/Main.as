package 
{
	import adobe.utils.CustomActions;
	import game.gui.menu;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import game.*;
	import splash.Splash;
	
	/**
	 * ...
	 * @author Ben Cochrane
	 */
	public class Main extends Engine
	{
		public function Main():void 
		{
			super(640, 480, 30, false);
			var s:Splash = new Splash;
			FP.world.add(s);
			s.start(splashComplete);
		}
		
		public function splashComplete():void
		{
			FP.world = new menu();
		}
		
		override public function update():void
		{
			super.update();
			if (Input.pressed(Key.ENTER))
			{
				FP.world = new Level(1);
			}
		}
	}
}