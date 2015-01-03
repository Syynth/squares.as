package game
{	
	public class gameData
	{
		public static var level:uint = 0;
		
		public static var easy_lev:Array = new Array();
		public static var med_lev:Array = new Array();
		public static var hard_lev:Array = new Array();
		
		public static const num_easy:uint = 10;
		public static var   easy_unl:uint = 3; // first level starts unlocked
		
		public static const num_med:uint = 10;
		public static var   med_unl:uint = 1;
		
		public static const num_hard:uint = 10;
		public static var   hard_unl:uint = 1;
		
		public static var Load:Function;
		
		public static var isNew:Boolean = true;
		
	}
}