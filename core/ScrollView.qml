Item {
	property enum horizontalScrollBarPolicy	{ ScrollBarAsNeeded, ScrollBarAlwaysOff, ScrollBarAlwaysOn }: ScrollBarAlwaysOff;
	property enum verticalScrollBarPolicy	{ ScrollBarAsNeeded, ScrollBarAlwaysOff, ScrollBarAlwaysOn };

	property bool atXBeginning: !contentX;
	property bool atXEnd: contentX >= contentMaxX;
	property bool atYBeginning: !contentY;
	property bool atYEnd: contentY >= contentMaxY;
	property int contentX;
	property int contentY;
	property int contentWidth;
	property int contentHeight;
	property int contentMaxX;
	property int contentMaxY;
	signal scrolling;

	constructor: {
		this.style({ 'overflow-x': 'hidden', 'overflow-y': 'auto' })

		this.element.dom.onscroll = function() {
			this.contentX = this.element.dom.scrollLeft
			this.contentY = this.element.dom.scrollTop
			this.contentMaxX = this.element.dom.scrollLeftMax
			this.contentMaxY = this.element.dom.scrollTopMax
			this.contentWidth = this.element.dom.scrollWidth
			this.contentHeight = this.element.dom.scrollHeight
			this.scrolling()
		}.bind(this);
	}

	onCompleted: { hack.start() }

	Timer {
		id: hack;
		interval: 100;
		onTriggered: {
			this.contentMaxX = this.element.dom.scrollLeftMax
			this.contentMaxY = this.element.dom.scrollTopMax
			this.contentWidth = this.element.dom.scrollWidth
			this.contentHeight = this.element.dom.scrollHeight
		}
	}

	function scroll(x, y) {
		this.element.dom.scroll({
			left: x,
	      		top: y,
	      		behavior: 'smooth' 
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
