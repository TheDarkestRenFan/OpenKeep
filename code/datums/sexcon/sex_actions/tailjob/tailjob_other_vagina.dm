/datum/sex_action/tailjob_other_vagina
	name = "Stroke their clit with tail"
	check_same_tile = FALSE

/datum/sex_action/tailjob_other_vagina/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.dna.species?.id != "tiefling")
		return FALSE
	if(user == target)
		return FALSE
	if(!(target.gender == FEMALE))
		return FALSE
	return TRUE

/datum/sex_action/tailjob_other_vagina/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.dna.species?.id != "tiefling")
		return FALSE
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN, skipundies = FALSE))
		return FALSE
	if(!(target.gender == FEMALE))
		return FALSE
	return TRUE

/datum/sex_action/tailjob_other_vagina/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message("<span class='danger'>[user] starts stroking [target]'s clit with the tail...</span>")

/datum/sex_action/tailjob_other_vagina/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] strokes [target]'s clit with the tail..."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)

	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/tailjob_other_vagina/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message("<span class='danger'>[user] stops stroking [target]'s clit with the tail.</span>")

/datum/sex_action/tailjob_other_vagina/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
