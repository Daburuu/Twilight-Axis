/datum/family_options

/datum/family_options/ui_state(mob/user)
    return GLOB.always_state

/datum/family_options/ui_interact(mob/user, datum/tgui/ui)
    ui = SStgui.try_update_ui(user, src, ui)
    if(!ui)
        ui = new(user, src, "FamilySettingsPanel")
        ui.open()

/datum/family_options/ui_data(mob/user)
    . = ..()

    var/datum/preferences/P = user?.client?.prefs
    if(!P)
        .["familySettings"] = list()
        return

    .["familySettings"] = list(
        "familyType" = P.family,
        "genderPreference" = P.gender_choice,
        "favoriteName" = P.setspouse
    )

/datum/family_options/ui_act(action, params)
    . = ..()
    if(. != TRUE)
        return

    var/datum/preferences/P = usr?.client?.prefs
    if(!P)
        return

    switch(action)
        if("save")
            P.family = text2num(params["familyType"])
            P.gender_choice = text2num(params["genderPreference"])
            P.setspouse = params["favoriteName"]
            return TRUE