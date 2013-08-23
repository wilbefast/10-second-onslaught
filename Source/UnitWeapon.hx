class UnitWeapon
{
	public var range : Float;
	public var reloadDuration : Float;
	public var timeTillReloaded : Float = 0;
	public var fireAt : Unit->Void;

	public function new(_range : Float, _reloadDuration : Float, _fireAt : Unit->Void)
	{
		range = _range;
		reloadDuration = _reloadDuration;
		fireAt = _fireAt;
	}

	public function reload() : Void
	{
		timeTillReloaded = Math.max(0, timeTillReloaded - Time.getDelta());
	}
}