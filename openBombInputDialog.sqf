// ============================================================
//  GENERIC LAUNCH TERMINAL — call per console via addAction
//
//  Usage:
//    [code, pubVarName] execVM "openBombInputDialog.sqf";
//
//  Or from an addAction / holdAction:
//    {[nukeHolderObj, "ZETA-448", "nuke_on_mining_1"] execVM "openBombInputDialog.sqf";}
// ============================================================

private _args = _this;

private _code       = _args param [0, "ZETA-448"];
private _pubVarName = _args param [1, ""];

uiNamespace setVariable ["LNC_code",       _code];
uiNamespace setVariable ["LNC_pubVarName", _pubVarName];

// ── Called when LAUNCH is pressed ─────────────────────────────────────────
MY_fnc_handleInput = {
    params ["_input"];

    private _code       = uiNamespace getVariable ["LNC_code",       ""];
    private _pubVarName = uiNamespace getVariable ["LNC_pubVarName", ""];
    hint _code;

    if (_input == _code) then {
        if (_pubVarName != "") then {
            missionNamespace setVariable [_pubVarName, true];
            publicVariable _pubVarName;
        };

        hint "CODE CORRECT — Nuclear Device Active. Detonation in T-120 seconds.";
    } else {
        hint "INVALID CODE — Detonation aborted.";
    };
};

// ── Called on any close (confirm or cancel) ────────────────────────────────
MY_fnc_onDialogClose = {
    params ["_display", "_exitCode"];
    if (_exitCode == 2) then {
        hint "Detonation aborted.";
    };
};

// ── Open the terminal ──────────────────────────────────────────────────────
createDialog "MyInputDialog";