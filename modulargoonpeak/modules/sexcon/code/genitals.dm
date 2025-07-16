/obj/item/organ/penis/update_erect_state()
	var/oldstate = erect_state
	var/new_state = ERECT_STATE_NONE

	if(owner)
		var/mob/living/carbon/human/human = owner
		if(!human?.sexcon.can_use_penis())
			new_state = ERECT_STATE_NONE
		else if(human.sexcon.arousal > 20 && human.sexcon.manual_arousal == 1 || human.sexcon.manual_arousal == 4)
			new_state = ERECT_STATE_HARD
		else if(human.sexcon.arousal > 10 && human.sexcon.manual_arousal == 1 || human.sexcon.manual_arousal == 3)
			new_state = ERECT_STATE_PARTIAL
		else
			new_state = ERECT_STATE_NONE

	erect_state = new_state
	if(oldstate != erect_state && owner)
		owner.update_body_parts(TRUE)
