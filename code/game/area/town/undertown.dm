/// under
/area/rogue/under/town
	name = "basement"
	icon_state = "town"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/under/town
/area/rogue/outdoors/exposed/under/town
	icon_state = "town"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/town/sewer
	name = "sewer"
	loot_budget = LOOT_BUDGET_SEWERS
	icon_state = "sewer"
	ambientsounds = AMB_CAVEWATER
	ambientnight = AMB_CAVEWATER
	spookysounds = SPOOKY_RATS
	spookynight = SPOOKY_RATS
	droning_sound = 'sound/music/area/sewers.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambientrain = RAIN_SEWER
	soundenv = 5
	converted_type = /area/rogue/outdoors/exposed/under/sewer
/area/rogue/outdoors/exposed/under/sewer
	icon_state = "sewer"
	droning_sound = 'sound/music/area/sewers.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/town/caverogue
	name = "miningcave (roguetown)"
	icon_state = "caverogue"
	ambientsounds = AMB_GENCAVE
	ambientnight = AMB_GENCAVE
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/under/caves

/area/rogue/outdoors/exposed/under/caves
	icon_state = "caves"
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/town/basement
	name = "basement"
	icon_state = "basement"
	ambientsounds = AMB_BASEMENT
	ambientnight = AMB_BASEMENT
	spookysounds = SPOOKY_DUNGEON
	spookynight = SPOOKY_DUNGEON
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	soundenv = 5
	town_area = TRUE
	converted_type = /area/rogue/outdoors/exposed/under/basement

/area/rogue/under/town/basement/keep
	name = "keep basement"
	icon_state = "basement"
	keep_area = TRUE
	town_area = TRUE
	ceiling_protected = TRUE

/area/rogue/outdoors/exposed/under/basement
	icon_state = "basement"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
//PILGRIM

/area/rogue/under/town/basement/townarena
	name = "The Fulmen Dome"
	first_time_text = "THE FULMEN DOME ARENA"
	droning_sound = 'sound/music/area/townarena.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/town/basement/townarenaview
	name = "The Fulmen Dome Observation"
	first_time_text = "THE FULMEN DOME"
	droning_sound = list('sound/music/area/genericrevelry.ogg', 'sound/music/area/genericcalm.ogg', 'sound/music/area/genericchill.ogg', 'sound/music/area/genericflutey.ogg')
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/outdoors/exposed/under/sewer/grim
	icon_state = "sewer"
	droning_sound = list('sound/music/area/sewerspooky.ogg', 'sound/music/area/sewerdrone.ogg', 'sound/music/area/sewerominous.ogg')
	droning_sound_dusk = null
	droning_sound_night = null
//PILGRIM END
