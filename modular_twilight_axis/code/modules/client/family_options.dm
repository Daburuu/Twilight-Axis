/datum/family_options
	parent_type = /datum/tgui

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

    var/datum/preferences/P = usr?.client?.prefs
    if(!P)
        return

    switch(action)
        if("save")

            log_runtime("=== FAMILY SAVE PRESSED ===")
            log_runtime("Params: [json_encode(params)]")

            // ===== FAMILY =====
            switch(params["familyType"])
                if("none")
                    P.family = FAMILY_NONE
                if("member")
                    P.family = FAMILY_PARTIAL
                if("couple")
                    P.family = FAMILY_NEWLYWED
                if("parent")
                    P.family = FAMILY_FULL

            // ===== GENDER =====
            switch(params["genderPreference"])
                if("any")
                    P.gender_choice = ANY_GENDER
                if("same")
                    P.gender_choice = SAME_GENDER
                if("opposite")
                    P.gender_choice = DIFFERENT_GENDER

            // ===== RACE =====
            if(params["racePreference"] == "own")
                P.xenophobe_pref = 1
            else
                P.xenophobe_pref = 0

            // ===== SPOUSE =====
            P.setspouse = params["favoriteName"]

            log_runtime("Saved family value: [P.family]")
            log_runtime("Saved gender choice: [P.gender_choice]")
            log_runtime("Saved xenophobe: [P.xenophobe_pref]")
            log_runtime("Saved spouse: [P.setspouse]")

            return TRUE