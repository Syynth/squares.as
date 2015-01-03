package game
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	public class goal extends Entity
	{
		[Embed(source = '../../assets/goal.png')] 
		private const GOAL:Class;
		private var sprGoal:Spritemap = new Spritemap(GOAL, 17, 16);
		private var callback:Function;
		public function goal(...args)
		{
			sprGoal.add("anim", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], 30, true);
			graphic = sprGoal;
			sprGoal.play("anim");
			type = "goal";
			setHitbox(16, 16);
			switch (args.length)
			{
			case 2: // x:int, y:int
				x = args[0];
				y = args[1];
				break;
			case 3: // x:int, y:int, callback:Function
				x = args[0];
				y = args[1];
				callback = args[2];
				break;
			}
		}
		
		public function execute_callback():void
		{
			callback();
		}
	}
}