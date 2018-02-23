/**
@private
Component aimed to adjust individual preferences of each border side
*/

Object {
	property string name;
	property int width: parent.width;
	property color color: parent.color;
	property int style: parent.style;

	function _updateStyle() {
		if (!this.parent || !this.parent.parent || !this.name)
			return
		
		var styleName
		switch(this.style) {
 		case Border.None: styleName = 'none'; break
 		case Border.Hidden: styleName = 'hidden'; break
 		case Border.Dotted: styleName = 'dotted'; break
 		case Border.Dashed: styleName = 'dashed'; break
 		case Border.Solid: styleName = 'solid'; break
 		case Border.Double: styleName = 'double'; break
 		case Border.Groove: styleName = 'groove'; break
 		case Border.Ridge: styleName = 'ridge'; break
 		case Border.Inset: styleName = 'inset'; break
 		case Border.Outset: styleName = 'outset'; break
 		}
			
		var bordercss = this.width + "px " + styleName + " " + _globals.core.normalizeColor(this.color)
		this.parent.parent.style('border-' + this.name, bordercss)
		if (this.name === "left" || this.name === "top")
			this.parent.parent.style('margin-' + this.name, -this.width)
	}

	onWidthChanged,
	onColorChanged,
	onStyleChanged: { this._updateStyle() }
}
