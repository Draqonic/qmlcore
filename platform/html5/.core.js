if (typeof navigator !== 'undefined') {
	exports.core.os = navigator.platform
	exports.core.userAgent = navigator.userAgent
	exports.core.language = navigator.language
} else {
	exports.core.os = 'unknown'
	exports.core.userAgent = 'Unknown'
}

var _checkDevice = function(target, info) {
	if (exports.core.userAgent.indexOf(target) < 0)
		return

	exports.core.vendor = info.vendor
	exports.core.device = info.device
	exports.core.os = info.os
}

if (!exports.core.vendor) {
	_checkDevice('Blackberry', { 'vendor': 'blackberry', 'device': 2, 'os': 'blackberry' })
	_checkDevice('Android', { 'vendor': 'google', 'device': 2, 'os': 'android' })
	_checkDevice('iPhone', { 'vendor': 'apple', 'device': 2, 'os': 'iOS' })
	_checkDevice('iPad', { 'vendor': 'apple', 'device': 2, 'os': 'iOS' })
	_checkDevice('iPod', { 'vendor': 'apple', 'device': 2, 'os': 'iOS' })
}

// TODO: check on mobile, check Opera/Yandex/Vivaldi
if (exports.core.userAgent.indexOf('Edge') !== -1)
	exports.core.browser = "Edge"
else if (exports.core.userAgent.indexOf('Chrome/') !== -1 || exports.core.userAgent.indexOf('Chromium') !== -1)
	exports.core.browser = "Chrome"
else if (exports.core.userAgent.indexOf('Opera/') !== -1)
	exports.core.browser = "Opera"
else if (exports.core.userAgent.indexOf('Firefox/') !== -1)
	exports.core.browser = "Firefox"
else if (exports.core.userAgent.indexOf('Safari/') !== -1)
	exports.core.browser = "Safari"
else if (exports.core.userAgent.indexOf('MSIE ') !== -1 || exports.core.userAgent.indexOf('Trident') !== -1)
	exports.core.browser = "IE"
else if (exports.core.userAgent.indexOf('YaBrowser') !== -1)
	exports.core.browser = "Yandex"
else
	exports.core.browser = ''


_globals._backend = function() { return _globals.html5.html }
_globals.core.__locationBackend = function() { return _globals.html5.location }
_globals.core.__localStorageBackend = function() { return _globals.html5.localstorage }
