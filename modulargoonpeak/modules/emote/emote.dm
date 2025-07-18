/* EMOTE DATUMS */
/datum/emote/living
	mob_type_allowed_typecache = /mob/living
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/blush
	key = "blush"
	key_third_person = "краснеет"
	message = "краснеет."

/datum/emote/living/pray
	key = "pray"
	key_third_person = "молится"
	message = "шепчет молитву."
	restraint_check = FALSE
	emote_type = EMOTE_VISIBLE
	// We let people pray unconcious for death-gasp style prayers in crit.
	stat_allowed = list(CONSCIOUS, UNCONSCIOUS)

/mob/living/carbon/human/verb/emote_pray()
	set name = "Молиться"
	set category = "Emotes"

	emote("pray", intentional = TRUE)

//Also see how prayers work in '/code/datums/gods/_patron.dm' for how patrons hear and filter prayers based on profanity, etc.
/datum/emote/living/pray/run_emote(mob/user, params, type_override, intentional)
	var/mob/living/carbon/follower = user
	var/datum/patron/patron = follower.patron

	var/prayer = input("Прошепчи свою молитву:", "Молитва") as text|null
	if(!prayer)
		return

	//If God can hear your prayer (long enough, no bad words, etc.)
	if(patron.hear_prayer(follower, prayer))
		if(follower.has_flaw(/datum/charflaw/addiction/godfearing))
			// Stops prayers if you don't meet your patron's requirements to pray.
			if(!patron?.can_pray(follower))
				return
			else
				follower.sate_addiction()

	/* admin stuff - tells you the followers name, key, and what patron they follow */
	var/follower_ident = "[follower.key]/([follower.real_name]) (follower of [patron])"
	message_admins("[follower_ident] [ADMIN_SM(follower)] [ADMIN_FLW(follower)] prays: [span_info(prayer)]")
	user.log_message("(follower of [patron]) prays: [prayer]", LOG_GAME)

	follower.whisper(prayer)

	if(SEND_SIGNAL(follower, COMSIG_CARBON_PRAY, prayer) & CARBON_PRAY_CANCEL)
		return

	for(var/mob/living/LICKMYBALLS in hearers(2,src))	// Lickmyballs = person in crit.
		LICKMYBALLS.succumb_timer = world.time			//..succumb timer does nothing rn btw..

/datum/emote/living/meditate
	key = "meditate"
	key_third_person = "медитирует"
	message = "медитирует."
	restraint_check = FALSE
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_meditate()
	set name = "Медитировать"
	set category = "Emotes"

	emote("meditate", intentional = TRUE)

/datum/emote/living/meditate/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(do_after(user, 1 MINUTES))
		user.add_stress(/datum/stressevent/meditation)
		to_chat(user, span_green("My meditations were rewarding."))

/datum/emote/living/bow
	key = "bow"
	key_third_person = "кланяется"
	message = "кланяется."
	message_param = "кланяется в сторону %t."
	restraint_check = TRUE
	emote_type = EMOTE_VISIBLE

/datum/emote/living/bow/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(. && params && isliving(user))
		var/mob/living/L = user
		var/list/split_params = splittext(params, " ")
		var/mob/target = get_target(L, split_params)
		if(target && ishuman(target))
			var/mob/living/carbon/human/H = target
			if(HAS_TRAIT(H, TRAIT_NOBLE))
				H.add_stress(/datum/stressevent/noble_bowed_to)

/mob/living/carbon/human/verb/emote_bow()
	set name = "Поклон"
	set category = "Emotes"

	emote("bow", intentional = TRUE)

/datum/emote/living/burp
	key = "burp"
	key_third_person = "рыгает"
	message = "рыгает."
	message_muffled = "издает приглушенный звук."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_burp()
	set name = "Рыгнуть"
	set category = "Noises"

	emote("burp", intentional = TRUE)

/datum/emote/living/choke
	key = "choke"
	key_third_person = "задыхается"
	message = "задыхается!"
	emote_type = EMOTE_AUDIBLE
	ignore_silent = TRUE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_choke()
	set name = "Задыхаться"
	set category = "Noises"

	emote("choke", intentional = TRUE)

/datum/emote/living/cross
	key = "crossarms"
	key_third_person = "cкладывает руки"
	message = "складывает свои руки."
	restraint_check = TRUE
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_crossarms()
	set name = "Сложить руки"
	set category = "Emotes"

	emote("crossarms", intentional = TRUE)

/datum/emote/living/collapse
	key = "collapse"
	key_third_person = "теряет сознание"
	message = "теряет сознание."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/collapse/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Unconscious(40)

/datum/emote/living/whisper
	key = "whisper"
	key_third_person = "шепчет"
	message = "шепчет."
	message_mime = "делает вид, что шепчет."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/aggro
	key = "aggro"
	key_third_person = "aggro"
	message = ""
	nomsg = TRUE
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/cough
	key = "cough"
	key_third_person = "кашляет"
	message = "кашляет."
	message_muffled = "издает приглушенный звук."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_cough()
	set name = "Кашлять"
	set category = "Noises"

	emote("cough", intentional = TRUE)

/datum/emote/living/clearthroat
	key = "clearthroat"
	key_third_person = "прокашливается"
	message = "прокашливается."
	message_muffled = "издает приглушенный звук."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_clearthroat()
	set name = "Прокашляться"
	set category = "Noises"

	emote("clearthroat", intentional = TRUE)

/datum/emote/living/dance
	key = "dance"
	key_third_person = "танцует"
	message = "танцует."
	restraint_check = TRUE
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_dance()
	set name = "Танцевать"
	set category = "Emotes"

	emote("dance", intentional = TRUE)

/datum/emote/living/deathgasp
	key = ""
	key_third_person = ""
	message = "испускает последний вздох."
	message_monkey = "издает слабый звук, падает и переставает двигаться..."
	message_simple =  "falls limp."
	stat_allowed = UNCONSCIOUS

/datum/emote/living/deathgasp/run_emote(mob/user, params, type_override, intentional)
	var/mob/living/simple_animal/S = user
	if(istype(S) && S.deathmessage)
		message_simple = S.deathmessage
	. = ..()
	message_simple = initial(message_simple)
	if(. && user.deathsound)
		if(isliving(user))
			var/mob/living/L = user
			if(!L.can_speak_vocal() || L.oxyloss >= 50)
				return //stop the sound if oxyloss too high/cant speak
		playsound(user, user.deathsound, 200, TRUE, TRUE)

/datum/emote/living/drool
	key = "drool"
	key_third_person = "несёт чепуху"
	message = "несёт чепуху."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_drool()
	set name = "Нести чепуху"
	set category = "Emotes"

	emote("drool", intentional = TRUE)

/datum/emote/living/faint
	key = "faint"
	key_third_person = "теряет сознание"
	message = "теряет сознание."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_faint()
	set name = "Обморок"
	set category = "Emotes"

	emote("faint", intentional = TRUE)

/datum/emote/living/faint/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/L = user
		if(L.get_complex_pain() > (L.STACON * 9))
			L.setDir(2)
			L.SetUnconscious(200)
		else
			L.Knockdown(10)

/datum/emote/living/flap
	key = "flap"
	key_third_person = "машет крыльями"
	message = "машет крыльями."
	restraint_check = TRUE
	var/wing_time = 20

/datum/emote/living/carbon/human/flap/can_run_emote(mob/user, status_check = TRUE , intentional)
	return FALSE

/datum/emote/living/flap/aflap
	key = "aflap"
	key_third_person = "машет крыльями!"
	message = "агрессивно машет крыльями!"
	restraint_check = TRUE
	wing_time = 10

/datum/emote/living/carbon/human/aflap/can_run_emote(mob/user, status_check = TRUE , intentional)
	return FALSE

/datum/emote/living/frown
	key = "frown"
	key_third_person = "хмурится"
	message = "хмурится."
	emote_type = EMOTE_VISIBLE
/mob/living/carbon/human/verb/emote_frown()
	set name = "Хмуриться"
	set category = "Emotes"

	emote("frown", intentional = TRUE)

/datum/emote/living/gag
	key = "gag"
	key_third_person = "давится"
	message = "давится."
	emote_type = EMOTE_AUDIBLE
	ignore_silent = TRUE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_gag()
	set name = "Подавиться"
	set category = "Noises"

	emote("gag", intentional = TRUE)

/datum/emote/living/gasp
	key = "gasp"
	key_third_person = "ахает"
	message = "ахает!"
	message_muffled = "издает приглушенный звук."
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_gasp()
	set name = "Ахнуть"
	set category = "Noises"

	emote("gasp", intentional = TRUE)

/datum/emote/living/breathgasp
	key = "breathgasp"
	key_third_person = "задыхается"
	message = "задыхается!"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/giggle
	key = "giggle"
	key_third_person = "смеётся"
	message = "смеётся."
	message_mime = "слегка смеется!"
	message_muffled = "издает приглушенный смех."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/giggle/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(.)
		// Apply Xylix buff to those with the trait who hear the giggling
		// Only apply if the hearer is not the one laughing
		for(var/mob/living/carbon/human/H in hearers(7, user))
			if(H == user || !H.client)
				continue
			if(HAS_TRAIT(H, TRAIT_XYLIX) && !H.has_status_effect(/datum/status_effect/buff/xylix_joy))
				H.apply_status_effect(/datum/status_effect/buff/xylix_joy)
				to_chat(H, span_info("Смех продливает жизнь!"))

/mob/living/carbon/human/verb/emote_giggle()
	set name = "Смеяться"
	set category = "Noises"

	emote("giggle", intentional = TRUE)

/datum/emote/living/chuckle
	key = "chuckle"
	key_third_person = "посмеивается"
	message = "издаёт смешок."
	message_muffled = "приглушенно насмехаеться."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/chuckle/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(.)
		// Apply Xylix buff to those with the trait who hear the chuckling
		// Only apply if the hearer is not the one chuckling
		for(var/mob/living/carbon/human/H in hearers(7, user))
			if(H == user || !H.client)
				continue
			if(HAS_TRAIT(H, TRAIT_XYLIX) && !H.has_status_effect(/datum/status_effect/buff/xylix_joy))
				H.apply_status_effect(/datum/status_effect/buff/xylix_joy)
				to_chat(H, span_info("Смех продливает жизнь!"))

/mob/living/carbon/human/verb/emote_chuckle()
	set name = "Издать смешок"
	set category = "Noises"

	emote("chuckle", intentional = TRUE)

/datum/emote/living/glare
	key = "glare"
	key_third_person = "глядит"
	message = "глядит."
	message_param = "глядит на %t."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_glare()
	set name = "Глядеть"
	set category = "Emotes"

	emote("glare", intentional = TRUE)

/datum/emote/living/grin
	key = "grin"
	key_third_person = "ухмыляется"
	message = "ухмыляется."
	emote_type = EMOTE_VISIBLE
/mob/living/carbon/human/verb/emote_grin()
	set name = "Ухмыляться"
	set category = "Emotes"

	emote("grin", intentional = TRUE)

/datum/emote/living/groan
	key = "groan"
	key_third_person = "стонет"
	message = "стонет."
	message_muffled = "издает приглушенный стон."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_groan()
	set name = "Стонать"
	set category = "Noises"

	emote("groan", intentional = TRUE)

/datum/emote/living/grimace
	key = "grimace"
	key_third_person = "корчит гримасу"
	message = "корчит гримасу."
	emote_type = EMOTE_VISIBLE
/mob/living/carbon/human/verb/emote_grimace()
	set name = "Корчить гримасу"
	set category = "Emotes"

	emote("grimace", intentional = TRUE)

/datum/emote/living/jump
	key = "jump"
	key_third_person = "прыгает"
	message = "прыгает!"
	restraint_check = TRUE

/datum/emote/living/leap
	key = "leap"
	key_third_person = "Наскакиевает!"
	message = "совершает наскок!"
	restraint_check = TRUE
	only_forced_audio = TRUE

/datum/emote/living/kiss
	key = "kiss"
	key_third_person = "целует"
	message = "посылает воздушный поцелуй."
	message_param = "целует %t."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_kiss()
	set name = "Поцеловать"
	set category = "Emotes"

	emote("kiss", intentional = TRUE, targetted = TRUE)

/datum/emote/living/kiss/adjacentaction(mob/user, mob/target)
	. = ..()
	message_param = initial(message_param) // re
	if(!user || !target)
		return
	if(ishuman(user) && ishuman(target))
		var/mob/living/carbon/human/H = user
		var/do_change
		if(target.loc == user.loc)
			do_change = TRUE
		if(!do_change)
			if(H.pulling == target)
				do_change = TRUE
		if(do_change)
			if(H.zone_selected == BODY_ZONE_PRECISE_MOUTH)
				message_param = "страстно целует %t."
			else if(H.zone_selected == BODY_ZONE_PRECISE_EARS)
				message_param = "целует %t в ухо."
				var/mob/living/carbon/human/E = target
				if(iself(E) || ishalfelf(E) || isdarkelf(E))
					if(!E.cmode)
						to_chat(target, span_love("это щекотно..."))
			else if(H.zone_selected == BODY_ZONE_PRECISE_R_EYE || H.zone_selected == BODY_ZONE_PRECISE_L_EYE)
				message_param = "целует %t в бровь."
			else if(H.zone_selected == BODY_ZONE_PRECISE_SKULL)
				message_param = "целует %t в лоб."
			else
				message_param = "целует %t в \the [parse_zone(H.zone_selected)]."
	playsound(target.loc, pick('sound/vo/kiss (1).ogg','sound/vo/kiss (2).ogg'), 100, FALSE, -1)
	if(user.mind)
		GLOB.azure_round_stats[STATS_KISSES_MADE]++


/datum/emote/living/spit
	key = "spit"
	key_third_person = "плюёт"
	message = "плюёт на пол."
	message_param = "плюет на %t."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_spit()
	set name = "Плюнуть"
	set category = "Emotes"

	emote("spit", intentional = TRUE, targetted = TRUE)


/datum/emote/living/spit/run_emote(mob/user, params, type_override, intentional)
	message_param = initial(message_param) // reset
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.mouth)
			if(H.mouth.spitoutmouth)
				H.visible_message(span_warning("[H] выплёвывает [H.mouth]."))
				H.dropItemToGround(H.mouth, silent = FALSE)
			return
	..()

/datum/emote/living/spit/adjacentaction(mob/user, mob/target)
	. = ..()
	if(!user || !target)
		return
	if(user.gender == MALE)
		playsound(target.loc, pick('sound/vo/male/gen/spit.ogg'), 100, FALSE, -1)
	else
		playsound(target.loc, pick('sound/vo/female/gen/spit.ogg'), 100, FALSE, -1)


/datum/emote/living/hug
	key = "hug"
	key_third_person = "обнимает"
	message = ""
	message_param = "обнимает %t."
	emote_type = EMOTE_VISIBLE
	restraint_check = TRUE

/mob/living/carbon/human/verb/emote_hug()
	set name = "Обнять"
	set category = "Emotes"

	emote("hug", intentional = TRUE, targetted = TRUE)

/datum/emote/living/hug/adjacentaction(mob/user, mob/target)
	. = ..()
	if(!user || !target)
		return
	if(ishuman(target))
		playsound(target.loc, pick('sound/vo/hug.ogg'), 100, FALSE, -1)
		if(user.mind)
			GLOB.azure_round_stats[STATS_HUGS_MADE]++
			SEND_SIGNAL(user, COMSIG_MOB_HUGGED, target)

/datum/emote/living/holdbreath
	key = "hold"
	key_third_person = "задерживает дыхание"
	message = "задерживает дыхание."
	stat_allowed = SOFT_CRIT

/mob/living/carbon/human/verb/emote_hold()
	set name = "Задержать дыхание"
	set category = "Emotes"

	emote("hold", intentional = TRUE)

/datum/emote/living/holdbreath/can_run_emote(mob/living/user, status_check = TRUE, intentional)
	. = ..()
	if(. && intentional && !HAS_TRAIT(user, TRAIT_HOLDBREATH) && !HAS_TRAIT(user, TRAIT_PARALYSIS))
		to_chat(user, span_warning("Я не в таком отчаянии, чтобы делать это!."))
		return FALSE

/datum/emote/living/holdbreath/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(.)
		if(HAS_TRAIT(user, TRAIT_HOLDBREATH))
			REMOVE_TRAIT(user, TRAIT_HOLDBREATH, "[type]")
		else
			ADD_TRAIT(user, TRAIT_HOLDBREATH, "[type]")

/datum/emote/living/holdbreath/select_message_type(mob/user, intentional)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_HOLDBREATH))
		. = "снова дышит."

/datum/emote/living/slap
	key = "slap"
	key_third_person = "шлёпает"
	message = ""
	message_param = "дает %t пощёчину."
	emote_type = EMOTE_VISIBLE
	restraint_check = TRUE


/datum/emote/living/slap/run_emote(mob/user, params, type_override, intentional)
	message_param = initial(message_param)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.zone_selected == BODY_ZONE_PRECISE_GROIN)
			message_param = "шлепает %t по жопе!"
		else if(H.zone_selected == BODY_ZONE_PRECISE_SKULL)
			message_param = "шлёпает голову %t!"
		else if(H.zone_selected == BODY_ZONE_PRECISE_L_HAND || H.zone_selected == BODY_ZONE_PRECISE_R_HAND)
			message_param = "шлёпает %t по руке!"
	..()

/mob/living/carbon/human/verb/emote_slap()
	set name = "Шлёпнуть"
	set category = "Emotes"

	emote("slap", intentional = TRUE, targetted = TRUE)

/datum/emote/living/slap/adjacentaction(mob/user, mob/target)
	. = ..()
	if(!user || !target)
		return
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.flash_fullscreen("redflash3")
		H.AdjustSleeping(-50)
		playsound(target.loc, 'sound/foley/slap.ogg', 100, TRUE, -1)

/datum/emote/living/pinch
	key = "pinch"
	key_third_person = "щипает"
	message = ""
	message_param = "щипает %t."
	emote_type = EMOTE_VISIBLE
	restraint_check = TRUE

/datum/emote/living/pinch/adjacentaction(mob/user, mob/target)
	. = ..()
	if(!user || !target)
		return
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.flash_fullscreen("redflash1")

/mob/living/carbon/human/verb/emote_pinch()
	set name = "Ущипнуть"
	set category = "Emotes"

	emote("pinch", intentional = TRUE, targetted = TRUE)

/datum/emote/living/laugh/run_emote(mob/user, params, type_override, intentional, targetted)
	. = ..()
	if(. && user.mind)
		GLOB.azure_round_stats[STATS_LAUGHS_MADE]++

/datum/emote/living/laugh
	key = "laugh"
	key_third_person = "смеется"
	message = "смеется."
	message_mime = "беззвучно смеется!"
	message_muffled = "издает приглушенный смех."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/laugh/can_run_emote(mob/living/user, status_check = TRUE , intentional)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		return !C.silent

/datum/emote/living/laugh/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(.)
		// Apply Xylix buff to those with the trait who hear the laughter
		// Only apply if the hearer is not the one laughing
		for(var/mob/living/carbon/human/H in hearers(7, user))
			if(H == user || !H.client)
				continue
			if(HAS_TRAIT(H, TRAIT_XYLIX) && !H.has_status_effect(/datum/status_effect/buff/xylix_joy))
				H.apply_status_effect(/datum/status_effect/buff/xylix_joy)
				to_chat(H, span_info("Смех продливает жизнь!"))

/mob/living/carbon/human/verb/emote_laugh()
	set name = "Рассмеяться"
	set category = "Noises"

	emote("laugh", intentional = TRUE)

/datum/emote/living/look
	key = "look"
	key_third_person = "пялится"
	message = "пялится."
	message_param = "пялится на %t."

/datum/emote/living/nod
	key = "nod"
	key_third_person = "кивает"
	message = "кивает."
	message_param = "кивает в сторону %t."
	emote_type = EMOTE_VISIBLE
/mob/living/carbon/human/verb/emote_nod()
	set name = "Кивнуть"
	set category = "Emotes"

	emote("nod", intentional = TRUE)

/datum/emote/living/point
	key = "point"
	key_third_person = "показывает"
	message = "показывает."
	message_param = "показывает на %t."
	restraint_check = TRUE

/datum/emote/living/point/run_emote(mob/user, params, type_override, intentional)
	message_param = initial(message_param) // reset
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.get_num_arms() == 0)
			if(H.get_num_legs() != 0)
				message_param = "пытается показать на %t своей ногой и <span class='danger'>падает</span>!"
				H.Paralyze(20)
			else
				message_param = "<span class='danger'>стукается [user.p_their()] головой о землю,</span> пытаясь указывать ей на %t."
				H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5)
	..()

/datum/emote/living/pout
	key = "pout"
	key_third_person = "дуется"
	message = "дуется."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/scream
	key = "scream"
	key_third_person = "кричит"
	message = "кричит!"
	message_mime = "изображает крик!"
	message_muffled = "издает приглушенный звук, пытаясь кричать!"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_scream()
	set name = "Кричать"
	set category = "Noises"

	emote("scream", intentional = TRUE)

/datum/emote/living/scream/can_run_emote(mob/living/user, status_check = TRUE , intentional)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		if(intentional)
			if(!C.stamina_add(10))
				to_chat(C, span_warning("Я пытаюсь кричать, но у меня нет голоса."))
				. = FALSE

/datum/emote/living/scream/run_emote(mob/user, params, type_override, intentional, targetted)
	. = ..()
	if(. && user.mind)
		record_featured_stat(FEATURED_STATS_SCREAMERS, user)

/datum/emote/living/scream/painscream
	key = "painscream"
	message = "кричит от боли!"
	emote_type = EMOTE_AUDIBLE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/scream/painscream/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(.)
		for(var/mob/living/carbon/human/L in viewers(7,user))
			if(L == user)
				continue
			if(L.has_flaw(/datum/charflaw/addiction/sadist))
				L.sate_addiction()

/datum/emote/living/scream/strain
	key = "strain"
	message = "напрягается!"
	emote_type = EMOTE_AUDIBLE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/scream/agony
	key = "agony"
	message = "кричит в агонии!"
	emote_type = EMOTE_AUDIBLE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/scream/agony/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(.)
		for(var/mob/living/carbon/human/L in viewers(7,user))
			if(L == user)
				continue
			if(L.has_flaw(/datum/charflaw/addiction/sadist))
				L.sate_addiction()

/datum/emote/living/scream/firescream
	key = "firescream"
	nomsg = TRUE
	emote_type = EMOTE_AUDIBLE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/scream/firescream/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(.)
		for(var/mob/living/carbon/human/L in viewers(7,user))
			if(L == user)
				continue
			if(L.has_flaw(/datum/charflaw/addiction/sadist))
				L.sate_addiction()

/datum/emote/living/aggro
	key = "aggro"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/idle
	key = "idle"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/death
	key = "death"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	stat_allowed = UNCONSCIOUS
	mob_type_ignore_stat_typecache = list(/mob/living)
	show_runechat = FALSE

/datum/emote/living/pain
	key = "pain"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/drown
	key = "drown"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	ignore_silent = TRUE
	show_runechat = FALSE

/datum/emote/living/paincrit
	key = "paincrit"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/embed
	key = "embed"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/painmoan
	key = "painmoan"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/groin
	key = "groin"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/fatigue
	key = "fatigue"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/jump
	key = "jump"
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/haltyell
	key = "haltyell"
	message = "shouts a halt!"
	emote_type = EMOTE_AUDIBLE
	only_forced_audio = TRUE
	show_runechat = FALSE

/datum/emote/living/rage
	key = "rage"
	message = "кричит в ярости!"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_rage()
	set name = "Яростный крик"
	set category = "Noises"

	emote("rage", intentional = TRUE)

/datum/emote/living/rage/run_emote(mob/user, params, type_override, intentional, targetted)
	. = ..()
	if(. && user.mind)
		GLOB.azure_round_stats[STATS_WARCRIES]++

/datum/emote/living/attnwhistle
	key = "attnwhistle"
	message = "свистит, привлекая внимание!"
	message_muffled = "издает приглушенный звук."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_attnwhistle()
	set name = "Свистнуть"
	set category = "Noises"

	emote("attnwhistle", intentional = TRUE)

/datum/emote/living/choke
	key = "choke"
	key_third_person = "задыхается"
	message = "задыхается!"
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/scowl
	key = "scowl"
	key_third_person = "сердится"
	message = "сердится."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/shakehead
	key = "shakehead"
	key_third_person = "трясет головой"
	message = "трясет головой."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_shakehead()
	set name = "Трясти головой"
	set category = "Emotes"

	emote("shakehead", intentional = TRUE)


/datum/emote/living/shiver
	key = "shiver"
	key_third_person = "дрожит"
	message = "дрожит."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_shiver()
	set name = "Дрожать"
	set category = "Emotes"

	emote("shiver", intentional = TRUE)


/datum/emote/living/sigh
	key = "sigh"
	key_third_person = "вздыхает"
	message = "вздыхает."
	message_muffled = "издает приглушенный вздох."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_sigh()
	set name = "Вздохнуть"
	set category = "Noises"

	emote("sigh", intentional = TRUE)

/datum/emote/living/whistle
	key = "whistle"
	key_third_person = "насвистывает"
	message = "насвистывает."
	message_muffled = "издает приглушенный звук."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_whistle()
	set name = "Насвистывать"
	set category = "Noises"

	emote("whistle", intentional = TRUE)

/datum/emote/living/hmm
	key = "hmm"
	key_third_person = "хмм..."
	message = "хмм..."
	message_muffled = "издает приглушенный хмм..."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_hmm()
	set name = "Хмм..."
	set category = "Noises"

	emote("hmm", intentional = TRUE)

/datum/emote/living/huh
	key = "huh"
	key_third_person = "?"
	message_muffled = "издает приглушенный звук."
	emote_type = EMOTE_AUDIBLE
	nomsg = TRUE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_huh()
	set name = "?"
	set category = "Noises"

	emote("huh", intentional = TRUE)

/datum/emote/living/hum
	key = "hum"
	key_third_person = "напевает"
	message = "напевает."
	emote_type = EMOTE_AUDIBLE
	message_muffled = "издает приглушенное напевание."
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_hum()
	set name = "Напевать"
	set category = "Noises"

	emote("hum", intentional = TRUE)

/datum/emote/living/smile
	key = "smile"
	key_third_person = "улыбается"
	message = "улыбается."
	emote_type = EMOTE_VISIBLE
/mob/living/carbon/human/verb/emote_smile()
	set name = "Улыбнуться"
	set category = "Emotes"

	emote("smile", intentional = TRUE)

/datum/emote/living/sneeze
	key = "sneeze"
	key_third_person = "чихает"
	message = "чихает."
	message_muffled = "издает приглушенный чих."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/shh
	key = "shh"
	key_third_person = "шипит"
	message = "шипит."
	message_muffled = "издает приглушенное шипение."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_shh()
	set name = "Тсс..."
	set category = "Noises"

	emote("shh", intentional = TRUE)

/datum/emote/living/smug
	key = "smug"
	key_third_person = "гордится собой"
	message = "самодовольно ухмыляется."

/datum/emote/living/sniff
	key = "sniff"
	key_third_person = "нюхает"
	message = "нюхает."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/datum/emote/living/snore
	key = "snore"
	key_third_person = "храпит"
	message = "храпит."
	message_mime = "громко храпит."
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS
	snd_range = -4
	show_runechat = FALSE

/datum/emote/living/stare
	key = "stare"
	key_third_person = "пялится"
	message = "пялится."
	message_param = "пялится на %t."

/datum/emote/living/strech
	key = "stretch"
	key_third_person = "потягивается"
	message = "растягивает свои руки."

/datum/emote/living/sulk
	key = "sulk"
	key_third_person = "sulks"
	message = "sulks down sadly."

/datum/emote/living/sway
	key = "sway"
	key_third_person = "покачивается"
	message = "покачивается."

/datum/emote/living/tremble
	key = "tremble"
	key_third_person = "дрожжит"
	message = "дрожжит в страхе!"

/datum/emote/living/twitch
	key = "twitch"
	key_third_person = "дрожжит"
	message = "сильно дрожжит."

/datum/emote/living/twitch_s
	key = "twitch_s"
	message = "дрожжит."
	stat_allowed = UNCONSCIOUS
	mob_type_ignore_stat_typecache = list(/mob/living/carbon/human)

/datum/emote/living/warcry
	key = "warcry"
	key_third_person = "издает боевой клич"
	message = "издает боевой клич!"
	emote_type = EMOTE_AUDIBLE
	message_muffled = "издает приглушенный ор!"
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_warcry()
	set name = "Боевой клич"
	set category = "Noises"

	emote("warcry", intentional = TRUE)

/datum/emote/living/wave
	key = "wave"
	key_third_person = "машет"
	message = "машет."

/datum/emote/living/whimper
	key = "whimper"
	key_third_person = "хнычет"
	message = "хнычет."
	message_mime = "кажется раненным."
	message_muffled = "издает приглушенный всхлип."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_whimper()
	set name = "Хныкать"
	set category = "Noises"

	emote("whimper", intentional = TRUE)

/datum/emote/living/wsmile
	key = "wsmile"
	key_third_person = "слабо улыбается"
	message = "слабо улыбается."

/datum/emote/living/yawn
	key = "yawn"
	key_third_person = "зевает"
	message = "зевает."
	message_muffled = "издает приглушенный зевок."
	emote_type = EMOTE_AUDIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_yawn()
	set name = "Зевнуть"
	set category = "Noises"

	emote("yawn", intentional = TRUE)

/datum/emote/living/custom
	key = "me"
	key_third_person = "custom"
	show_runechat = TRUE
#ifdef MATURESERVER
	message_param = "%t"
#endif
	//mute_time = 1 - RATWOOD CHANGE, I don't want spammers.
/datum/emote/living/custom/can_run_emote(mob/user, status_check, intentional)
	. = ..() && intentional

/datum/emote/living/custom/proc/check_invalid(mob/user, input)
	. = TRUE
	if(copytext(input,1,5) == "гоыорит")
		to_chat(user, span_danger("Invalid emote."))
	else if(copytext(input,1,9) == "восклицает")
		to_chat(user, span_danger("Invalid emote."))
	else if(copytext(input,1,6) == "орёт")
		to_chat(user, span_danger("Invalid emote."))
	else if(copytext(input,1,5) == "спрашивает")
		to_chat(user, span_danger("Invalid emote."))
	else
		. = FALSE

/datum/emote/living/custom/run_emote(mob/user, params, type_override = null, intentional = FALSE)
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE
	if(is_banned_from(user.ckey, "Emote"))
		to_chat(user, span_boldwarning("Я не могу отправлять эмоуты (забанен)."))
		return FALSE
	else if(QDELETED(user))
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, span_boldwarning("Я не могу писать в IC (замучен)."))
		return FALSE
	else if(!params)
		var/custom_emote = copytext(sanitize(input("что делает твой персонаж?") as text|null), 1, MAX_MESSAGE_LEN)
		if(custom_emote && !check_invalid(user, custom_emote))
/*			var/type = input("Is this a visible or hearable emote?") as null|anything in list("Visible", "Hearable")
			switch(type)
				if("Visible")
					emote_type = EMOTE_VISIBLE
				if("Hearable")
					emote_type = EMOTE_AUDIBLE
				else
					alert("Unable to use this emote, must be either hearable or visible.")
					return*/
			message = custom_emote
			emote_type = EMOTE_VISIBLE
	else
		message = params
		if(type_override)
			emote_type = type_override
	. = ..()
	message = null
	emote_type = EMOTE_VISIBLE

/datum/emote/living/custom/replace_pronoun(mob/user, message)
	return message

/datum/emote/living/help
	key = "help"

/datum/emote/living/help/run_emote(mob/user, params, type_override, intentional)
/*	var/list/keys = list()
	var/list/message = list("Available emotes, you can use them with say \"*emote\": ")

	for(var/key in GLOB.emote_list)
		for(var/datum/emote/P in GLOB.emote_list[key])
			if(P.key in keys)
				continue
			if(P.can_run_emote(user, status_check = FALSE , intentional = TRUE))
				keys += P.key

	keys = sortList(keys)

	for(var/emote in keys)
		if(LAZYLEN(message) > 1)
			message += ", [emote]"
		else
			message += "[emote]"

	message += "."

	message = jointext(message, "")

	to_chat(user, message)*/

/datum/emote/beep
	key = "beep"
	key_third_person = "beeps"
	message = "beeps."
	message_param = "beeps at %t."
	sound = 'sound/blank.ogg'
	mob_type_allowed_typecache = list(/mob/living/brain, /mob/living/silicon)
/*
/datum/emote/living/circle
	key = "circle"
	key_third_person = "circles"
	restraint_check = TRUE

/datum/emote/living/circle/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/circlegame/N = new(user)
	if(user.put_in_hands(N))
		to_chat(user, span_notice("I make a circle with your hand."))
	else
		qdel(N)
		to_chat(user, span_warning("I don't have any free hands to make a circle with."))

/datum/emote/living/slap
	key = "slap"
	key_third_person = "slaps"
	restraint_check = TRUE

/datum/emote/living/slap/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return
	var/obj/item/slapper/N = new(user)
	if(user.put_in_hands(N))
		to_chat(user, span_notice("I ready your slapping hand."))
	else
		to_chat(user, span_warning("You're incapable of slapping in your current state."))
*/

/datum/emote/living/shake
	key = "shake"
	key_third_person = "трясет головой"
	message = "трясет головой."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_shake()
	set name = "Трясти головой"
	set category = "Emotes"

	emote("shake", intentional = TRUE)

/datum/emote/living/squint
	key = "squint"
	key_third_person = "прищуривается"
	message = "прищуривает свои глаза."
	emote_type = EMOTE_VISIBLE

/mob/living/carbon/human/verb/emote_squint()
	set name = "Прищуриться"
	set category = "Emotes"

	emote("squint", intentional = TRUE)

/datum/emote/living/meow
	key = "meow"
	key_third_person = "мяукает!"
	message = "мяукает!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_meow()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Мяукнуть"
		set category = "Noises"
		emote("meow", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/caw
	key = "caw"
	key_third_person = "каркает!"
	message = "каркает!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_caw()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Каркать"
		set category = "Noises"
		emote("caw", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/peep
	key = "peep"
	key_third_person = "пищит!"
	message = "пищит!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_peep()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Пиип"
		set category = "Noises"
		emote("peep", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/hoot
	key = "hoot"
	key_third_person = "Уху!"
	message = "Уху!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_hoot()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Ухукнуть (как сова)"
		set category = "Noises"
		emote("hoot", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/squeak
	key = "squeak"
	key_third_person = "пищит!"
	message = "пищит!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_squeak()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Пищать"
		set category = "Noises"
		emote("squeak", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/hiss
	key = "hiss"
	key_third_person = "шипит!"
	message = "шипит!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_hiss()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Сссс"
		set category = "Noises"
		emote("hiss", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/phiss
	key = "phiss"
	key_third_person = "шипит!"
	message = "шипит!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_phiss()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Шипеть"
		set category = "Noises"
		emote("phiss", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/roar
	key = "roar"
	key_third_person = "рычит!"
	message = "рычит!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенное рычание!"
	vary = TRUE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_roar()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Издать рык"
		set category = "Noises"
		emote("roar", intentional = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/howl
	key = "howl"
	key_third_person = "воет!"
	message = "воет!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_howl()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Выть"
		set category = "Noises"
		emote("howl", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/cackle
	key = "cackle"
	key_third_person = "кудахчет!"
	message = "кудахчет!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_cackle()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Кудахкать"
		set category = "Noises"
		emote("cackle", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/whine
	key = "whine"
	key_third_person = "скулит."
	message = "скулит."
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_whine()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Скулить"
		set category = "Noises"
		emote("whine", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/trill
	key = "trill"
	key_third_person = "трещит!"
	message = "трещит!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_trill()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Трелль"
		set category = "Noises"
		emote("trill", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/snap
	key = "snap"
	key_third_person = "щелкает пальцем!"
	message = "щелкает пальцем!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_snap()
	set name = "Щелчок"
	set category = "Noises"

	emote("snap", intentional = TRUE)

/datum/emote/living/blink
	key = "blink"
	key_third_person = "моргает."
	message = "моргает."
	emote_type = EMOTE_VISIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_blink()
	set name = "Моргнуть"
	set category = "Noises"

	emote("blink", intentional = TRUE)

/datum/emote/living/snap2
	key = "snap2"
	key_third_person = "щелкает пальцем дважды!"
	message = "щелкает пальцем дважды!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_snap2()
	set name = "Двойной щелчок"
	set category = "Noises"

	emote("snap2", intentional = TRUE)

/datum/emote/living/snap3
	key = "snap3"
	key_third_person = "щелкает пальцем трижды!"
	message = "щелкает пальцем трижды!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_snap3()
	set name = "Тройной щелчок"
	set category = "Noises"

	emote("snap3", intentional = TRUE)

/datum/emote/living/purr
	key = "purr"
	key_third_person = "мурчит!"
	message = "мурчит!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "мурчит!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_purr()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Мурчать"
		set category = "Noises"
		emote("purr", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/moo
	key = "moo"
	key_third_person = "мычит!"
	message = "мычит!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_moo()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Муу"
		set category = "Noises"
		emote("moo", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/bark
	key = "bark"
	key_third_person = "гавкает!"
	message = "гавкает!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_bark()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Гавкать"
		set category = "Noises"
		emote("bark", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/growl
	key = "growl"
	key_third_person = "рычит!"
	message = "рычит!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный звук!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_growl()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Рычать"
		set category = "Noises"
		emote("growl", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/bleat
	key = "bleat"
	key_third_person = "блеет!"
	message = "блеет!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "makes a muffled sound!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_bleat()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		set name = "Блееть"
		set category = "Noises"
		emote("bleat", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/chitter
	key = "chitter"
	key_third_person = "стрекочет!"
	message = "стрекочет!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	message_muffled = "издает приглушенный треск!"
	vary = TRUE
	show_runechat = FALSE
	is_animal = TRUE

/mob/living/carbon/human/verb/emote_chitter()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/moth))
		set name = "Стрекотать"
		set category = "Noises"
		emote("chitter", intentional = TRUE, animal = TRUE)
	else
		to_chat(usr, span_warning("Твой язык не способен на это!"))
		return

/datum/emote/living/flutter
	key = "flutter"
	key_third_person = "Порхает крыльями!"
	message = "Порхает крыльями!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	show_runechat = FALSE

/mob/living/carbon/human/verb/emote_flutter()
	if(istype(usr.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/moth))
		set name = "Порхать"
		set category = "Noises"
		emote("flutter", intentional = TRUE)
	else
		to_chat(usr, span_warning("Твоя спина не способна на это!"))
		return

/datum/emote/living/fsalute
	key = "fsalute"
	key_third_person = "salutes their faith."
	message = "salutes their faith."
	emote_type = EMOTE_AUDIBLE
	show_runechat = TRUE

/datum/emote/living/fsalute/run_emote(mob/living/user, params, type_override, intentional, targetted, animal)
	. = ..()
	if(. && !isnull(user.patron) && !HAS_TRAIT(user, TRAIT_DECEIVING_MEEKNESS))	//Guarded doesn't show an icon to anyone.
		user.play_overhead_indicator('icons/mob/overhead_effects.dmi', "stress", 15, MUTATIONS_LAYER, private = user.patron.type, soundin = 'sound/magic/holyshield.ogg', y_offset = 32)

/mob/living/carbon/human/verb/emote_fsalute()
	set name = "Приветствие веры"
	set category = "Emotes"

	emote("fsalute", intentional =  TRUE)

/datum/emote/living/ffsalute
	key = "ffsalute"
	key_third_person = "salutes their faith."
	message = "salutes their faith."
	emote_type = EMOTE_AUDIBLE
	show_runechat = TRUE

/datum/emote/living/ffsalute/run_emote(mob/living/user, params, type_override, intentional, targetted, animal)
	if(HAS_TRAIT(user, TRAIT_XYLIX))
		. = ..()

/mob/living/carbon/human/proc/emote_ffsalute()
	set name = "Fake Faith Salute"
	set category = "Emotes"

	emote("ffsalute", intentional =  TRUE)
