/datum/family_options
	var/datum/family_prefs/prefs

/datum/family_options/New(mob/holder_mob)
	if(holder_mob)
		holder = holder_mob

/datum/family_options/ui_state(mob/user)
	return GLOB.always_state

/datum/family_options/ui_interact(mob/user, datum/tgui/ui)
    prefs = user?.client?.prefs?.family_prefs
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FamilySettingsPanel")
		ui.open()

/datum/family_panel/ui_data(mob/user)
  . = ..()
  var/datum/family_options/prefs = ui.user.prefs
  if(prefs)
    .["familySettings"] = list(
      "familyType" = prefs.family_type,
      "racePreference" = prefs.race_pref,
      "genderPreference" = prefs.gender_pref,
      "checkGenderStrict" = prefs.check_gender_strict,
      "favoriteName" = prefs.fav_name,
      "familyName" = prefs.family_name
    )

/datum/family_options/ui_act(action, params)
  . = ..()
  if(. != TRUE)
    return
  switch(action)
    if("save")
      var/familyType = params["familyType"]
      var/racePreference = params["racePreference"]
	  var/genderPreference = params["genderPreference"]
	  var/familyName = params["familyName"]
	  var/favoriteName = paramns["favoriteName"]
	  var/checkGenderStrict = params["checkGenderStrict"]
      var/datum/family_prefs/prefs = ui.user.client.prefs.family_prefs
      if(prefs)
        prefs.family_type = familyType
        prefs.race_pref = racePreference
        //доделать
      return TRUE
