/datum/sex_action/masturbate/masturbate_container
	name = "Мастурбация в контейнер"

/datum/sex_action/masturbate_container/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/masturbate/masturbate_container/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	var/holding = user.get_active_held_item()
	if(!.)
		return FALSE
	if(!holding)
		return FALSE
	if(!istype(holding, /obj/item/reagent_containers/glass))
		return FALSE
	if(user != target)
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(check_sex_lock(user, ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/masturbate/masturbate_container/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] мастурбирует в [user.get_active_held_item()]..."))

/datum/sex_action/masturbate/masturbate_container/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	var/holding = user.get_active_held_item()
	var/chosen_verb = pick(list("наслаждается собой над [user.get_active_held_item()]", "ласкает себя над [user.get_active_held_item()]", "мастурбирует над [user.get_active_held_item()]"))
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] [chosen_verb]..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	sex_session.perform_sex_action(user, 2, 0, TRUE)

/datum/sex_action/masturbate/masturbate_container/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] заканчивает мастурбацию."))

/datum/sex_action/masturbate/masturbate_container/handle_climax_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	var/holding = user.get_active_held_item()
	var/amout = rand(2, 5)
	user.visible_message(span_love("Кончает!"))
	sex_session.cum_container(holding, amout)
	return "onto"

/datum/sex_action/masturbate/masturbate_container/lock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	sex_locks |= new /datum/sex_session_lock(target, ORGAN_SLOT_PENIS)
