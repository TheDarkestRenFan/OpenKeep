/datum/job/roguetown
	display_order = JOB_DISPLAY_ORDER_CAPTAIN

/datum/job/roguetown/New()
	. = ..()
	if(give_bank_account)
		for(var/X in GLOB.peasant_positions)
			peopleiknow += X
			peopleknowme += X
		for(var/X in GLOB.serf_positions)
			peopleiknow += X
			peopleknowme += X
		for(var/X in GLOB.church_positions)
			peopleiknow += X
			peopleknowme += X
		for(var/X in GLOB.garrison_positions)
			peopleiknow += X
			peopleknowme += X
		for(var/X in GLOB.noble_positions)
			peopleiknow += X
			peopleknowme += X
		for(var/X in GLOB.apprentices_positions)
			peopleiknow += X
			peopleknowme += X

/datum/outfit/job/roguetown
	uniform = null
	id = null
	ears = null
	belt = null
	back = null
	shoes = null
	box = null
	backpack = null
	satchel  = null
	duffelbag = null
	/// List of patrons we are allowed to use
	var/list/allowed_patrons
	/// Default patron in case the patron is not allowed
	var/datum/patron/default_patron = /datum/patron/divine/astrata

/datum/outfit/job/roguetown/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	var/datum/patron/ourpatron = H.patron
	if(!ourpatron || (allowed_patrons && !(ourpatron.type in allowed_patrons)))
		var/list/datum/patron/possiblegods = list()
		for(var/god in GLOB.patronlist)
			if(!(god in allowed_patrons))
				continue
			possiblegods |= god
			if(possiblegods)
				H.patron = pick(possiblegods)
			else
				H.patron = GLOB.patronlist[default_patron]
		to_chat(H, "<span class='warning'>[ourpatron] had not endorsed my practices in my younger years. I've since grown acustomed to [H.patron].")
	if(H.mind)
		if(H.gender == FEMALE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		if(H.dna)
			H.dna.species.random_underwear(H.gender)
			if(H.dna.species)
				if(H.dna.species.id == "elf")
					H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
				if(H.dna.species.id == "dwarf")
					H.mind.adjust_skillrank(/datum/skill/labor/mining, 1, TRUE)
	H.underwear_color = null
	H.update_body()

/datum/outfit/job/roguetown/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H.mind)
		if(H.ckey)
			if(check_crownlist(H.ckey))
				H.mind.special_items["Champion Circlet"] = /obj/item/clothing/head/roguetown/crown/sparrowcrown
			give_special_items(H)
	for(var/list_key in SStriumphs.post_equip_calls)
		var/datum/triumph_buy/thing = SStriumphs.post_equip_calls[list_key]
		thing.on_activate(H)
	return
