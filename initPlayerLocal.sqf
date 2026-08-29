if(isClass(configFile>>"CfgPatches">>"PA_arsenal")||isClass(configFile>>"CfgPatches">>"pafix")||isClass(configFile>>"CfgPatches">>"hpa_arsenal")||isClass(configFile>>"CfgPatches">>"ACEInteractArsenal")) then {
    msg = str (format ["Player %1 tried to connect with an unauthorized mod.", player]);
    [msg] remoteExec ["systemChat", 0];
    forceEnd;
    endMission "END1";
};

player setVariable ["Saved_Loadout",getUnitLoadout player];
player addEventHandler ["Respawn",{

		0 = [_this select 0] spawn {
		
			params [["_player",objNull,[objNull]]];
				waitUntil {sleep .2; alive _player};
				_player setUnitLoadout (_player getVariable ["Saved_Loadout",[]]);
				
		};
}];

player setUnitFreefallHeight 9000;

musicQueue       = [];
musicQueueActive = false;

Push_Song_To_Queue = {
    params ["_song"];
    musicQueue pushBack _song;
    if (!musicQueueActive) then {
        call Play_Next_In_Queue;
    };
};

Pop_Song_From_Queue = {
    params ["_song"];
    private _idx = musicQueue find _song;
    if (_idx >= 0) then { musicQueue deleteAt _idx; };
};

Play_Next_In_Queue = {
    if (count musicQueue > 0) then {
        musicQueueActive = true;
        playMusic (musicQueue select 0);
        musicQueue deleteAt 0;
    } else {
        musicQueueActive = false;
    };
};

Skip_Song_In_Queue = {
    params ["_song"];

    musicQueue = [_song] + musicQueue;

    playMusic "";
    call Play_Next_In_Queue;
};

addMusicEventHandler ["MusicStop", {
    params ["_track", "_reason"];
    if (_reason == 0) then {
        call Play_Next_In_Queue;
    } else {
        musicQueueActive = false;
    };
}];

[] spawn { 
    waitUntil {!isNull console_broadcast}; 
 
    while {alive console_broadcast && (isNil "stop_broadcast")} do {
        console_broadcast say3D  ["broadcast_urf", 100, 1, false, 0, false];
        sleep 136
    }; 
};