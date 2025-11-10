/datum/sex_action/milk_breasts
	name = "Подоить грудь в контейнер"
	check_same_tile = FALSE

/datum/sex_action/milk_breasts/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	return TRUE

/datum/sex_action/milk_breasts/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	var/holding = user.get_active_held_item()
	if(istype(holding, /obj/item/reagent_containers/glass) != TRUE)
		return FALSE
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_CHEST, TRUE))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	return TRUE

/datum/sex_action/milk_breasts/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	var/container = user.get_active_held_item()
	user.visible_message(span_warning("[user] начинает доить грудь [target] в [container]..."))

/datum/sex_action/milk_breasts/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	var/container = user.get_active_held_item()
	user.visible_message(sex_session.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] доит грудь [target] в [container]..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	sex_session.perform_sex_action(target, 2, 0, TRUE)

	target.sexcon.handle_breast_milking(user, target)

	sex_session.handle_passive_ejaculation(target)

/datum/sex_action/milk_breasts/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] перестает доить грудь [target] в контейнер."))

/datum/sex_action/milk_breasts/lock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	sex_locks |= new /datum/sex_session_lock(target, ORGAN_SLOT_BREASTS)
