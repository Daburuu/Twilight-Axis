/datum/reagent/erpjuice
	metabolizing = FALSE

/datum/reagent/erpjuice/cum
	name = "Erotic Fluid"
	description = "A thick, sticky, cream like fluid. produced during an orgasm."
	reagent_state = LIQUID
	color = "#ebebeb"
	taste_description = "salty and tangy"

/datum/reagent/erpjuice/erp_milk
	name = "Breast Milk"
	description = "A thick, transparent milk that clearly doesn't come from a cow."
	reagent_state = LIQUID
	color = "#eee4e4"
	taste_description = "sweet and tart"

/datum/reagent/erpjuice/on_mob_add(mob/living/carbon/M) 
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(HAS_TRAIT(H, TRAIT_CRACKHEAD))
			M.visible_message("<span class='love_mid'>Она радуется, глядя на меня...</span>")
			M.add_stress(/datum/stressevent/nympho_taste/baotha)
		else if(M.has_flaw(/datum/charflaw/addiction/lovefiend))
			M.visible_message("<span class='love_mid'>Как же мне нравится этот вкус...</span>")
			M.add_stress(/datum/stressevent/nympho_taste)
	..()
