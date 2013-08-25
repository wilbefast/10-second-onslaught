import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;

class DeployUI extends Sprite 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var background_data : BitmapData;
	
	private static var session_attribut : Session;

	private static function init() : Void
	{
		background_data = Assets.getBitmapData("assets/GabariGUI_01.png");
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var replaysCounter : ReplaysCounterUI;
	private var resourcesCounter : ResourcesCounterUI;
	private var buyMarine : BuyUI;
	private var buyNuke : BuyUI;
	private var startButton : StartButtonUI;

	private var background : Bitmap;

	public function new(session : Session)
	{
		super();
		session_attribut = session;

		if(!initialised)
			init();

		background = new Bitmap(background_data);
		addChild(background);

		replaysCounter = new ReplaysCounterUI(session_attribut);
		addChild(replaysCounter);

		resourcesCounter = new ResourcesCounterUI(session_attribut);
		addChild(resourcesCounter);

		buyMarine = new BuyUI("assets/GUI_ic_marine_01.png"); // TODO - parameters
		addChild(buyMarine);

		buyNuke = new BuyUI("assets/GUI_ic_bombe_01.png"); // TODO - parameters
		addChild(buyNuke);

		startButton = new StartButtonUI();
		addChild(startButton);

		recalculateLayout();
	}

	public function recalculateLayout() : Void
	{
		// size
		if(stage != null)
		{
			background.width = stage.stageWidth;
			
			buyMarine.width = buyNuke.width = stage.stageWidth*0.5;
			resourcesCounter.width = replaysCounter.width = stage.stageWidth*0.3;
			startButton.width = Math.min(startButton.height, stage.stageWidth*0.2);

			var rightmost = Math.max(buyMarine.x + buyMarine.width, buyNuke.x + buyNuke.width);
			startButton.x = rightmost + (stage.stageWidth - rightmost - startButton.width)/2;
		}

		// position
		resourcesCounter.y = replaysCounter.height;
		buyMarine.x = replaysCounter.width;
		buyNuke.x = resourcesCounter.width;
		buyNuke.y = buyMarine.y + buyMarine.height;
	}


	// var mapBitmap : Bitmap = new Bitmap(mapD_bd) ;
	// var uiBitmap : Bitmap = new Bitmap(uiD_bd) ;
	// mapBitmap.x = 12 ;
	// uiBitmap.x = 12 ;
	// mapBitmap.y = 12 ;
	
	// uiBitmap.y = mapBitmap.height + timelineBitmap.height + 12;
	// map.addChild(mapBitmap);
	// ui.addChild(uiBitmap);
	// addChild(ui);
	// addChild(map);
	// addChild(timeline);
	
	// // Score
	// var replayBitmap : Bitmap = new Bitmap(replayD_bd);
	// replayBitmap.x = 20 ;
	// replayBitmap.y = uiBitmap.y ;
	// replay.addChild(replayBitmap);
	// addChild(replay);
	// addChild (new DefaultTextField("" + session.getNbReplay() , 160, uiBitmap.y ));
	// var moneyBitmap : Bitmap = new Bitmap(moneyD_bd);
	// moneyBitmap.x = 20 ;
	// moneyBitmap.y = uiBitmap.y + replayBitmap.height ;
	// money.addChild(moneyBitmap);
	// addChild(money);
	// addChild (new DefaultTextField("" + session.getMoney() , 150, uiBitmap.y + replayBitmap.height + 50 ));
	
	// // Achat d'units
	// var buyingMarinesBitmap : Bitmap = new Bitmap(buyingMarinesD_bd);
	// buyingMarinesBitmap.x = moneyBitmap.width ;
	// buyingMarinesBitmap.y = uiBitmap.y ;
	// buyingMarines.addChild(buyingMarinesBitmap);
	// addChild(buyingMarines);
	
	// var moreMarinesBitmap : Bitmap = new Bitmap(moreUnitsD_bd);
	// moreMarinesBitmap.x = moneyBitmap.width + buyingMarinesBitmap.width ;
	// moreMarinesBitmap.y = uiBitmap.y ;
	// moreMarines.addChild(moreMarinesBitmap);
	// addChild(moreMarines);
		
	// // Champ indiquant le nombre de marines
	// var centernbMarinesWidth = moreMarinesBitmap.x + moreMarinesBitmap.width/2 ;
	// var centernbMarinesHeight = uiBitmap.y + buyingMarinesBitmap.height/2 ;
	// addChild (new DefaultTextField("0", centernbMarinesWidth, centernbMarinesHeight ));
	
	// // Calcul de la hauteur
	// var yLessMarines = uiBitmap.y + buyingMarinesBitmap.height - moreMarinesBitmap.height ;
	// var lessMarinesBitmap : Bitmap = new Bitmap(lessUnitsD_bd);
	// lessMarinesBitmap.x = moneyBitmap.width + buyingMarinesBitmap.width ;
	// lessMarinesBitmap.y = yLessMarines ;
	// lessMarines.addChild(lessMarinesBitmap);
	// addChild(lessMarines);
	
	// // Champ pour le cout des marines
	// var marinesCostBitmap : Bitmap = new Bitmap(unitCostD_bd);
	// marinesCostBitmap.x = moreMarinesBitmap.x + moreMarinesBitmap.width;
	// marinesCostBitmap.y = uiBitmap.y ;
	// marinesCost.addChild(marinesCostBitmap);
	// addChild(marinesCost);
	
	// var buyingBombsBitmap : Bitmap = new Bitmap(buyingBombsD_bd);
	// buyingBombsBitmap.x = moneyBitmap.width ;
	// buyingBombsBitmap.y = uiBitmap.y + buyingMarinesBitmap.height ;
	// buyingBombs.addChild(buyingBombsBitmap);
	// addChild(buyingBombs);
	
	// var moreBombsBitmap : Bitmap = new Bitmap(moreUnitsD_bd);
	// moreBombsBitmap.x = moneyBitmap.width + buyingBombsBitmap.width ;
	// moreBombsBitmap.y = uiBitmap.y + buyingMarinesBitmap.height ;
	// moreBombs.addChild(moreBombsBitmap);
	// addChild(moreBombs);
	
	// // Calcul de la hauteur
	// var yLessBombs = uiBitmap.y + buyingMarinesBitmap.height + buyingMarinesBitmap.height - moreMarinesBitmap.height ;
	// var lessBombsBitmap : Bitmap = new Bitmap(lessUnitsD_bd);
	// lessBombsBitmap.x = moneyBitmap.width + buyingMarinesBitmap.width ;
	// lessBombsBitmap.y = yLessBombs ;
	// lessBombs.addChild(lessBombsBitmap);
	// addChild(lessBombs);
	
	// // Champ indiquant le nombre de bombes
	// var centernbBombsWidth = moreBombsBitmap.x + moreBombsBitmap.width/2 ;
	// var centernbBombsHeight = uiBitmap.y + buyingMarinesBitmap.height + buyingBombsBitmap.height/2 ;
	// addChild (new DefaultTextField("0", centernbBombsWidth, centernbBombsHeight ));
	
	// // Champ pour le cout des bombes
	// var bombsCostBitmap : Bitmap = new Bitmap(unitCostD_bd);
	// bombsCostBitmap.x = moreBombsBitmap.x + moreBombsBitmap.width;
	// bombsCostBitmap.y = uiBitmap.y + buyingMarinesBitmap.height  ;
	// bombsCost.addChild(bombsCostBitmap);
	// addChild(bombsCost);
	
	// // Button to switch to attack phase
	// var buttonSwitchToAttack : ButtonDeployEnd = new ButtonDeployEnd(this);
	// buttonSwitchToAttack.x = bombsCostBitmap.x + bombsCostBitmap.width ;
	// buttonSwitchToAttack.y = uiBitmap.y ;
	// addChild(buttonSwitchToAttack);
}