#define DEBUG_MODE_FULL
#include "script_component.hpp"
TRACE_1("enter", _this);

#define __TRACKINTERVAL 0    // how frequent the check should be.
#define __LOCKONTIME 3.0    // Lock on won't occur sooner
#define __LOCKONTIMERANDOM 0.3    // Deviation in lock on time
#define __SENSORSQUARE 1    // Locking on sensor square side in angles

#define __OffsetX ((ctrlPosition __JavelinIGUITargetingLineV) select 0) - 0.5
#define __OffsetY ((ctrlPosition __JavelinIGUITargetingLineH) select 1) - 0.5

private["_isJavelin", "_args", "_lastTick", "_runTime", "_soundTime", "_lockTime", "_newTarget", "_currentTarget", "_range", "_pos", "_targetArray"];

if( ! ([ (configFile >> "CfgWeapons" >> (currentWeapon (vehicle ACE_player)) ), "launch_Titan_base"] call EFUNC(common,inheritsFrom))
    || { (vehicle ACE_player) != ACE_player }
  ) exitWith {
    __JavelinIGUITargeting ctrlShow false;
    __JavelinIGUITargetingGate ctrlShow false;
    __JavelinIGUITargetingLines ctrlShow false;
    __JavelinIGUITargetingConstraints ctrlShow false;
    
    [(_this select 1)] call cba_fnc_removePerFrameHandler;
    uiNamespace setVariable["ACE_RscOptics_javelin_PFH", nil];
};

// Reset arguments if we havnt rendered in over a second
_args = uiNamespace getVariable[QGVAR(arguments), [] ];
if( (count _args) > 0) then {
    _lastTick = _args select 0;
    if(diag_tickTime - _lastTick > 1) then {
        [] call FUNC(onOpticLoad);
    };
};

TRACE_1("Running", "Running");

// Pull the arguments
_currentTarget = _args select 1;
_runTime = _args select 2;
_lockTime = _args select 3;
_soundTime = _args select 4;

// Find a target within the optic range
_newTarget = objNull;
        
// Bail on fast movement
if ((velocity ACE_player) distance [0,0,0] > 0.5 && {cameraView == "GUNNER"} && {cameraOn == ACE_player}) exitWith {    // keep it steady.
    ACE_player switchCamera "INTERNAL";
};

// Refresh the firemode
[] call FUNC(showFireMode);
        
_range = parseNumber (ctrlText __JavelinIGUIRangefinder);
TRACE_1("Viewing range", _range);
if (_range > 50 && {_range < 2500}) then {
    _pos = positionCameraToWorld [0,0,_range];
    _targetArray = _pos nearEntities ["AllVehicles", _range/25];
    TRACE_1("Searching at range", _targetArray);
    if (count (_targetArray) > 0) then {
        _newTarget = _targetArray select 0;
    };
};

if (isNull _newTarget) then {
    _newTarget = cursorTarget;
};

// Create constants
_constraintTop = __ConstraintTop;
_constraintLeft = __ConstraintLeft;
_constraintBottom = __ConstraintBottom;
_constraintRight = __ConstraintRight;

_offsetX = __OffsetX;
_offsetY = __OffsetY;

__JavelinIGUITargeting ctrlShow true;
__JavelinIGUITargetingConstrains ctrlShow true;

_zamerny = if (_currentTarget isKindOf "CAManBase") then {_currentTarget selectionPosition "body"} else {_currentTarget selectionPosition "zamerny"};
_randomPosWithinBounds = [(_zamerny select 0) + 1 - (random 2.0),(_zamerny select 1) + 1 - (random 2.0),(_zamerny select 2) + 0.5 - (random 1.0)];

_apos = worldToScreen (_currentTarget modelToWorld _randomPosWithinBounds);
   
_aposX = 0;
_aposY = 0;
if (count _apos < 2) then {
    _aposX = 1;
    _aposY = 0;
} else {
    _aposX = (_apos select 0) + _offsetX;
    _aposY = (_apos select 1) + _offsetY;
};

if((call CBA_fnc_getFoV) select 1 > 9) then {  
    __JavelinIGUINFOV ctrlSetTextColor __ColorGreen;
    __JavelinIGUIWFOV ctrlSetTextColor __ColorGray;
} else {
    __JavelinIGUINFOV ctrlSetTextColor __ColorGray;
    __JavelinIGUIWFOV ctrlSetTextColor __ColorGreen;
};

if (isNull _newTarget) then {
    // No targets found
    _currentTarget = objNull;
    _lockTime = 0;
    
    __JavelinIGUISeek ctrlSetTextColor __ColorGray;
    __JavelinIGUITargeting ctrlShow false;
    __JavelinIGUITargetingGate ctrlShow false;
    __JavelinIGUITargetingLines ctrlShow false;
    __JavelinIGUITargetingConstraints ctrlShow false;
    
    ACE_player setVariable ["ace_missileguidance_target",nil, false];
    
    // Disallow fire
    //if (ACE_player ammo "Javelin" > 0 || {ACE_player ammo "ACE_Javelin_Direct" > 0}) then {ACE_player setWeaponReloadingTime //[player, "Javelin", 0.2];};    
} else {
    if (_newTarget distance ACE_player < 2500
            && {(call CBA_fnc_getFoV) select 1 > 9} 
             && { (currentVisionMode ACE_player == 2)}
             && GVAR(isLockKeyDown)
    ) then {
        // Lock on after 3 seconds
         if(_currentTarget != _newTarget) then {
            TRACE_1("New Target, reseting locking", _newTarget);
            _lockTime = diag_tickTime;
            _currentTarget = _newTarget;
            
            playSound "ACE_Javelin_Locking";
        } else {
            if(diag_tickTime - _lockTime > __LOCKONTIME) then {
                TRACE_2("LOCKED!", _currentTarget, _lockTime);
                
                __JavelinIGUISeek ctrlSetTextColor __ColorGreen;
                
                __JavelinIGUITargeting ctrlShow true;
                __JavelinIGUITargetingConstrains ctrlShow false;
                __JavelinIGUITargetingGate ctrlShow true;
                __JavelinIGUITargetingLines ctrlShow true;

                // Move target marker to coords.
                //__JavelinIGUITargetingLineV ctrlSetPosition [_aposX,ctrlPosition __JavelinIGUITargetingLineV select 1];
                //__JavelinIGUITargetingLineH ctrlSetPosition [ctrlPosition __JavelinIGUITargetingLineH select 0,_aposY];
                //{_x ctrlCommit __TRACKINTERVAL} forEach [__JavelinIGUITargetingLineH,__JavelinIGUITargetingLineV];
                
                _boundsInput = if (_currentTarget isKindOf "CAManBase") then {
                    [_currentTarget,[-1,-1,-2],_currentTarget selectionPosition "body"];
                } else {
                    [_currentTarget,[-1,-1,-2],_currentTarget selectionPosition "zamerny"];
                };
                
                _bpos = _boundsInput call EFUNC(common,worldToScreenBounds);

                _minX = ((_bpos select 0) + _offsetX) max _constraintLeft;
                _minY = ((_bpos select 1) + _offsetY) max _constraintTop;
                _maxX = ((_bpos select 2) + _offsetX) min (_constraintRight - 0.025*(3/4)*SafezoneH);
                _maxY = ((_bpos select 3) + _offsetY) min (_constraintBottom - 0.025*SafezoneH);
                
                TRACE_4("", _boundsInput, _bpos, _minX, _minY);
                
                __JavelinIGUITargetingGateTL ctrlSetPosition [_minX,_minY];
                __JavelinIGUITargetingGateTR ctrlSetPosition [_maxX,_minY];
                __JavelinIGUITargetingGateBL ctrlSetPosition [_minX,_maxY];
                __JavelinIGUITargetingGateBR ctrlSetPosition [_maxX,_maxY];
                
                {_x ctrlCommit __TRACKINTERVAL} forEach [__JavelinIGUITargetingGateTL,__JavelinIGUITargetingGateTR,__JavelinIGUITargetingGateBL,__JavelinIGUITargetingGateBR];
                
                ACE_player setVariable["ace_missileguidance_target", _currentTarget, false];
                
                if(diag_tickTime > _soundTime) then {
                    playSound "ACE_Javelin_Locked";
                    _soundTime = diag_tickTime + 0.25;
                };
            } else {
                __JavelinIGUITargeting ctrlShow true;
                __JavelinIGUITargetingGate ctrlShow true;
                 __JavelinIGUITargetingConstrains ctrlShow true;
                __JavelinIGUITargetingLines ctrlShow false;

                ACE_player setVariable["ace_missileguidance_target", nil, false];
                
                _boundsInput = if (_currentTarget isKindOf "CAManBase") then {
                    [_newTarget,[-1,-1,-2],_currentTarget selectionPosition "body"];
                } else {
                    [_newTarget,[-1,-1,-1],_currentTarget selectionPosition "zamerny"];
                };
                
                _bpos = _boundsInput call EFUNC(common,worldToScreenBounds);
                
                _minX = ((_bpos select 0) + _offsetX) max _constraintLeft;
                _minY = ((_bpos select 1) + _offsetY) max _constraintTop;
                _maxX = ((_bpos select 2) + _offsetX) min (_constraintRight - 0.025*(3/4)*SafezoneH);
                _maxY = ((_bpos select 3) + _offsetY) min (_constraintBottom - 0.025*SafezoneH);
                
                TRACE_4("", _boundsInput, _bpos, _minX, _minY);
                                
                __JavelinIGUITargetingGateTL ctrlSetPosition [_minX,_minY];
                __JavelinIGUITargetingGateTR ctrlSetPosition [_maxX,_minY];
                __JavelinIGUITargetingGateBL ctrlSetPosition [_minX,_maxY];
                __JavelinIGUITargetingGateBR ctrlSetPosition [_maxX,_maxY];
                
                {_x ctrlCommit __TRACKINTERVAL} forEach [__JavelinIGUITargetingGateTL,__JavelinIGUITargetingGateTR,__JavelinIGUITargetingGateBL,__JavelinIGUITargetingGateBR];

                if(diag_tickTime > _soundTime) then {
                    playSound "ACE_Javelin_Locking";
                    _soundTime = diag_tickTime + 0.25;
                };
            };
        };
   } else { 
        // Something is wrong with our seek
        _currentTarget = objNull;
        ACE_player setVariable["ace_missileguidance_target", nil, false];
        
        __JavelinIGUISeek ctrlSetTextColor __ColorGray;
        __JavelinIGUITargeting ctrlShow false;
        __JavelinIGUITargetingGate ctrlShow false;
        __JavelinIGUITargetingLines ctrlShow false;

        ACE_player setVariable ["ace_missileguidance_target",nil, false];
   };
   
};

//TRACE_2("", _newTarget, _currentTarget);

// Save arguments for next run
_args set[0, diag_tickTime];
_args set[1, _currentTarget];
_args set[2, _runTime];
_args set[3, _lockTime];
_args set[4, _soundTime];

uiNamespace setVariable[QGVAR(arguments), _args ];