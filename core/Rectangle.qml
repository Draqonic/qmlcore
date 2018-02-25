/// Colored rectangle with optional rounded corners, border and/or gradient.
Item {
	property color color: "#ffffff";		///< rectangle background color
	property Gradient gradient;			///< if gradient object was set, it displays gradient instead of solid color
	constructor : {
		this._context.backend.initRectangle(this)
		this.style('background-color', _globals.core.normalizeColor(this.color))
	}
	
	function toString() {
		return "Rectangle (color: " + this.color + ", width: " + this.width + ", height: " + this.height + ", x: " + this.x + ", y: " + this.y + ")"
	}

	onColorChanged: {
		this.style('background-color', _globals.core.normalizeColor(value))
	}

	prototypeConstructor: {
		var styleMap = RectanglePrototype._propertyToStyle = Object.create(RectangleBasePrototype._propertyToStyle)
		styleMap['color'] = 'background-color'
	}
}
