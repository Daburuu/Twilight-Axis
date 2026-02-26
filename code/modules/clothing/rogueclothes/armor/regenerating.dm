// REGENERATING ARMOUR

/obj/item/clothing/suit/roguetown/armor/regenerating
	name = "regenerating armour"
	desc = "Abstract parent. Contact developer if you see this."
	icon_state = null
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR

	/// Feedback messages
	var/repairmsg_begin = "My armour begins to slowly mend its abuse.."
	var/repairmsg_continue = "My armour mends some of its abuse.."
	var/repairmsg_stop = "My armour stops mending from the onslaught!"
	var/repairmsg_end = "My armour has become taut with newfound vigor!"

	/// Time taken for regeneration
	var/repair_time
	/// Holder for timer
	var/reptimer

	/// Regen interrupt vars
	var/interrupt_damount
	var/interrupt_dtype
	var/interrupt_dflag
	var/interrupt_ddir

/obj/item/clothing/suit/roguetown/armor/regenerating/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armor_penetration)
	..()
	if(reptimer)
		if(!regen_interrupt(damage_amount, damage_type, damage_flag, attack_dir))
			return
		to_chat(loc, span_notice(repairmsg_stop))
		deltimer(reptimer)

	to_chat(loc, span_notice(repairmsg_begin))
	reptimer = addtimer(CALLBACK(src, PROC_REF(armour_regen)), repair_time, TIMER_OVERRIDE|TIMER_UNIQUE|TIMER_STOPPABLE)

/obj/item/clothing/suit/roguetown/armor/regenerating/proc/armour_regen(var/repair_percent = 0.2 * max_integrity)
	if(obj_integrity >= max_integrity)
		to_chat(loc, span_notice(repairmsg_end))
		if(reptimer)
			deltimer(reptimer)
		return

	to_chat(loc, span_notice(repairmsg_continue))
	obj_integrity = min(obj_integrity + repair_percent, max_integrity)
	if(obj_broken)
		obj_fix(full_repair = FALSE)
	reptimer = addtimer(CALLBACK(src, PROC_REF(armour_regen)), repair_time, TIMER_OVERRIDE|TIMER_UNIQUE|TIMER_STOPPABLE)

/obj/item/clothing/suit/roguetown/armor/regenerating/proc/regen_interrupt(damage_amount, damage_type, damage_flag, attack_dir)
	if(interrupt_damount && interrupt_damount > damage_amount)
		return FALSE
	if(interrupt_dtype && interrupt_dtype != damage_type)
		return FALSE
	if(interrupt_dflag && interrupt_dflag != damage_flag)
		return FALSE
	if(interrupt_ddir && interrupt_ddir != attack_dir)
		return FALSE
	return TRUE


// SKIN ARMOUR

/obj/item/clothing/suit/roguetown/armor/regenerating/skin
	name = "regenerating skin"
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'

	resistance_flags = FIRE_PROOF
	body_parts_covered = COVERAGE_FULL
	body_parts_inherent = COVERAGE_FULL
	flags_inv = null //Exposes the chest and-or breasts.
	surgery_cover = FALSE //Should permit surgery and other invasive processes.
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	armor_class = ARMOR_CLASS_LIGHT
	blocksound = SOFTUNDERHIT
	blade_dulling = DULLING_BASHCHOP
	armor = ARMOR_PADDED

	repairmsg_begin = "My skin begins to slowly mend its abuse.."
	repairmsg_continue = "My skin mends some of its abuse.."
	repairmsg_stop = "My skin stops mending from the onslaught!"
	repairmsg_end = "My skin has become taut with newfound vigor!"

/obj/item/clothing/suit/roguetown/armor/regenerating/skin/Initialize(mapload)
	..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/suit/roguetown/armor/regenerating/skin/dropped(mob/living/carbon/human/user)
	..()
	if(QDELETED(src))
		return
	qdel(src)


/obj/item/clothing/suit/roguetown/armor/regenerating/skin/disciple
	name = "disciple's skin"
	desc = "It's far more than just an oath. </br>'AEON, PSYDON, ADONAI - ENTROPY, HUMENITY, DIVINITY. A TRINITY THAT IS ONE, \
	YET THREE; KNOWN BY ALL, YET FORGOTTEN TO TYME.' </br>'A CORPSE. \
	I AM LIVING ON A FUCKING CORPSE. HE IS THE WORLD, AND THE WORLD IS ROTTING AWAY. \
	HEAVEN CLOSED ITS GATES TO US, LONG AGO.' </br>'YET, HIS CHILDREN PERSIST; AND AS LONG AS THEY DO, SO MUST I. \
	HAPPINESS MUST BE FOUGHT FOR.'"
	armor = list("blunt" = 30, "slash" = 50, "stab" = 50, "piercing" = 20, "fire" = 0, "acid" = 0) //Custom value; padded gambeson's slash- and stab- armor.
<<<<<<< HEAD
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
	max_integrity = 300
	repair_time = 20 SECONDS
=======
	prevent_crits = PREVENT_CRITS_ALL 
	max_integrity = 400
	repair_time = 20 SECONDS

/obj/item/clothing/suit/roguetown/armor/regenerating/skin/iconoclast
	name = "dragon's skin"
	desc = "We passed upon the stair, we spoke of was and when.</br> \
	Although I wasn't there, he said I was his friend.</br> \
	Which came as some surprise. I spoke into his eyes.</br> \
	I thought you died alone, a long, long time ago.</br> \
	Oh no, not me, I never lost control.</br> \
	You're face to face, with the man who sold the world."
	armor = list("blunt" = 40, "slash" = 60, "stab" = 50, "piercing" = 40, "fire" = 50, "acid" = 0) //Fire resistance unlike the disciple one
	prevent_crits = PREVENT_CRITS_ALL 
	max_integrity = 450
	repair_time = 20 SECONDS

/obj/item/clothing/suit/roguetown/armor/regenerating/skin/disciple/barbarian
	name = "barbarian's skin"
	desc = "Toughened from abuse. My mettle remains."
	max_integrity = 200
	repair_time = 25 SECONDS

/obj/item/clothing/suit/roguetown/armor/regenerating/skin/disciple/berserker
	name = "berserker's skin"
	desc = "I've endured enough. The onslaught has lost its meaning."
	armor = ARMOR_LEATHER

/obj/item/clothing/suit/roguetown/armor/regenerating/skin/disciple/bailiff
	name = "executioneer's skin"
	desc = "Bearing scars of countless whips leaves a gnarly visage. Now it's your time to inflict the same fate upon others."
	max_integrity = 250

/obj/item/clothing/suit/roguetown/armor/regenerating/skin/easttats
	name = "bouhoi bujeog tattoos"
	desc = "A mystic style of tattoos adopted by the Ruma Clan, emulating a practice performed by warrior monks of the Xinyi Dynasty. They are your way of identifying fellow clan members, an sign of companionship and secretive brotherhood. These are styled into the shape of clouds, created by a mystical ink which shifts and moves in ripples like a pond to harden where your skin is struck. It's movement causes you to shudder."
	resistance_flags = FIRE_PROOF
	icon_state = "easttats"
	armor = ARMOR_RUMACLAN
	body_parts_covered = COVERAGE_ALL_BUT_HANDFEET
	body_parts_inherent = COVERAGE_ALL_BUT_HANDFEET
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_shirts.dmi'
	allowed_race = NON_DWARVEN_RACE_TYPES
	max_integrity = 270

	repairmsg_begin = "The tattoos begin to slowly mend their abuse..."
	repairmsg_continue = "The tattoos mend some of their abuse..."
	repairmsg_stop = "The tattoos stops mending from the onslaught!"
	repairmsg_end = "The tattoos flow more calmly, as they finish resting and regain their strength."

	interrupt_damount = 25
	repair_time = 35 SECONDS
>>>>>>> f4d0d84b53bec306759b04aa5adae96fe0f9dd0e
