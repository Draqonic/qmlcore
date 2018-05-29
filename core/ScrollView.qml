Item {
	property enum horizontalScrollBarPolicy	{ ScrollBarAsNeeded, ScrollBarAlwaysOff, ScrollBarAlwaysOn }: ScrollBarAlwaysOff;
	property enum verticalScrollBarPolicy	{ ScrollBarAsNeeded, ScrollBarAlwaysOff, ScrollBarAlwaysOn };

	property bool atXBeginning: !contentX;
	property bool atXEnd: contentX >= contentWidth - width;
	property bool atYBeginning: !contentY;
	property bool atYEnd: contentY >= contentHeight - height;
	property int contentX;
	property int contentY;
	property int contentWidth;
	property int contentHeight;
	signal scrolling;

	function _updateScrollProperties() {
		var element = this.element.dom
		this.contentX = element.scrollLeft
		this.contentY = element.scrollTop
		this.contentWidth = element.scrollWidth
		this.contentHeight = element.scrollHeight
		this.scrolling()
	}

	constructor: {
		this.style({ 'overflow-x': 'hidden', 'overflow-y': 'auto' })
		this.element.dom.onscroll = context.wrapNativeCallback(this._updateScrollProperties.bind(this))
	}

	/// smooth scroll
	function scroll(x, y) {
		this.element.dom.scroll({
			left: x,
	      		top: y,
	      		behavior: 'smooth' 
		})
	}

	/// scroll
	function quickScroll(x, y) {
		this.element.dom.scroll({
			left: x,
	      		top: y
		})
	}

	///@private
	function _setStyle(style, value) {
		switch(value) {
			case ScrollViewPrototype.ScrollBarAsNeeded:
				this.style(style, 'auto')
				break
			case ScrollViewPrototype.ScrollBarAlwaysOn:
				this.style(style, 'visible')
				break
			case ScrollViewPrototype.ScrollBarAlwaysOff:
				this.style(style, 'hidden')
				break
		}
	}

	onHorizontalScrollBarPolicyChanged: {
		this._setStyle('overflow-x', value)
	}

	onVerticalScrollBarPolicyChanged: {
		this._setStyle('overflow-y', value)
	}
}
