
// todo: this setting just disables some treatment options, remove?
[
    QGVAR(advancedDiagnose),
    "CHECKBOX",
    [LSTRING(AdvancedDiagnose_DisplayName), LSTRING(AdvancedDiagnose_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    true,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(advancedBandages),
    "CHECKBOX",
    [LSTRING(AdvancedBandages_DisplayName), LSTRING(AdvancedBandages_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    true,
    true
] call CBA_settings_fnc_init;

// todo: verify that this setting does not require a restart
// todo: this setting requires advanced bandages to be enabled, they should be independent
[
    QGVAR(woundReopening),
    "CHECKBOX",
    [LSTRING(WoundReopening_DisplayName), LSTRING(WoundReopening_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    true,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(advancedMedication),
    "CHECKBOX",
    [LSTRING(AdvancedMedication_DisplayName), LSTRING(AdvancedMedication_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    true,
    true
] call CBA_settings_fnc_init;

// todo: should this setting differentiate between medical vehicles and facilities?
[
    QGVAR(locationsBoostTraining),
    "CHECKBOX",
    [LSTRING(LocationsBoostTraining_DisplayName), LSTRING(LocationsBoostTraining_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    false,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(allowSelfIV),
    "LIST",
    [LSTRING(AllowSelfIV_DisplayName), LSTRING(AllowSelfIV_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    [[0, 1], [ELSTRING(common,No), ELSTRING(common,Yes)], 0],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(allowSharedEquipment),
    "LIST",
    [LSTRING(AllowSharedEquipment_DisplayName), LSTRING(AllowSharedEquipment_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    [[0, 1, 2], [LSTRING(AllowSharedEquipment_PriorityPatient), LSTRING(AllowSharedEquipment_PriorityMedic), ELSTRING(common,No)], 0],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(convertItems),
    "LIST",
    [LSTRING(ConvertItems_DisplayName), LSTRING(ConvertItems_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    [[0, 1, 2], [ELSTRING(common,Enabled), LSTRING(ConvertItems_RemoveOnly), ELSTRING(common,Disabled)], 0],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(medicEpinephrine),
    "LIST",
    [LSTRING(MedicEpinephrine_DisplayName), LSTRING(MedicEpinephrine_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    [[0, 1, 2], [LSTRING(Anyone), LSTRING(Medics), LSTRING(Doctors)], 0],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(locationEpinephrine),
    "LIST",
    [LSTRING(LocationEpinephrine_DisplayName), LSTRING(LocationEpinephrine_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    [[0, 1, 2, 3, 4], [ELSTRING(common,Anywhere), ELSTRING(common,Vehicle), LSTRING(MedicalFacilities), LSTRING(VehiclesAndFacilities), ELSTRING(common,Disabled)], 0],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(medicPAK),
    "LIST",
    [LSTRING(MedicPAK_DisplayName), LSTRING(MedicPAK_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    [[0, 1, 2], [LSTRING(Anyone), LSTRING(Medics), LSTRING(Doctors)], 1],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(locationPAK),
    "LIST",
    [LSTRING(LocationPAK_DisplayName), LSTRING(LocationPAK_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    [[0, 1, 2, 3, 4], [ELSTRING(common,Anywhere), ELSTRING(common,Vehicle), LSTRING(MedicalFacilities), LSTRING(VehiclesAndFacilities), ELSTRING(common,Disabled)], 3],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(consumePAK),
    "LIST",
    [LSTRING(ConsumePAK_DisplayName), LSTRING(ConsumePAK_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    [[0, 1], [ELSTRING(common,No), ELSTRING(common,Yes)], 0],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(medicSurgicalKit),
    "LIST",
    [LSTRING(MedicSurgicalKit_DisplayName), LSTRING(MedicSurgicalKit_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    [[0, 1, 2], [LSTRING(Anyone), LSTRING(Medics), LSTRING(Doctors)], 1],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(locationSurgicalKit),
    "LIST",
    [LSTRING(LocationSurgicalKit_DisplayName), LSTRING(LocationSurgicalKit_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    [[0, 1, 2, 3, 4], [ELSTRING(common,Anywhere), ELSTRING(common,Vehicle), LSTRING(MedicalFacilities), LSTRING(VehiclesAndFacilities), ELSTRING(common,Disabled)], 2],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(consumeSurgicalKit),
    "LIST",
    [LSTRING(ConsumeSurgicalKit_DisplayName), LSTRING(ConsumeSurgicalKit_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Treatment)],
    [[0, 1], [ELSTRING(common,No), ELSTRING(common,Yes)], 0],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(allowLitterCreation),
    "CHECKBOX",
    [LSTRING(AllowLitterCreation_DisplayName), LSTRING(AllowLitterCreation_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Litter)],
    true,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(maxLitterObjects),
    "LIST",
    [LSTRING(MaxLitterObjects_DisplayName), LSTRING(MaxLitterObjects_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Litter)],
    [[50, 100, 200, 300, 400, 500, 1000, 2000, 3000, 4000, 5000], [/* settings function will auto create names */], 5],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(litterCleanUpDelay),
    "SLIDER",
    [LSTRING(LitterCleanUpDelay_DisplayName), LSTRING(LitterCleanUpDelay_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory_Litter)],
    [-1, 3600, 600, 0],
    true
] call CBA_settings_fnc_init;

/*

private _categoryArray = [LELSTRING(medical,Category_DisplayName), LLSTRING(subCategory)];

// Ported Settings:

[
    QEGVAR(medical,CPRcreatesPulse), "CHECKBOX",
    [LSTRING(CPRcreatesPulse), LSTRING(CPRcreatesPulse_Description)],
    _categoryArray,
    true,
    true,
    {[QEGVAR(medical,CPRcreatesPulse), _this] call EFUNC(common,cbaSettings_settingChanged)},
    true
] call CBA_settings_fnc_init;

[
    QEGVAR(medical,PAKTime), "SLIDER",
    [LSTRING(PAKTime), LSTRING(PAKTime_Description)],
    _categoryArray,
    [-1,5000,0,1],
    true,
    {[QEGVAR(medical,PAKTime), _this] call EFUNC(common,cbaSettings_settingChanged)},
    true
] call CBA_settings_fnc_init;

*/