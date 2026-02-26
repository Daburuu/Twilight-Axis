/datum/family_options
	var/datum/family_prefs/prefs

/datum/family_options/New(mob/holder_mob)
	if(holder_mob)
		var/holder = holder_mob

/datum/family_options/ui_state(mob/user)
	return GLOB.always_state

/datum/family_options/ui_interact(mob/user, datum/tgui/ui)
	var/prefs = user?.client?.prefs?.family_prefs
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FamilySettingsPanel")
		ui.open()

/datum/family_options/ui_data(mob/user)
    . = ..()

    var/mob/living/carbon/human/H = user
    if(!ishuman(H))
        return

    .["familySettings"] = list(
        "familyType" = H.familytree_pref,
        "racePreference" = H.xenophobe,
        "genderPreference" = H.gender_choice_pref,
        "favoriteName" = H.setspouse
    )

/datum/family_options/ui_act(action, params)
    . = ..()
    if(. != TRUE)
        return

    var/mob/living/carbon/human/H = usr
    if(!ishuman(H))
        return

    switch(action)
        if("save")
            H.familytree_pref = text2num(params["familyType"])
            H.xenophobe = text2num(params["racePreference"])
            H.gender_choice_pref = text2num(params["genderPreference"])
            H.setspouse = params["favoriteName"]

            return TRUE
