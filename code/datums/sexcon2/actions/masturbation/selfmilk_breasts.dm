/datum/sex_action/masturbate/selfmilk_breasts
	name = "Подоить свое молоко в контейнер"

/datum/sex_action/masturbate/selfmilk_breasts/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	if(check_sex_lock(user, ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/selfmilk_breasts/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	var/holding = user.get_active_held_item()
	if(!.)
		return FALSE
	if (!holding)
		return FALSE
	if (!istype(holding, /obj/item/reagent_containers/glass))
		return FALSE
	if(check_sex_lock(user, ORGAN_SLOT_BREASTS))
		return FALSE
	if(user != target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_CHEST, TRUE))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	return TRUE

/datum/sex_action/masturbate/selfmilk_breasts/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	var/holding = user.get_active_held_item()
	user.visible_message(span_warning("[user] начинает доить свою грудь в [holding]..."))

/datum/sex_action/masturbate/selfmilk_breasts/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	var/chosen_verb = pick(list("сжимает свою грудь над [user.get_active_held_item()]", "доит себя в [user.get_active_held_item()]", "сцеживает свое молоко в [user.get_active_held_item()]"))
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] [chosen_verb]..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)


	sex_session.perform_sex_action(user, 2, 0, TRUE)

	sex_session.handle_breast_milking(user, user)

	sex_session.handle_passive_ejaculation(user)

/datum/sex_action/selfmilk_breasts/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] заканчивает себя доить."))

/datum/sex_action/selfmilk_breasts/lock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	sex_locks |= new /datum/sex_session_lock(target, ORGAN_SLOT_BREASTS)
