/datum/round_event_control/antagonist/solo/aspirants
	name = "Aspirants"
	tags = list(
		TAG_VILLIAN,
	)
	antag_datum = /datum/antagonist/aspirant
	roundstart = TRUE
	antag_flag = ROLE_ASPIRANT
	shared_occurence_type = SHARED_MINOR_THREAT
	minor_roleset = TRUE

<<<<<<< HEAD
	needed_job = list(
		"Consort",
		"Hand",
		"Prince",
		"Princess",
		"Knight Captain",
		"Marshal",
		"Sergeant",
		"Steward",
		"Court Magician"
	)
=======
	needed_job = list(ASPIRANT_ELIGIBLE_POSITIONS)
>>>>>>> 425dcc2224a6f9a37810627242d676fb7a4c8997

	base_antags = 1
	maximum_antags = 2
	max_occurrences = 1

	earliest_start = 0 SECONDS

	weight = 15

	typepath = /datum/round_event/antagonist/solo/aspirants

/datum/round_event/antagonist/solo/aspirants
	var/leader = FALSE

/datum/round_event/antagonist/solo/aspirants/start()
	for(var/datum/mind/antag_mind as anything in setup_minds)
		add_datum_to_mind(antag_mind, antag_mind.current)

<<<<<<< HEAD
	var/list/helping = list("Consort" ,"Hand" ,"Suitor" ,"Prince" ,"Captain" ,"Steward" ,"Court Magician ","Archivist", "Knight", "Knight Captain", "Marshal", "Councillor", "Town Crier", "Keeper", "Veteran")
=======
	var/list/helping = list("Consort" ,"Hand" ,"Suitor" ,"Prince" ,"Captain" ,"Steward" ,"Court Magician ","Archivist", "Knight","Royal Knight", "Marshal", "Councillor", "Town Crier", "Keeper", "Veteran") //TA EDIT
>>>>>>> 425dcc2224a6f9a37810627242d676fb7a4c8997
	var/list/possible_helpers = list()
	for(var/mob/living/living in GLOB.human_list)
		if(!living.client)
			continue
		if(is_banned_from(living.client.ckey, ROLE_ASPIRANT))
			continue
		if(!living.mind?.assigned_role)
			continue
		if(living.mind.assigned_role == "Grand Duke")
			continue
		if(living.mind.assigned_role in GLOB.antagonist_positions)
			continue
		if(!(living.mind?.assigned_role in helping)) //TA EDIT
			continue
		if(living.mind in setup_minds)
			continue
		possible_helpers |= living

	for(var/i in rand(3, 5))
		var/mob/living/helper = pick_n_take(possible_helpers)
		helper?.mind?.special_role = "Supporter"
		helper?.mind?.add_antag_datum(/datum/antagonist/aspirant/supporter)
