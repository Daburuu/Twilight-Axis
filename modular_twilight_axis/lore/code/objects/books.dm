<<<<<<< HEAD
=======
/obj/item/book/rogue/bibble
	name = "The Verses and Acts of the Ten"
	desc = "'ДЕСЯТЬ направляют нас сквозь тьму. ДЕСЯТЬ БОГОВ превыше всего.' </br>Священная книга Церкви Десяти, распространяемая Святыми Престолами по всей Гримории. Разделена на три Завета в хронологическом порядке.</br>ЛЕВИТ - Первый Завет, повествующий о временах Становления и Первородной Эры. </br>ДЕКАНОМИКОН - Второй Завет, повествующий о Войне в Небесах, что сотрясла наш мир до основания. </br>НОВЫЙ РАССВЕТ - Третий Завет, повествующий о становлении Божественного Порядка и о Неделимом Пантеоне."
	icon_state = "bibble_0"
	base_icon_state = "bibble"
	title = "The Verses and Acts of the Ten"
	dat = "gott.json"
	possible_item_intents = list(
		/datum/intent/use,
		/datum/intent/bless,
	)

/obj/item/book/rogue/bibble/read(mob/user)
	if(!open)
		to_chat(user, span_info("Open me first."))
		return FALSE
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		return
	if(in_range(user, src) || isobserver(user))
		user.changeNext_move(CLICK_CD_MELEE)
		var/list/choices = list("Левит", "Деканомикон", "Новый Рассвет")
		var/section_choice = input(user,"Мудростью какого Завета я буду делиться?", "БОЖЕСТВЕННОЕ ПРОСВЕЩЕНИЕ") as anything in choices
		var/chosentxt
		switch(section_choice)
			if("Левит")
				chosentxt = 'modular_twilight_axis/lore/strings/visage.txt'
			if("Деканомикон")
				chosentxt = 'modular_twilight_axis/lore/strings/decanomicon.txt'
			if("Новый Рассвет")
				chosentxt = 'modular_twilight_axis/lore/strings/newdawn.txt'
		var/m
		var/list/verses = world.file2list(chosentxt)
		m = pick(verses)
		if(m)
			user.say(m)


/obj/item/book/rogue/bibble/psy
	desc = "'И Он плачет. Не за тебя, не за себя, но за всех нас.' </br>Том в кожаном переплете, содержащий учения Церкви Всеотца. Книга разделена на четыре Завета, отражающих верования наиболее крупных и значимых конфессий псайдонитской веры. </br>ЗАВЕТ ПСАЙДОНА есть учение Старой Веры, что вело праведных во времена до Архипредательства. </br>ЖИТИЁ ПСАЙДОНА описывает сотворение Псайдонии такой, какой мы её знаем. </br>ЗАВЕТ ОТАВИКА есть истина новой эпохи, поведанная нам Великим Магистром Отаванским. </br>ЗАВЕТ СУДЬБЫ есть учение жителей Наледи, союзников в борьбе со злом, что захватило наш грешный мир. "

>>>>>>> 425dcc2224a6f9a37810627242d676fb7a4c8997
/obj/item/book/rogue/bibble/psy/read(mob/living/carbon/human/user)
	if(!open)
		to_chat(user, span_info("Open it first."))
		return FALSE
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		return
	if(in_range(user, src) || isobserver(user))
		user.changeNext_move(CLICK_CD_MELEE)
		var/m
		if(sect)
			var/list/verses = world.file2list("modular_twilight_axis/lore/strings/psy[sect].txt")
			m = pick(verses)
			if(m)
				if(prob(1) && sect == "sect1")
					user.playsound_local(user, 'sound/misc/psydong.ogg', 100, FALSE)
					user.say("ПСАЙ 66:6... +_Всеотец_+ изрёк: «Я прощаю тебя, ибо люблю тебя как отец любит свою дочь». И кровь стекала по лезвию и из груди е- Откуда это здесь?!")
				else
					user.say(m)	

/obj/item/book/rogue/bibble/psy/MiddleClick(mob/user, params)
	var/sects = list("Завет Псайдона", "Житиё Псайдона", "Завет Отавика")
	var/sect_choice = input(user, "Выберите Завет", "О ПСАЙДОНИИ") as anything in sects
	switch(sect_choice)
		if("Завет Псайдона")
			sect = "sect1"
		if("Житиё Псайдона")
			sect = "sect2"
		if("Завет Отавика")
			sect = "sect3"
	return
