_EndSplashScreen = {
    for "_x" from 1 to 4 do {
        endLoadingScreen;
        sleep 3;
    };
};

[] spawn _EndSplashScreen;

if (isServer) then {
    [
		west,
		"obj_secure_cm89a", 
		[ 
			"Go to Colonial Municipality 89A and investigate its current status, arrest dissidents and secure the town's civilian leadership.",
			"Secure CM-89-A",      
			"intel"                     
		],
		[5073.610, 4424.042, 0],
		"CREATED",
		-1,
		true,
		"intel",
		true          
	] call BIS_fnc_taskCreate;

    [
		west,
		"obj_secure_cm89a", 
		[ 
			"Go to Colonial Municipality 90B and investigate its current status, arrest dissidents and secure the town's civilian leadership.",
			"Secure CM-90-B",      
			"intel"                     
		],
		[5700.153, 6641.607, 0],
		"CREATED",
		-1,
		true,
		"intel",
		true          
	] call BIS_fnc_taskCreate;

    [
		west,
		"obj_deactivate_broadcast", 
		[ 
			"Go to this old broadcast station and deactivate the unusual message it is relaying.",
			"Deactivate Unusual Broadcast",      
			"interact"                     
		],
		[7576.689, 4319.254, 0],
		"CREATED",
		-1,
		true,
		"interact",
		true          
	] call BIS_fnc_taskCreate;

    [
		west,
		"obj_secure_unsc_base", 
		[ 
			"We have lost contact with UNSC Base Gaben, go to it and reestablish contact with UNSC forces there.",
			"Secure UNSC Base Gaben",      
			"defend"                     
		],
		[3433.997, 6046.865, 0],
		"CREATED",
		-1,
		true,
		"defend",
		true          
	] call BIS_fnc_taskCreate;
};

[   
    controls,   
    "Begin MISSION",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "_this == z5",   
    "_this == z5",   
    {},   
    {},   
    {   
        params ["_target", "_caller", "_actionId", "_arguments"];
		mission_start = true;
		publicVariable "mission_start";
    },   
    {},   
    [],   
    1,   
    1000,   
    false,   
    false,   
    true,   
    5   
] call BIS_fnc_holdActionAdd; 

[   
    controls,   
    "Begin ACT 1",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "_this == z5",   
    "_this == z5",   
    {},   
    {},   
    {   
        params ["_target", "_caller", "_actionId", "_arguments"];
		act_1 = true;
		publicVariable "act_1";
    },   
    {},   
    [],   
    1,   
    1000,   
    false,   
    false,   
    true,   
    5   
] call BIS_fnc_holdActionAdd; 

[   
    controls,   
    "Bring Ship In (Pelican IDAP)",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "_this == z5",   
    "_this == z5",   
    {},   
    {},   
    {   
        params ["_target", "_caller", "_actionId", "_arguments"];
		execVM "shuttle_idap.sqf";
    },   
    {},   
    [],   
    1,   
    1000,   
    false,   
    false,   
    true,   
    5   
] call BIS_fnc_holdActionAdd; 

[   
    controls,   
    "End ACT 1",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "_this == z5",   
    "_this == z5",   
    {},   
    {},   
    {   
        params ["_target", "_caller", "_actionId", "_arguments"];
		act_1_end = true;
		publicVariable "act_1_end";
    },   
    {},   
    [],   
    1,   
    1000,   
    false,   
    false,   
    true,   
    5   
] call BIS_fnc_holdActionAdd; 

[   
    controls,   
    "Begin ACT 2",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "_this == z5",   
    "_this == z5",   
    {},   
    {},   
    {   
        params ["_target", "_caller", "_actionId", "_arguments"];
		act_2 = true;
		publicVariable "act_2";
    },   
    {},   
    [],   
    1,   
    1000,   
    false,   
    false,   
    true,   
    5   
] call BIS_fnc_holdActionAdd; 

[   
    controls,   
    "End ACT 2",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "_this == z5",   
    "_this == z5",   
    {},   
    {},   
    {   
        params ["_target", "_caller", "_actionId", "_arguments"];
		act_2_end = true;
		publicVariable "act_2_end";
    },   
    {},   
    [],   
    1,   
    1000,   
    false,   
    false,   
    true,   
    5   
] call BIS_fnc_holdActionAdd;

[   
    controls,   
    "Begin ACT 3",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "_this == z5",   
    "_this == z5",   
    {},   
    {},   
    {   
        params ["_target", "_caller", "_actionId", "_arguments"];
		act_3 = true;
		publicVariable "act_3";
    },   
    {},   
    [],   
    1,   
    1000,   
    false,   
    false,   
    true,   
    5   
] call BIS_fnc_holdActionAdd;

[   
    controls,   
    "Gladius Takeoff",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "_this == z5",   
    "_this == z5",   
    {},   
    {},   
    {   
        params ["_target", "_caller", "_actionId", "_arguments"];
		gladius_take_off = true;
        publicVariable "gladius_take_off";
    },   
    {},   
    [],   
    1,   
    1000,   
    false,   
    false,   
    true,   
    5   
] call BIS_fnc_holdActionAdd; 

[   
    controls_icarus,   
    "End ACT 3",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "_this == z5",   
    "_this == z5",   
    {},   
    {},   
    {   
        params ["_target", "_caller", "_actionId", "_arguments"];
		act_3_end = true;
		publicVariable "act_3_end";
    },   
    {},   
    [],   
    1,   
    1000,   
    false,   
    false,   
    true,   
    5   
] call BIS_fnc_holdActionAdd;

[   
    controls_icarus,   
    "Toggle Hologram",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "_this == z5",   
    "_this == z5",   
    {},   
    {},   
    {   
        params ["_target", "_caller", "_actionId", "_arguments"];     
		[brief1, !(isObjectHidden brief1)] remoteExec ["hideObjectGlobal", 2];
        [shipmaster, !(isObjectHidden shipmaster)] remoteExec ["hideObjectGlobal", 2];
		[wall_1, !(isObjectHidden wall_1)] remoteExec ["hideObjectGlobal", 2];
		[wall_2, !(isObjectHidden wall_1)] remoteExec ["hideObjectGlobal", 2];
		[wall_3, !(isObjectHidden wall_1)] remoteExec ["hideObjectGlobal", 2];
		[wall_4, !(isObjectHidden wall_1)] remoteExec ["hideObjectGlobal", 2];
		[wall_5, !(isObjectHidden wall_1)] remoteExec ["hideObjectGlobal", 2];
		[wall_6, !(isObjectHidden wall_1)] remoteExec ["hideObjectGlobal", 2];
		[wall_7, !(isObjectHidden wall_1)] remoteExec ["hideObjectGlobal", 2];
		[wall_8, !(isObjectHidden wall_1)] remoteExec ["hideObjectGlobal", 2];
		[wall_9, !(isObjectHidden wall_1)] remoteExec ["hideObjectGlobal", 2];
		[wall_10, !(isObjectHidden wall_1)] remoteExec ["hideObjectGlobal", 2];
		[wall_11, !(isObjectHidden wall_1)] remoteExec ["hideObjectGlobal", 2];
		[wall_12, !(isObjectHidden wall_1)] remoteExec ["hideObjectGlobal", 2];
    },   
    {},   
    [],   
    1,   
    1000,   
    false,   
    false,   
    true,   
    5   
] call BIS_fnc_holdActionAdd; 

[   
    controls_icarus,   
    "Play Hologram Audio",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",   
    "_this == z5",   
    "_this == z5",   
    {},   
    {},   
    {   
        params ["_target", "_caller", "_actionId", "_arguments"];     
        [shipmaster, ["shipmaster_jump_in", 100, 1, false, 0, false]] remoteExec ["say3D", 0];
    },   
    {},   
    [],   
    1,   
    1000,   
    false,   
    false,   
    true,   
    5   
] call BIS_fnc_holdActionAdd;

MyMission_fnc_earthquake_continuous = {
    params [
        ["_duration",  20, [0]],
        ["_intensity",  2, [0]],
        ["_sourceObj", objNull, [objNull]],
        ["_maxDistance", 100, [0]],
        ["_pitch", 1, [0]],
        ["_isSpeech", 0, [0]],
        ["_offset", 0, [0]],
        ["_simulateSpeedOfSound", false, [false]]
    ];

    _intensity = (_intensity max 1) min 4;

    private _shakeStr  = [0.3, 0.6, 1.0, 1.8] select (_intensity - 1);
    private _shakeDur  = [0.6, 0.6, 0.7, 0.8] select (_intensity - 1);
    private _shakeFreq = [8.0, 10.0, 13.0, 16.0] select (_intensity - 1);

    private _soundData = [
        ["Earthquake_01", 4.0],
        ["Earthquake_02", 4.5],
        ["Earthquake_03", 5.0],
        ["Earthquake_04", 5.5]
    ] select (_intensity - 1);

    private _sound     = _soundData select 0;
    private _soundLen  = _soundData select 1;

    private _soundArray = [_sound, _maxDistance, _pitch, _isSpeech, _offset, _simulateSpeedOfSound];

    private _infinite = _duration <= 0;
    private _endTime  = time + _duration;

    private _stopHolder = if (isNull _sourceObj) then { missionNamespace } else { _sourceObj };
    _stopHolder setVariable ["MyMission_earthquake_stop", false];

    private _nextSoundTime = 0;

    while {
        (_infinite || { time < _endTime })
        && { !(_stopHolder getVariable ["MyMission_earthquake_stop", false]) }
        && { isNull _sourceObj || { !isNull _sourceObj } }
    } do {

        if (!isNull _sourceObj && { isNull _sourceObj }) exitWith {};

        if (!(isNull _sourceObj) && { isNull _sourceObj }) then {};

        if (time >= _nextSoundTime) then {
            if (!isNull _sourceObj) then {
                _sourceObj say3D _soundArray;
            } else {
                playSound _sound;
            };
            _nextSoundTime = time + _soundLen;
        };

        sleep 0.05;
    };
};

ScifiSupportPLUS_ShipLightDefs = createHashMap;

ScifiSupportPLUS_fnc_RegisterShipLights = {
    params ["_classname", "_lightDefs"];
    ScifiSupportPLUS_ShipLightDefs set [_classname, _lightDefs];
};

ScifiSupportPLUS_fnc_MoveAlongLine = {
    params [
        "_localObj",
        "_startTarget",
        "_endTarget",
        ["_speed", 5],
        ["_axis", "dir"]
    ];

    if (isNull _localObj || isNull _startTarget || isNull _endTarget) exitWith {};

    private _targetDir = vectorDir _startTarget;
    private _targetUp  = vectorUp _startTarget;
    private _targetRight = _targetDir vectorCrossProduct _targetUp;

    private _newDir = switch (toLower _axis) do {
        case "dirback": { _targetDir vectorMultiply -1 };
        case "right":   { _targetRight };
        case "left":    { _targetRight vectorMultiply -1 };
        default         { _targetDir };
    };
    private _newUp = _targetUp;
    private _newRight = _newDir vectorCrossProduct _newUp;

    _localObj setVectorDirAndUp [_newDir, _newUp];

    private _startPos = getPosASL _startTarget;
    private _endPos   = getPosASL _endTarget;
    private _fullVec  = _endPos vectorDiff _startPos;
    private _totalDist = vectorMagnitude _fullVec;

    if (_totalDist <= 0) exitWith {};

    private _travelDir = _fullVec vectorMultiply (1 / _totalDist);

    _localObj setPosASL _startPos;

    private _existingLights = _localObj getVariable ["ScifiSupportPLUS_shipLights", []];
    private _lights = [];

    if (count _existingLights > 0) then {
        _lights = _existingLights;
    } else {
        private _classname = typeOf _localObj;
        private _lightDefs = ScifiSupportPLUS_ShipLightDefs getOrDefault [_classname, []];

        {
            _x params ["_offset", "_color", "_brightness", "_flareSize", "_flareMaxDist", "_blinking"];

            private _worldPos = _startPos vectorAdd (
                (_newRight vectorMultiply (_offset select 0))
                vectorAdd (_newDir vectorMultiply (_offset select 1))
                vectorAdd (_newUp vectorMultiply (_offset select 2))
            );

            private _light = "#lightpoint" createVehicleLocal _worldPos;
            _light setLightColor _color;
            _light setLightAmbient _color;
            _light setLightBrightness _brightness;
            _light setLightUseFlare true;
            _light setLightFlareSize _flareSize;
            _light setLightFlareMaxDistance _flareMaxDist;
            _light setLightDayLight true;

            _lights pushBack [_light, _offset];

            if (_blinking) then {
                [_light] spawn {
                    params ["_light"];
                    while {!isNull _light} do {
                        _light setLightBrightness 1;
                        sleep 0.8;
                        _light setLightBrightness 0;
                        sleep 0.8;
                    };
                };
            };
        } forEach _lightDefs;

        _localObj setVariable ["ScifiSupportPLUS_shipLights", _lights];
    };

    private _startTime = time;

    [
        {
            params ["_args", "_pfhID"];
            _args params ["_localObj", "_startPos", "_travelDir", "_totalDist", "_speed", "_startTime", "_newDir", "_newUp", "_newRight", "_lights"];

            if (isNull _localObj) exitWith {
                { deleteVehicle (_x select 0) } forEach _lights;
                [_pfhID] call CBA_fnc_removePerFrameHandler;
            };

            private _elapsed = time - _startTime;
            private _distCovered = _elapsed * _speed;
            private _finished = _distCovered >= _totalDist;

            private _newPos = _startPos vectorAdd (_travelDir vectorMultiply (_distCovered min _totalDist));
            _localObj setPosASL _newPos;

            {
                _x params ["_light", "_offset"];
                if (!isNull _light) then {
                    private _lightPos = _newPos vectorAdd (
                        (_newRight vectorMultiply (_offset select 0))
                        vectorAdd (_newDir vectorMultiply (_offset select 1))
                        vectorAdd (_newUp vectorMultiply (_offset select 2))
                    );
                    _light setPosASL _lightPos;
                };
            } forEach _lights;

            if (_finished) exitWith {
                [_pfhID] call CBA_fnc_removePerFrameHandler;
            };
        },
        0,
        [_localObj, _startPos, _travelDir, _totalDist, _speed, _startTime, _newDir, _newUp, _newRight, _lights]
    ] call CBA_fnc_addPerFrameHandler;
};

ScifiSupportPLUS_fnc_SpawnShipLightsAndSound = {
    params [
        "_localObj",
        ["_sound", "", [""]],
        ["_soundLen", 4, [0]],
        ["_maxDistance", 100, [0]],
        ["_pitch", 1, [0]],
        ["_isSpeech", 0, [0]],
        ["_offset", 0, [0]],
        ["_simulateSpeedOfSound", false, [false]]
    ];

    if (isNull _localObj) exitWith { [] };

    private _pos   = getPosASL _localObj;
    private _dir   = vectorDir _localObj;
    private _up    = vectorUp _localObj;
    private _right = _dir vectorCrossProduct _up;

    private _classname = typeOf _localObj;
    private _lightDefs = ScifiSupportPLUS_ShipLightDefs getOrDefault [_classname, []];

    private _lights = [];
    {
        _x params ["_lightOffset", "_color", "_brightness", "_flareSize", "_flareMaxDist", "_blinking"];

        private _worldPos = _pos vectorAdd (
            (_right vectorMultiply (_lightOffset select 0))
            vectorAdd (_dir vectorMultiply (_lightOffset select 1))
            vectorAdd (_up vectorMultiply (_lightOffset select 2))
        );

        private _light = "#lightpoint" createVehicleLocal _worldPos;
        _light setPosASL _worldPos;
        _light setLightColor _color;
        _light setLightAmbient _color;
        _light setLightBrightness _brightness;
        _light setLightUseFlare true;
        _light setLightFlareSize _flareSize;
        _light setLightFlareMaxDistance _flareMaxDist;
        _light setLightDayLight true;

        _lights pushBack [_light, _lightOffset];

        if (_blinking) then {
            [_light] spawn {
                params ["_light"];
                while {!isNull _light} do {
                    _light setLightBrightness 1;
                    sleep 0.8;
                    _light setLightBrightness 0;
                    sleep 0.8;
                };
            };
        };
    } forEach _lightDefs;

    _localObj setVariable ["ScifiSupportPLUS_shipLights", _lights];

    if (_sound != "") then {
        _localObj setVariable ["ScifiSupportPLUS_shipSound_stop", false];

        private _soundArray = [_sound, _maxDistance, _pitch, _isSpeech, _offset, _simulateSpeedOfSound];

        [_localObj, _soundArray, _soundLen] spawn {
            params ["_localObj", "_soundArray", "_soundLen"];

            while {
                !isNull _localObj
                && { !(_localObj getVariable ["ScifiSupportPLUS_shipSound_stop", false]) }
            } do {
                _localObj say3D _soundArray;
                sleep _soundLen;
            };
        };
    };

    _lights
};

[
    "31st_Frigate_UNSC",
    [
        [[-72.327,-281.29,9.388],   [0,0.89,1], 20, 25, 10000, false],
        [[-60.309,-250.754,-11.935],[0,0.89,1], 20, 25, 10000, false],
        [[60.346,-250.754,-11.935], [0,0.89,1], 20, 25, 10000, false],
        [[73.146,-281.29,9.388],    [0,0.89,1], 20, 25, 10000, false],
        [[9.659,277.234,-11.498],   [1,0,0],    1.3, 4,  10000, true],
        [[-9.674,277.234,-11.498],  [1,0,0],    1.3, 4,  10000, true],
        [[9.659,254.724,-2.309],    [1,0,0],    1.3, 4,  10000, true],
        [[-9.674,254.724,-2.309],   [1,0,0],    1.3, 4,  10000, true],
        [[-0.032,-50.098,65.682],   [1,0,0],    1.3, 4,  10000, true],
        [[-5.659,-232.94,11.066],   [1,0,0],    1.3, 4,  10000, true],
        [[5.703,-232.94,11.066],    [1,0,0],    1.3, 4,  10000, true]
    ]
] call ScifiSupportPLUS_fnc_RegisterShipLights;

[
    "WSD_Gladius",
    [
        [[-50.006,-184.9,-13.688],   [0,0.89,1], 30, 25, 10000, false],
        [[-55.258,-140.897,32.393],[1,0,0], 1.3, 4, 10000, true],
        [[-50.275,175.4,-24.325], [1,0,0], 1.3, 4, 10000, true],
        [[-50.015,218.215,-26.805],    [1,0,0], 1.3, 4, 10000, true]
    ]
] call ScifiSupportPLUS_fnc_RegisterShipLights;

frigate = "31st_Frigate_Icarus" createVehicleLocal (getPosATL icarus);
frigate setVectorDirAndUp [(vectorDir icarus), (vectorUp icarus)];
frigate setPosATL (getPosATL icarus);

gladius = "WSD_Gladius" createVehicleLocal (getPosATL gladius_start);
gladius setVectorDirAndUp [(vectorDir gladius_start), (vectorUp gladius_start)];
gladius setPosATL (getPosATL gladius_start);

[frigate] call ScifiSupportPLUS_fnc_SpawnShipLightsAndSound;
[gladius] call ScifiSupportPLUS_fnc_SpawnShipLightsAndSound;

[-1, 2, frigate, 3000] call MyMission_fnc_earthquake_continuous;