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
		trace("playDeploy");
		while (numChildren > 0) this.removeChildAt(0);
		addChild (new DefaultTextField("Deploy your dudes!", 200, 200));
	}
	
	private function playAttackPhase()
	{
		trace("playAttack");
		while (numChildren > 0) this.removeChildAt(0);
		addChild (new DefaultTextField("Alien Attack !!!", 200, 200));
	}
}