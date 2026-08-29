#define BATTLE_WARD_RUNE_DURATION (1 MINUTES)
#define BATTLE_WARD_TELEGRAPH_TIME (3 SECONDS)

/datum/action/cooldown/spell/battle_ward/spawn_runes(list/turfs, rune_path, caster_name, caster_ckey)
	for(var/turf/T in turfs)
		var/obj/structure/rune_ward/rune = new rune_path(T)
		rune.owner_name = caster_name
		rune.owner_ckey = caster_ckey
		rune.owner_ref = WEAKREF(owner)
		rune.max_integrity = 50
		rune.obj_integrity = 50
		QDEL_IN(rune, BATTLE_WARD_RUNE_DURATION)

#undef BATTLE_WARD_RUNE_DURATION
#undef BATTLE_WARD_TELEGRAPH_TIME

#define BATTLE_WARD_DEBUG_RUNE_DURATION (1 MINUTES)

/datum/action/cooldown/spell/battle_ward/debug
	name = "Battle Ward Diagnostic"
	desc = "Diagnostic version of Battle Ward for live-server testing."
	primary_resource_cost = 0
	charge_required = FALSE
	cooldown_time = 1 SECONDS
	ward_mode = RUNE_WARD_STUN
	ward_modes = list(RUNE_WARD_STUN)

/datum/action/cooldown/spell/battle_ward/debug/spawn_runes(list/turfs, rune_path, caster_name, caster_ckey)
	var/index = 0
	for(var/turf/T in turfs)
		index++
		var/obj/structure/rune_ward/stun/battle_ward_debug/rune = new(T)
		rune.owner_name = caster_name
		rune.owner_ckey = caster_ckey
		rune.owner_ref = WEAKREF(owner)
		rune.max_integrity = 50
		rune.obj_integrity = 50
		rune.debug_spawn_time = world.time
		rune.debug_id = "[caster_ckey]-[world.time]-[index]"
		var/message = "BATTLE WARD DEBUG SPAWN: id=[rune.debug_id] ref=\ref[rune] type=[rune.type] at [AREACOORD(rune)] world.time=[world.time] expected_lifetime=[BATTLE_WARD_DEBUG_RUNE_DURATION]ds integrity=[rune.obj_integrity]/[rune.max_integrity]"
		message_admins(message)
		log_world(message)
		QDEL_IN(rune, BATTLE_WARD_DEBUG_RUNE_DURATION)

/obj/structure/rune_ward/stun/battle_ward_debug
	name = "diagnostic shock rune"
	var/debug_id = "unset"
	var/debug_spawn_time = 0
	var/debug_last_crossed = "none"
	var/debug_last_crossed_time = 0

/obj/structure/rune_ward/stun/battle_ward_debug/Crossed(atom/movable/AM)
	debug_last_crossed = "[AM] ([AM.type])"
	debug_last_crossed_time = world.time
	var/age = world.time - debug_spawn_time
	var/message = "BATTLE WARD DEBUG CROSSED: id=[debug_id] ref=\ref[src] by=[debug_last_crossed] at [AREACOORD(src)] age=[age]ds ([age / 10]s)"
	message_admins(message)
	log_world(message)
	return ..()

/obj/structure/rune_ward/stun/battle_ward_debug/Destroy()
	var/age = world.time - debug_spawn_time
	var/remaining = BATTLE_WARD_DEBUG_RUNE_DURATION - age
	var/last_crossed_age = debug_last_crossed_time ? world.time - debug_last_crossed_time : -1
	var/message = "BATTLE WARD DEBUG DELETE: id=[debug_id] ref=\ref[src] type=[type] at [AREACOORD(src)] age=[age]ds ([age / 10]s) remaining=[remaining]ds integrity=[obj_integrity]/[max_integrity] last_crossed=[debug_last_crossed] last_crossed_age=[last_crossed_age]ds world.time=[world.time]"
	message_admins(message)
	log_world(message)
	if(age < BATTLE_WARD_DEBUG_RUNE_DURATION - 1 SECONDS)
		stack_trace(message)
	return ..()

#undef BATTLE_WARD_DEBUG_RUNE_DURATION
