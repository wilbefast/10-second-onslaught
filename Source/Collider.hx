class Collider : Component
{
	public var width : Float;
	public var height : Float;
	public var offset : { x : Float, y : Float};

	public new(_width : Float, _height : Float, ?_offset_x : Float = 0, ?_offset_y : Float = 0)
	{
		super();

		this.width = _width;
		this.height = _height;
		offset = { x : _offset_x, y : _offset_y }; 
	}
}