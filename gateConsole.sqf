// ============================================================
//  gate CONSOLE — call per console via addAction
//
//  Usage:
//    [turretObject, "Turret Alpha"] execVM "gateConsole.sqf";
//
//  Or from an addAction on each console object:
//    consoleObj1 addAction ["Access gate Console", "gateConsole.sqf",
//        [turret1, "TURRET ALPHA"], 1.5, true, true];
//    consoleObj2 addAction ["Access gate Console", "gateConsole.sqf",
//        [turret2, "TURRET BRAVO"], 1.5, true, true];
//
//  When called from addAction, _this is:
//    [callerObject, callerUnit, actionId, [turretObj, turretName]]
// ============================================================

// ── Unpack arguments — supports both direct execVM and addAction ───────────
private _args = if (count _this >= 5) then {
    _this select 4
} else {
    _this
};

private _gate     = _args select 0;
private _gateName = _args select 1;
private _code       = _args select 2; 
private _taskID     = _args select 3;

// ── Store in uiNamespace so onLoad and button handler can reach them ───────
uiNamespace setVariable ["gate_turret",     _gate];
uiNamespace setVariable ["gate_turretName", _gateName];
uiNamespace setVariable ["gate_code",       _code];
uiNamespace setVariable ["gate_taskID",     _taskID];

// ── Populate dynamic fields once the dialog is open ───────────────────────
MY_fnc_gateConsoleLoad = {
    params ["_display"];

    private _gate     = uiNamespace getVariable ["gate_turret",     objNull];
    private _gateName = uiNamespace getVariable ["gate_turretName", "UNKNOWN"];

    // Current enabled state — damage == 1 means destroyed/disabled
    private _enabled = gate_underground_unlocked;
    private _stateStr = if (_enabled) then {
        "CURRENT STATE: UNLOCKED"
    } else {
        "CURRENT STATE: LOCKED"
    };

    // Sub-label shows what action will happen
    private _actionStr = if (_enabled) then {
        "UNLOCKED  -  NO CONFIRMATION REQUIRED"
    } else {
        "LOCKED  -  CONFIRM CODE TO UNLOCK"
    };

    (_display displayCtrl 9010) ctrlSetText _actionStr;
    (_display displayCtrl 9011) ctrlSetText format ["GATE ID: %1", _gateName];
    (_display displayCtrl 9012) ctrlSetText _stateStr;
};

// ── Handle confirm button ─────────────────────────────────────────────────
MY_fnc_gateHandleInput = {
    params ["_input"];

    private _code       = uiNamespace getVariable ["gate_code",       ""];
    private _gate     = uiNamespace getVariable ["gate_turret",     objNull];
    private _gateName = uiNamespace getVariable ["gate_turretName", "UNKNOWN"];
    private _taskID     = uiNamespace getVariable ["gate_taskID",     ""];

    if (_input == _code) then {
        gate_underground_unlocked = true;
		publicVariable "gate_underground_unlocked";
		hint format ["%1 CORRECT — Gate is now UNLOCKED.", _gateName];
		if (_taskID != "" && !(_taskID call BIS_fnc_taskCompleted)) then {
			[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
		};
    } else {
        hint "INVALID CODE — Access denied.";
    };
};

// ── Handle close/cancel ───────────────────────────────────────────────────
MY_fnc_gateConsoleClose = {
    params ["_display", "_exitCode"];
    if (_exitCode == 2) then {
        hint "Access cancelled.";
    };
};

// ── Open the console ──────────────────────────────────────────────────────
createDialog "GateConsole";