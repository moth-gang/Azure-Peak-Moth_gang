/obj/item/clothing/suit/roguetown/shirt/robe
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/armor.dmi'

/obj/item/clothing/suit/roguetown/shirt/robe/astrata
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/armor.dmi'

/obj/item/clothing/suit/roguetown/shirt/robe/abyssor
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/armor.dmi'

/obj/item/clothing/suit/roguetown/shirt/robe/noc
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/armor.dmi'

/obj/item/clothing/suit/roguetown/shirt/robe/necromancer
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/armor.dmi'

/obj/item/clothing/suit/roguetown/shirt/robe/dendor
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/armor.dmi'

/obj/item/clothing/suit/roguetown/shirt/robe/necra
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/armor.dmi'

/obj/item/clothing/suit/roguetown/shirt/robe/physician
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/armor.dmi'

/obj/item/clothing/suit/roguetown/shirt/robe/eora
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/armor.dmi'

/obj/item/clothing/suit/roguetown/armor
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/armor.dmi'

/obj/item/clothing/suit/roguetown/shirt/robe/spellcasterrobe
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/armor.dmi'
/obj/item/clothing/suit/roguetown/shirt/jacket_lether
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT|ITEM_SLOT_CLOAK
	name = "кожаная куртка"
	desc = "кожанка, созданная из сыромятой кожи"
	body_parts_covered = CHEST|GROIN
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/armor.dmi'
	icon_state = "jacketlether"
	mob_overlay_icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/on_mob/armor.dmi'
	sleeved = 'modulargoonpeak/modules/armor/icons/obj/clothing/on_mob/sleeves_armor.dmi'
	boobed = TRUE
	flags_inv = HIDEBOOB|HIDECROTCH
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	var/fanatic_wear = FALSE
/obj/item/clothing/suit/roguetown/armor/lamiarmor
	slot_flags = ITEM_SLOT_ARMOR
	name = "ламеллярный доспех"
	desc = "ламеллярный доспех широко используем повсеместно, но в особенности из-за его простоты, часто использовается жителями севера"
	icon_state = "lamiarmor"
	mob_overlay_icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/on_mob/armor.dmi'
	blocksound = SOFTHIT
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	armor = ARMOR_PLATE
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	allowed_sex = list(MALE, FEMALE)
	nodismemsleeves = TRUE
	max_integrity = ARMOR_INT_CHEST_PLATE_BRIGANDINE
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 4 SECONDS
	armor_class = ARMOR_CLASS_MEDIUM
	sleeved_detail = FALSE
	boobed_detail = FALSE
