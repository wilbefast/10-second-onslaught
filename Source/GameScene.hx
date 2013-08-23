import flash.events.MouseEvent;

class GameScene extends Scene
{
	private var gameState : Bool ; //true deploy, false attack
	private var session : Session ;
	
	public function new (ptimer : Int) 
	{
		super ();
		gameState = true ;
		session = new Session(ptimer);
	}
	
	public override function onEnter(previous : Scene) : Void 
	{
		if(gameState) playDeployPhase();
	}
	
	//changer par un clic bouton ou la fin du décompte
	public override function onMouseClick(event : MouseEvent) : Void
	{
		switchPhase();
		if (gameState) playDeployPhase();
		else playAttackPhase();
	}
	
	private function switchPhase()
	{
		if (gameState) gameState = false ;
		else
		{
			gameState = true ;
			session.incrementNbReplay();
		}
		trace("gameState : " + gameState + " " + session.getTimer() + " nbReplay :" + session.getNbReplay() );
	}
	
	private function playDeployPhase()
	{
			// clear all dudes
		GameObjectManager.purgeAll();

		trace("playDeploy");
		while (numChildren > 0) this.removeChildAt(0);
		addChild (new DefaultTextField("Deploy your dudes!", 200, 200));


	}
	
	private function playAttackPhase()
	{
		// clear all dudes
		GameObjectManager.purgeAll();

		trace("playAttack");
		while (numChildren > 0) this.removeChildAt(0);
		addChild (new DefaultTextField("Alien Attack !!!", 200, 200));


		// ------------------------------------------------------------------------------
		// PLACEHOLDER TEST CODE : these dudes should be spawned based on deploy
		// ------------------------------------------------------------------------------

		// create dudes
		var spawn_width = 400; // TODO - get from stage.stageWidth
		var spawn_height = 300; // TODO - get from stage.stageWidth

		// create zerglings
		for(i in 0 ... 30)
		{
			var spawn_angle = Math.random()*Math.PI*2;
			new Zergling((1 + Math.cos(spawn_angle))*spawn_width, 
										(1 + Math.sin(spawn_angle))*spawn_height);
		}

		// create marines// ------------------------------------------------------------------------------
		for(i in 0 ... 10)
		{
			var spawn_angle = Math.random()*Math.PI*2;
			new Marine((3 + Math.cos(spawn_angle))*spawn_width/3, 
										(3 + Math.sin(spawn_angle))*spawn_height/3);
		}

	}
}