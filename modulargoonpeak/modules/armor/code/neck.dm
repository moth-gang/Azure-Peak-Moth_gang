/obj/item/clothing/neck/roguetown
	name = "necklace"
	desc = ""
	icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/neck.dmi'
	mob_overlay_icon = 'modulargoonpeak/modules/armor/icons/obj/clothing/on_mob/neck.dmi'

/obj/item/clothing/neck/roguetown/bsgorget
	name = "чёрно-сталивый горжет"
	desc = "горжет созданный из черной стали, выглядит дорого."
	icon_state = "bcstell_gorget"
	armor = ARMOR_GORGET
	smeltresult = /obj/item/ingot/blacksteel
	anvilrepair = /datum/skill/craft/armorsmithing
	max_integrity = ARMOR_INT_SIDE_BLACKSTEEL
	resistance_flags = FIRE_PROOF
	body_parts_inherent = NECK
	slot_flags = ITEM_SLOT_NECK
	body_parts_covered = NECK
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = PLATEHIT
