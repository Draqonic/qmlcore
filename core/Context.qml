///root item
Item {
	property int scrollY;		///< scrolled page vertical offset value
	property int keyProcessDelay; ///< key pressed handling delay timeout in millisecnods
	property bool fullscreen;	///< fullscreen mode enabled / disabled
	property string language;	///< localisation language
	property System system: System { }					///< system info object
	property Location location: Location { }			///< web-page location object
	property Stylesheet stylesheet: Stylesheet { }		///< @private
	property string buildIdentifier; ///< @private

	visibleInView: false; //startup

	///@private
	constructor: {
		this.options = arguments[2]
		this.l10n = this.options.l10n || {}

		this._local['context'] = this
		this._context = this
		this._started = false
		this._completed = false
		this._processingActions = false
		this._delayedActions = []
		this._stylesRegistered = {}
		this._asyncInvoker = _globals.core.safeCall(this, [], function (ex) { log("async action failed:", ex, ex.stack) })

		this.backend = _globals._backend()

		this._init()
	}

	///@private
	function mangleClass(name) {
		return $manifest$html5$prefix + name
	}

	///@private
	function registerStyle(item, tag, cls) {
		cls = this.mangleClass(cls)
		var selector = cls? tag + '.' + cls: tag
		if (!(selector in this._stylesRegistered)) {
			item.registerStyle(this.stylesheet, selector)
			this._stylesRegistered[selector] = true
		}
	}

	///@private
	function createElement(tag, cls) {
		return this.backend.createElement(this, tag, cls)
	}

	///@private
	function _init() {
		log('Context: initializing...')
		new this.backend.init(this)
	}

	///@private
	function init() {
		this.backend.initSystem(this.system)
	}

	///@private
	function _onCompleted(callback) {
		this.scheduleAction(callback)
	}

	onFullscreenChanged: { if (value) this.backend.enterFullscreenMode(this.element); else this.backend.exitFullscreenMode(); }

	///@private
	function _complete() {
		this._processActions()
	}

	///@private
	function start(instance) {
		var c = {}
		this.children.push(instance)
		instance.$c(c)
		instance.$s(c)
		c = undefined
		log('Context: created instance')
		// log('Context: calling on completed')
		return instance;
	}

	///@private
	function _processActions() {
		if (!this._started || this._processingActions)
			return

		this._processingActions = true

		var invoker = this._asyncInvoker
		var delayedActions = this._delayedActions

		while (delayedActions.length) {
			var actions = delayedActions.splice(0, delayedActions.length)
			for(var i = 0, n = actions.length; i < n; ++i)
				invoker(actions[i])
		}

		this._processingActions = false
		this.backend.tick(this)
	}

	///@private
	function scheduleAction(action) {
		this._delayedActions.push(action)
	}

	///@private
	function delayedAction(prefix, self, method, delay) {
		var registry = self._registeredDelayedActions

		if (registry === undefined)
			registry = self._registeredDelayedActions = {}

		if (registry[name] === true)
			return

		registry[name] = true

		var callback = function() {
			registry[name] = false
			method.call(self)
		}

		if (delay > 0) {
			setTimeout(callback, delay)
		} else if (delay === 0) {
			this.backend.requestAnimationFrame(callback)
		} else {
			this.scheduleAction(callback)
		}
	}

	/**@param text:string text that must be translated
	Returns input text translation*/
	function qsTr(text) {
		var args = arguments
		var lang = this.language
		var messages = this.l10n[lang] || {}
		var contexts = messages[text] || {}
		for(var name in contexts) {
			text = contexts[name] //fixme: add context handling here
			break
		}
		return text
	}

	function processKey(event) {
		var handlers = core.forEach(this, _globals.core.Item.prototype._enqueueNextChildInFocusChain, [])
		var n = handlers.length
		for(var i = 0; i < n; ++i) {
			var handler = handlers[i]
			if (handler._processKey(event))
				return true
		}
		return false
	}

	///@private
	function run() {
		this.backend.run(this, this._run.bind(this))
	}

	///@private
	function _run() {
		log('Context: signalling layout')
		this.visibleInView = true
		this.boxChanged()
		log('Context: calling completed()')
		this._started = true
		this._complete()
		this._completed = true
	}
}
