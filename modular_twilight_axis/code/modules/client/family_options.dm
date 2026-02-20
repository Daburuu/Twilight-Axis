/datum/family_options
	var/mob/living/carbon/human/holder

/datum/family_options/New(mob/holder_mob)
	if(holder_mob)
		holder = holder_mob

/datum/family_options/ui_state(mob/user)
	return GLOB.always_state

/datum/family_options/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FamilySettingsPanel")
		ui.open()

