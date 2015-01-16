package packpan.nodes 
{
	import cobaltric.ABST_ContainerGame;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import packpan.mails.ABST_Mail;
	import packpan.PP;
	
	/**
	 * A normal conveyor belt
	 * @author Alexander Huynh
	 */
	public class NodeConveyorNormal extends ABST_Node 
	{
		public var speed:Number = 1;
		
		public function NodeConveyorNormal(_cg:ABST_ContainerGame, _type:String, _position:Point,
										   _facing:int, _clickable:Boolean)
		{
			super(_cg, _type, _position, _facing, _clickable);
			
			if (facing != PP.DIR_NONE)
				mc_node.rotation = facing;
			else
				trace("WARNING: NodeConveyorNormal at " + position + " has no facing!");
		}
		
		
		override public function onClick(e:MouseEvent):void
		{
			switch (facing)
			{
				case PP.DIR_RIGHT:
					facing = PP.DIR_LEFT;
				break;
				case PP.DIR_UP:
					facing = PP.DIR_DOWN;
				break;
				case PP.DIR_LEFT:
					facing = PP.DIR_RIGHT;
				break;
				case PP.DIR_DOWN:
					facing = PP.DIR_UP;
				break;
			}
			
			mc_node.rotation = facing;
			//trace("new facing: " + facing);
		}
		
		/**
		 * Called by a Mail object to manipulate the Mail object
		 * @param	mail	the Mail to be affected
		 */
		override public function affectMail(mail:ABST_Mail):void
		{
			//trace("Conveyor is affecting: " + mail + " with facing " + facing);
			switch (facing)
			{
				case PP.DIR_RIGHT:
					mail.mc_mail.x += speed;
					if (Math.abs(mail.mc_mail.y - mc_node.y) < 1.5 * speed)
						mail.mc_mail.y = mc_node.y;
					else if (mail.mc_mail.y > mc_node.y)
						mail.mc_mail.y -= speed;
					else
						mail.mc_mail.y += speed;
				break;
				case PP.DIR_UP:
					if (Math.abs(mail.mc_mail.x - mc_node.x) < 1.5 * speed)
						mail.mc_mail.x = mc_node.x;
					else if (mail.mc_mail.x > mc_node.x)
						mail.mc_mail.x -= speed;
					else
						mail.mc_mail.x += speed;
					mail.mc_mail.y -= speed;
				break;
				case PP.DIR_LEFT:
					mail.mc_mail.x -= speed;
					if (Math.abs(mail.mc_mail.y - mc_node.y) < 1.5 * speed)
						mail.mc_mail.y = mc_node.y;
					else if (mail.mc_mail.y > mc_node.y)
						mail.mc_mail.y -= speed;
					else
						mail.mc_mail.y += speed;
				break;
				case PP.DIR_DOWN:
					if (Math.abs(mail.mc_mail.x - mc_node.x) < 1.5 * speed)
						mail.mc_mail.x = mc_node.x;
					else if (mail.mc_mail.x > mc_node.x)
						mail.mc_mail.x -= speed;
					else
						mail.mc_mail.x += speed;
					mail.mc_mail.y += speed;
				break;
				default:
					trace("WARNING: " + this + " has no facing at " + position);
			}
		}
	}
}