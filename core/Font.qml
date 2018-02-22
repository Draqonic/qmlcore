/// adjusts text font properties
Object {
	property string family: manifest.style.font.family;		///< font family
	property bool italic;		///< applies italic style
	property bool bold;			///< applies bold style
	property bool underline;	///< applies underline style
	property bool overline;	///< applies overline style
	property bool strike;		///< line throw text flag
	property bool strikeout;		///< line throw text flag for compatibility with QML
	property real letterSpacing;	///< spacing between letters
	property real wordSpacing;	///< spacing between words
	property int pixelSize: manifest.style.font.pixelSize;		///< font size in pixels
	property int pointSize;		///< font size in points
	property real lineHeight: manifest.style.font.lineHeight;	///< font line height in font heights
	property int weight;		///< font weight value
	property enum capitalization { MixedCase, AllUppercase, AllLowercase, SmallCaps, Capitalize };

	///@private
	function _updateTextDecoration() {
		var decoration = (this.underline ? ' underline' : '')
			+ (this.overline ? ' overline' : '')
			+ (this.strike || this.strikeout ? ' line-through' : '')
		this.parent.style('text-decoration', decoration)
		this._updateParentSize()
	}
	
	///@private
	function _updateParentSize() {
		this.parent._updateSize()
		this.parent.fontChanged()
	}

	onFamilyChanged:		{ this.parent.style('font-family', value); this._updateParentSize() }
	onPointSizeChanged:		{ if (value > 0) this.pixelSize = 0; this.parent.style('font-size', value > 0? value + 'pt': ''); this._updateParentSize() }
	onPixelSizeChanged:		{ if (value > 0) this.pointSize = 0; this.parent.style('font-size', value > 0? value + 'px': ''); this._updateParentSize() }
	onItalicChanged: 		{ this.parent.style('font-style', value? 'italic': 'normal'); this._updateParentSize() }
	onBoldChanged: 			{ this.parent.style('font-weight', value? 'bold': 'normal'); this._updateParentSize() }
	onUnderlineChanged:		{ this._updateTextDecoration() }
	onOverlineChanged:		{ this._updateTextDecoration() }
	onStrikeChanged,
	onStrikeoutChanged:		{ this._updateTextDecoration() }
	onLineHeightChanged:	{ this.parent.style('line-height', value); this._updateParentSize() }
	onWeightChanged:		{ this.parent.style('font-weight', value); this._updateParentSize() }
	onLetterSpacingChanged:	{ this.parent.style('letter-spacing', value + "px"); this._updateParentSize() }
	onWordSpacingChanged:	{ this.parent.style('word-spacing', value + "px"); this._updateParentSize() }
	onCapitalizationChanged:	{
		this.parent.style('text-transform', 'none');
		this.parent.style('font-variant', 'normal');
		switch(value) {
 		case this.AllUppercase: this.parent.style('text-transform', 'uppercase'); break
 		case this.AllLowercase: this.parent.style('text-transform', 'lowercase'); break
 		case this.SmallCaps: this.parent.style('font-variant', 'small-caps'); break
 		case this.Capitalize: this.parent.style('text-transform', 'capitalize'); break
 		}
	}
}
