// ============================================================
//  TURRET ROTATION CONTROL PANEL — call per console via addAction
//
//  Usage:
//    [panelObject, turretObject, "turret_rotation", "Turret Alpha", targetElevation, targetZ, threshold, "taskID"] execVM "turretControl.sqf";
//
//  Or from an addAction on each panel object:
//    panelObj1 addAction ["Access Turret Control", "turretControl.sqf",
//        [panel1, turret1, "turret_rotation", "TURRET ALPHA", 0.5, 0.25, 0.03, "task_alignTurret"], 1.5, true, true];
//
//  When called from addAction, _this is:
//    [callerObject, callerUnit, actionId, [panelObj, turretObj, animSource, label, targetElev, targetZ, threshold, taskID]]
// ============================================================

private _args = if (count _this >= 9) then {
    _this select 8
} else {
    _this
};

private _panel        = _args select 0;
private _turret       = _args select 1;
private _animSource   = _args param [2, "turret_rotation"];
private _label         = _args param [3, "UNKNOWN TURRET"];
private _targetElev    = _args param [4, -1]; // -1 = no target/disabled
private _targetZ       = _args param [5, -1]; // -1 = no target/disabled
private _threshold     = _args param [6, 0.02];
private _taskID         = _args param [7, ""];

if (_panel getVariable ["TRC_LoadProgress", false]) then {
    return;
};

uiNamespace setVariable ["TRC_panel",       _panel];
uiNamespace setVariable ["TRC_turret",      _turret];
uiNamespace setVariable ["TRC_animSource",  _animSource];
uiNamespace setVariable ["TRC_label",       _label];
uiNamespace setVariable ["TRC_dragging",    false];
uiNamespace setVariable ["TRC_zDragging",   false];
uiNamespace setVariable ["TRC_targetElev",  _targetElev];
uiNamespace setVariable ["TRC_targetZ",     _targetZ];
uiNamespace setVariable ["TRC_threshold",   _threshold];
uiNamespace setVariable ["TRC_taskID",      _taskID];
uiNamespace setVariable ["TRC_targetHit",   false]; // guard so callback only fires once

// ── Populate dynamic fields once the dialog is open ───────────────────────
MY_fnc_turretPanelLoad = {
    params ["_display"];

    private _turret     = uiNamespace getVariable ["TRC_turret", objNull];
    private _animSource = uiNamespace getVariable ["TRC_animSource", ""];
    private _label       = uiNamespace getVariable ["TRC_label", "UNKNOWN TURRET"];

    private _statusStr = if (isNull _turret) then {
        "LINK STATUS: NO TURRET DETECTED"
    } else {
        "LINK STATUS: CONNECTED"
    };

    (_display displayCtrl 9010) ctrlSetText "MANUAL ROTATION OVERRIDE ACTIVE";
    (_display displayCtrl 9011) ctrlSetText format ["TARGET TURRET: %1", _label];
    (_display displayCtrl 9012) ctrlSetText _statusStr;

    private _current = 0;
    if (!isNull _turret) then {
        _current = _turret animationSourcePhase _animSource;
    };
    (_display displayCtrl 110) sliderSetPosition _current;
    (_display displayCtrl 9013) ctrlSetText format ["%1", _current toFixed 3];

    private _currentDir = 0;
    if (!isNull _turret) then {
        _currentDir = (getDir _turret) / 360;
    };
    (_display displayCtrl 113) sliderSetPosition _currentDir;
    (_display displayCtrl 9014) ctrlSetText format ["%1", _currentDir toFixed 3];

    uiNamespace setVariable ["TRC_dragging",  false];
    uiNamespace setVariable ["TRC_zDragging", false];
    [_display] spawn MY_fnc_turretSyncLoop;
};

// ── Live slider handler: drives the turret rotation in real time ─────────
MY_fnc_turretSliderChanged = {
    params ["_control", "_value"];

    private _display    = ctrlParent _control;
    private _turret     = uiNamespace getVariable ["TRC_turret", objNull];
    private _animSource = uiNamespace getVariable ["TRC_animSource", ""];

    if (!isNull _turret && {_animSource != ""}) then {
        _turret animateSource [_animSource, _value];
    };

    (_display displayCtrl 9013) ctrlSetText format ["%1", _value toFixed 3];
};

// ── Drag-state tracking so the sync loop doesn't fight manual input ───────
MY_fnc_turretSliderDragStart = {
    uiNamespace setVariable ["TRC_dragging", true];
};

MY_fnc_turretSliderDragEnd = {
    uiNamespace setVariable ["TRC_dragging", false];
};

// ── Live sync loop: keeps slider + readout matched to the turret's real rotation ──
MY_fnc_turretSyncLoop = {
    params ["_display"];

    private _turret     = uiNamespace getVariable ["TRC_turret", objNull];
    private _animSource = uiNamespace getVariable ["TRC_animSource", ""];

    while {!isNull _display && {!isNull _turret} && {alive _turret}} do {

        if !(uiNamespace getVariable ["TRC_dragging", false]) then {
            private _current = _turret animationSourcePhase _animSource;

            private _slider = _display displayCtrl 110;
            private _text   = _display displayCtrl 9013;

            if (!isNull _slider) then { _slider sliderSetPosition _current; };
            if (!isNull _text)   then { _text ctrlSetText format ["%1", _current toFixed 3]; };
        };

        if !(uiNamespace getVariable ["TRC_zDragging", false]) then {
            private _currentDir = (getDir _turret) / 360;

            private _zSlider = _display displayCtrl 113;
            private _zText   = _display displayCtrl 9014;

            if (!isNull _zSlider) then { _zSlider sliderSetPosition _currentDir; };
            if (!isNull _zText)   then { _zText ctrlSetText format ["%1", _currentDir toFixed 3]; };
        };

        sleep 0.1;
    };
};

// ── Target monitor loop: fires callback once both axes are within threshold ──
// Runs independently of the dialog — keeps checking even after the UI is closed
MY_fnc_turretTargetLoop = {
    params ["_turret"];

    private _animSource = uiNamespace getVariable ["TRC_animSource", ""];
    private _targetElev = uiNamespace getVariable ["TRC_targetElev", -1];
    private _targetZ    = uiNamespace getVariable ["TRC_targetZ", -1];
    private _threshold  = uiNamespace getVariable ["TRC_threshold", 0.02];

    // Skip entirely if no targets were set
    if (_targetElev < 0 && _targetZ < 0) exitWith {};

    while {!isNull _turret && {alive _turret}} do {

        private _elevOK = true;
        private _zOK    = true;

        if (_targetElev >= 0) then {
            private _curElev = _turret animationSourcePhase _animSource;
            _elevOK = (abs (_curElev - _targetElev)) <= _threshold;
        };

        if (_targetZ >= 0) then {
            private _curZ = (getDir _turret) / 360;
            private _diff = abs (_curZ - _targetZ);
            if (_diff > 0.5) then { _diff = 1 - _diff; };
            _zOK = _diff <= _threshold;
        };

        private _inThreshold = _elevOK && _zOK;
        private _wasHit      = uiNamespace getVariable ["TRC_targetHit", false];

        if (_inThreshold && !_wasHit) then {
            uiNamespace setVariable ["TRC_targetHit", true];
            call MY_fnc_turretTargetReached;
        };

        if (!_inThreshold && _wasHit) then {
            uiNamespace setVariable ["TRC_targetHit", false];
            call MY_fnc_turretTargetLost;
        };

        sleep 0.1;
    };
};

// ── Called once when both axes hit their target — customize this ─────────
MY_fnc_turretTargetReached = {
    hint "TARGET ALIGNMENT ACHIEVED.";

    private _taskID  = uiNamespace getVariable ["TRC_taskID", ""];

	align_1 = true;
	publicVariable "align_1";

    if (_taskID != "") then {
        [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
        private _turretSnd = uiNamespace getVariable ["TRC_panel", objNull];
        _turretSnd setVariable ["aligned", true, true];
        if (!isNull _turretSnd) then {
            private _turret = uiNamespace getVariable ["TRC_turret", objNull];
            if (!isNull _turret && {!(_turret getVariable ["TRC_soundPlayed", false])}) then {
                _turret setVariable ["TRC_soundPlayed", true, true];
                [_turretSnd, ["device_aligned", 400, 1, false, 0, false]] remoteExec ["say3D", 0];
            };
        };
    };
};

// ── Called when alignment drifts back out of threshold after being hit ───
MY_fnc_turretTargetLost = {
    hint "TARGET ALIGNMENT LOST.";

    private _taskID  = uiNamespace getVariable ["TRC_taskID", ""];

	align_1 = false;
	publicVariable "align_1";

    if (_taskID != "") then {
        //[_taskID, "CREATED"] call BIS_fnc_taskSetState;
    };
};

// ── Handle close ───────────────────────────────────────────────────────
MY_fnc_turretPanelClose = {
    params ["_display", "_exitCode"];
    if (_exitCode == 2) then {
        hint "Rotation control panel closed.";
    };
};

uiNamespace setVariable ["TRC_zDragging", false];

// ── Live Z-slider handler: rotates the turret object directly around its up axis ──
MY_fnc_turretZSliderChanged = {
    params ["_control", "_value"];

    private _display = ctrlParent _control;
    private _turret  = uiNamespace getVariable ["TRC_turret", objNull];

    if (!isNull _turret) then {
        [_turret, (_value * 360)] remoteExec ["setDir", 0];
    };

    (_display displayCtrl 9014) ctrlSetText format ["%1", _value toFixed 3];
};

MY_fnc_turretZSliderDragStart = {
    uiNamespace setVariable ["TRC_zDragging", true];
};

MY_fnc_turretZSliderDragEnd = {
    uiNamespace setVariable ["TRC_zDragging", false];
};

// ── Open the panel ───────────────────────────────────────────────────────
createDialog "TurretRotationControl";

[_turret] spawn MY_fnc_turretTargetLoop;