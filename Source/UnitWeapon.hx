class UnitWeapon
{
	public var range : Float;
	public var reloadDuration : Float;
	public var timeTillReloaded : Float = 0;
	public var onFire : Unit->Void;

	public function new(_range : Float, _reloadDuration : Float, _onFire : Unit->Void)
	{
		range = _range;
		reloadDuration = _reloadDuration;
		onFire = _onFire;
	}

	public function reload() : Void
	{
		timeTillReloaded = Math.max(0, timeTillReloaded - Time.getDelta());
	}

	public function fireAt(target : Unit) : Void
	{
		timeTillReloaded = reloadDuration;
		onFire(target);
	}
}