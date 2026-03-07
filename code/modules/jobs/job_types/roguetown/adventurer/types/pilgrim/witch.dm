/datum/advclass/witch
	name = "Witch"
	tutorial = "You are a witch, seen as wisefolk to some and a demon to many. Ostracized and sequestered for wrongthinks or outright heresy, your potions are what the commonfolk turn to when all else fails, and for this they tolerate you — at an arm's length. Take care not to end 'pon a pyre, for the church condemns your left handed arts."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/witch
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	traits_applied = list(TRAIT_DEATHSIGHT, TRAIT_WITCH, TRAIT_ARCYNE_T2, TRAIT_ALCHEMY_EXPERT)
	subclass_stats = list(
		STATKEY_INT = 3,
		STATKEY_SPD = 2,
		STATKEY_LCK = 1
	)
	subclass_spellpoints = 6
	subclass_skills = list(
		/datum/skill/misc/reading = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/alchemy = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE,
		/datum/skill/labor/farming = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/sewing = SKILL_LEVEL_NOVICE,
		/datum/skill/magic/arcane = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/carpentry = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/adventurer/witch/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/witchhat
	mask = /obj/item/clothing/head/roguetown/roguehood/black
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/phys
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	beltl = /obj/item/storage/magebag
	belt = /obj/item/storage/belt/rogue/leather/black
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
						/obj/item/reagent_containers/glass/mortar = 1,
						/obj/item/pestle = 1,
						/obj/item/candle/yellow = 2,
						/obj/item/recipe_book/alchemy = 1,
						/obj/item/recipe_book/survival = 1,
						/obj/item/recipe_book/magic = 1,
						/obj/item/chalk = 1
						)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/shapeshift/crow)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/guidance)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/arcynebolt)
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/armor/corset
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
		pants = /obj/item/clothing/under/roguetown/skirt/red
	if(H.age == AGE_OLD)
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_LCK, 1)

	switch(H.patron?.type)
		if(/datum/patron/inhumen/zizo)
			H.cmode_music = 'sound/music/combat_heretic.ogg'
			ADD_TRAIT(H, TRAIT_HERESIARCH, TRAIT_GENERIC)
		if(/datum/patron/inhumen/matthios)
			H.cmode_music = 'sound/music/combat_matthios.ogg'
			ADD_TRAIT(H, TRAIT_HERESIARCH, TRAIT_GENERIC)
		if(/datum/patron/inhumen/graggar)
			H.cmode_music = 'sound/music/combat_graggar.ogg'
			ADD_TRAIT(H, TRAIT_HERESIARCH, TRAIT_GENERIC)
		if(/datum/patron/inhumen/baotha)
			H.cmode_music = 'sound/music/combat_baotha.ogg'
			ADD_TRAIT(H, TRAIT_HERESIARCH, TRAIT_GENERIC)
	if(H.mind)
		SStreasury.give_money_account(ECONOMIC_LOWER_MIDDLE_CLASS, H, "Savings.")
<<<<<<< HEAD
=======

/obj/effect/proc_holder/spell/targeted/shapeshift/witch
	die_with_shapeshifted_form = FALSE
	gesture_required = TRUE
	chargetime = 5 SECONDS
	recharge_time = 50
	cooldown_min = 50
	convert_damage = FALSE
	do_gib = FALSE
	knockout_on_death = 10 SECONDS

/obj/effect/proc_holder/spell/targeted/shapeshift/witch/cast(list/targets, mob/user = usr)
	user.visible_message(span_warning("[user] begins to twist and contort!"), span_notice("I begin to transform..."))
	return ..()

/obj/effect/proc_holder/spell/targeted/shapeshift/witch/Shapeshift(mob/living/caster)
	// Do-after before transforming
	if(!do_after(caster, 3 SECONDS, target = caster))
		to_chat(caster, span_warning("Transformation interrupted!"))
		revert_cast(caster)  // Refund the cooldown
		return

	// Call parent to actually transform
	return ..()

/obj/effect/proc_holder/spell/targeted/shapeshift/witch/Restore(mob/living/shape)
	// Check if restrained before allowing revert
	if(shape.restrained(ignore_grab = FALSE))
		to_chat(shape, span_warn("I am restrained, I can't transform back!"))
		revert_cast(shape)  // Refund the cooldown
		return

	// Add do-after for witches when reverting
	shape.visible_message(span_warning("[shape] begins to shift back!"), span_notice("I begin to transform..."))
	if(!do_after(shape, 3 SECONDS, target = shape))
		to_chat(shape, span_warning("Transformation revert interrupted!"))
		revert_cast(shape)  // Refund the cooldown
		return

	return ..()


/obj/effect/proc_holder/spell/targeted/shapeshift/witch/cat
	name = "Cat Form"
	desc = ""
	overlay_state = "cat_transform"
	shapeshift_type = /mob/living/simple_animal/pet/cat/witch_shifted

/obj/effect/proc_holder/spell/targeted/shapeshift/witch/cat/black
	shapeshift_type = /mob/living/simple_animal/pet/cat/rogue/black/witch_shifted

/obj/effect/proc_holder/spell/targeted/shapeshift/witch/lesser_wolf
	name = "Lesser Volf Form"
	desc = ""
	overlay_state = "volf_transform"
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/rogue/wolf/witch_shifted

/obj/effect/proc_holder/spell/targeted/shapeshift/witch/bat
	name = "Bat Form"
	desc = ""
	overlay_state = "bat_transform"
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/bat
	knockout_on_death = 30 SECONDS

/obj/effect/proc_holder/spell/targeted/shapeshift/witch/crow
	name = "Zad Form"
	overlay_state = "zad"
	desc = ""
	knockout_on_death = 15 SECONDS
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/bat/crow
	sound = 'sound/vo/mobs/bird/birdfly.ogg'

/obj/effect/proc_holder/spell/targeted/shapeshift/witch/lesser_vernard
	name = "Lesser Vernard Form"
	desc = ""
	overlay_state = "vernard_transform"
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/rogue/fox/witch_shifted

/obj/effect/proc_holder/spell/targeted/shapeshift/witch/rous
	name = "Small Rous Form"
	desc = ""
	overlay_state = "rous_transform"
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/smallrat/witch_shifted

/obj/effect/proc_holder/spell/targeted/shapeshift/witch/cabbit
	name = "Cabbit Form"
	desc = ""
	overlay_state = "cabbit_transform"
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/rogue/mudcrab/cabbit/witch_shifted

/datum/intent/simple/claw/witch_cat
	name = "scratch"
	attack_verb = list("scratches", "claws")

/mob/living/simple_animal/hostile/retaliate/rogue/wolf/witch_shifted
	name = "lesser volf"
	desc = "A smaller, runtier variant of the classic volf that hounds the woods nearby. Rarely seen around these parts, and doesn't look nearly as dangerous as its larger counterparts. This one has a peculiar intelligence in its yellow eyes..."
	STASPD = 15
	STASTR = 3
	STACON = 5
	melee_damage_lower = 9
	melee_damage_upper = 14
	del_on_deaggro = null
	defprob = 70

/mob/living/simple_animal/pet/cat/witch_shifted
	name = "aloof cat"
	desc = "A bored-seeming feline. This one has a peculiar intelligence in its green eyes..."
	defprob = 90
	STASPD = 18
	STASTR = 1
	STACON = 3
	base_intents = list(/datum/intent/simple/claw/witch_cat)
	melee_damage_lower = 2
	melee_damage_upper = 5

/mob/living/simple_animal/pet/cat/rogue/black/witch_shifted
	name = "voidblack cat"
	desc = "Supposedly sacred to Necra, and just as interested in rats as their lesser counterparts. This one has a strange intelligence behind its dark, wide eyes..."
	defprob = 90
	STASPD = 18
	STASTR = 1
	STACON = 3
	base_intents = list(/datum/intent/simple/claw/witch_cat)
	melee_damage_lower = 2
	melee_damage_upper = 5

/mob/living/simple_animal/hostile/retaliate/rogue/fox/witch_shifted
	name = "lesser vernard"
	desc = "A smaller, runtier variant of the sneaky vernards that skulk the woods nearby. Rarely seen around these parts, and doesn't look nearly as dangerous as its larger counterparts. This one has a peculiar intelligence in its yellow eyes..."
	defprob = 90
	STASPD = 18
	STASTR = 2
	STACON = 4
	melee_damage_lower = 8
	melee_damage_upper = 12
	del_on_deaggro = null
	defprob = 70

/mob/living/simple_animal/hostile/retaliate/smallrat/witch_shifted
	name = "small rous"
	desc = "Supposedly sacred to Pestra, these small and occasionally pestilent creachurs are commonly found in pantries and ships. This one seems to be a bit more smarter than the others..."
	defprob = 90
	STASPD = 18
	STASTR = 1
	STACON = 1
	base_intents = list(/datum/intent/simple/claw/witch_cat)
	melee_damage_lower = 1
	melee_damage_upper = 2

/mob/living/simple_animal/hostile/retaliate/rogue/mudcrab/cabbit/witch_shifted
	name = "lesser cabbit"
	desc = "Seeing one of these quick beasts is said to bring Xylix's fortune, along with their feet. It looks weak and innocent, and incredibly adorable."
	defprob = 90
	STASPD = 20
	STASTR = 1
	STACON = 2
	base_intents = list(/datum/intent/simple/claw/witch_cat)
	melee_damage_lower = 1
	melee_damage_upper = 2
>>>>>>> 425dcc2224a6f9a37810627242d676fb7a4c8997
