/mob/living/carbon/slip(knockdown_amount, obj/O, lube, paralyze, force_drop)
	if(movement_type & FLYING)
		return 0
	if(!(lube&SLIDE_ICE))
		log_combat(src, (O ? O : get_turf(src)), "slipped on the", null, ((lube & SLIDE) ? "(LUBE)" : null))
	return loc.handle_slip(src, knockdown_amount, O, lube, paralyze, force_drop)

/mob/living/carbon/Process_Spacemove(movement_dir = 0)
	if(..())
		return 1
	if(!isturf(loc))
		return 0

/mob/living/carbon/Move(NewLoc, direct)
	. = ..()
	if(. && !(movement_type & FLOATING)) //floating is easy
		if(HAS_TRAIT(src, TRAIT_NOHUNGER))
			set_nutrition(NUTRITION_LEVEL_FED - 1)	//just less than feeling vigorous
			set_hydration(HYDRATION_LEVEL_START_MAX - 1)	//just less than feeling vigorous
		else if(stat != DEAD)
			adjust_nutrition(-(0.05))
			adjust_hydration(-(0.05))
			if(m_intent == MOVE_INTENT_RUN && isnull(buckled))
				adjust_nutrition(-(0.1))
				adjust_hydration(-(0.1))
		if(m_intent == MOVE_INTENT_RUN && isnull(buckled)) //sprint fatigue add
			stamina_add(2)
