 #include "oop.h"

CLASS("oo_Discord")
	PUBLIC VARIABLE("code", "WebService");

	PUBLIC FUNCTION("string","constructor") { 
		private _ws = ["new", _this] call oo_WebService;
		MEMBER("WebService", _ws);
	};

	PUBLIC FUNCTION("string","sendGlobal") {
		private _arr = [
			["action", "sendGlobal"],
			["steamID", getPlayerUID player],
			["text", _this]
		];
		["putParam", _arr] call MEMBER("WebService", nil);
		_index = "call" call MEMBER("WebService", nil);
		SPAWN_MEMBER("waitResult", _index);
	};

	PUBLIC FUNCTION("scalar","waitResult") {
		private "_res";
		waitUntil {
			_res = ["getStatus", _this] call MEMBER("WebService", nil);
			if ((_res select 0) isEqualTo "waiting" ) exitWith {
				false;
			};
			true;		  
		};
		if ((_res select 0) isEqualTo "complete") then {
			hint "Message sent";
		};
		if ((_res select 0) isEqualTo "timeout") then {
			hint "Message timeout";
		};		
	};

ENDCLASS;
