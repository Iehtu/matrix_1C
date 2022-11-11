&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЧислоСтрок = 5;
	ЧислоКолонок = 3;
	
	РезультатПроверки = 2;
	
	Для Инд = 1 По ЧислоКолонок Цикл
		ТаблицаОтрисовки.Область(, Инд, , Инд).ШиринаКолонки = 2;
		ВводИзображения.Область(, Инд, , Инд).ШиринаКолонки = 2;
	КонецЦикла;
	
	Для Инд = 1 По ЧислоСтрок Цикл
	
		ТаблицаОтрисовки.Область(Инд, , Инд).ВысотаСтроки = 10;
		ВводИзображения.Область(Инд, , Инд).ВысотаСтроки = 10;
			
	КонецЦикла;
	
 КонецПроцедуры

 &НаКлиенте
 Процедура ВводИзображенияПриАктивизации(Элемент)
 	
 	ЦветЧерный = Новый Цвет(0, 0, 0);
 	ЦветБелый = Новый Цвет(255, 255, 255);
 	
 	Если ВводИзображения.ТекущаяОбласть.ЦветФона = ЦветЧерный Тогда
 		ВводИзображения.ТекущаяОбласть.ЦветФона = ЦветБелый;
 	Иначе
 		ВводИзображения.ТекущаяОбласть.ЦветФона = ЦветЧерный; 
 	КонецЕсли;
 	
 	РезультатПроверки = 2;
 	
 	ПроверочныйБлок = ВернутьСтроковоеПредставлениеВектора(ВернутьВекторПоТабличномуДокументу(ВводИзображения));
 	
 КонецПроцедуры

&НаКлиенте
Функция ВернутьВекторПоТабличномуДокументу(ТаблДок)

	ЦветЧерный = Новый Цвет(0, 0, 0);

	ТекущийМассив = Новый Массив;
 	Для ИндС = 1 По 5 Цикл
 		
 		Для ИндК = 1 По 3 Цикл
 		
			ТекущийМассив.Добавить(?(ТаблДок.Область(ИндС, ИндК).ЦветФона = ЦветЧерный, 1, 0)); 		
 		
 		КонецЦикла;
 		
 	КонецЦикла;
	
	Возврат ТекущийМассив;

КонецФункции

&НаКлиенте
Процедура ДобавитьПроверку(Команда)
	
	НастройкиПроверки = ВекторИзJSON(ХранилищеКоэффициентов);
	ТекущийВектор = ВернутьВекторПоТабличномуДокументу(ВводИзображения);
	РезультатПроверки = ?(Проверка(ТекущийВектор, НастройкиПроверки.Коэффициенты, НастройкиПроверки.Смещение)=-1, 0, 1);

КонецПроцедуры





&НаСервере
Процедура ГрафическиОтразитьКоэффициенты(МатрицаКоэффициентов) 

	ЧислоСтрок = 5;
	ЧислоКолонок = 3;
	
	
	Счетчик = 0;
	
	Для ИндС = 1 По ЧислоСтрок Цикл
		
		
		
		Для ИндК = 1 По ЧислоКолонок Цикл
			
			ТекЗначение = Окр(МатрицаКоэффициентов[Счетчик]/10*255);
			
			Если ТекЗначение > 0 Тогда
				Цвет = Новый Цвет(ТекЗначение, ТекЗначение, ТекЗначение);
			Иначе
				Цвет = Новый Цвет(ТекЗначение, 0, 0);
			КонецЕСли;
			
			ТаблицаОтрисовки.Область(ИндС, ИндК).ЦветФона = Цвет;
			Счетчик = Счетчик + 1;
			
		КонецЦикла;
		
	КонецЦикла;

КонецПроцедуры


// Перцептрон

&НаКлиенте
Функция ПороговоеЗначение(Знач Проверка)
	

	Если Проверка > 0 Тогда
		Возврат 1;
	Иначе
		Возврат -1;
	КонецЕсли;

КонецФункции

&НаКлиенте
Функция Обучение(МассивИсходныхДанных, МассивПравильныхОтветов, ЧислоИтераций, КоэффициентОбучения)
	
	МассивКоэффициентов = Новый Массив();
		
	ГенераторСлучайныхЧисел = Новый ГенераторСлучайныхЧисел(1200);
	Для Инд = 0 По МассивИсходныхДанных[0].ВГраница() Цикл
	
		МассивКоэффициентов.Добавить(ГенераторСлучайныхЧисел.СлучайноеЧисло(0, 10));
		
	КонецЦикла;
	Смещение = ГенераторСлучайныхЧисел.СлучайноеЧисло(0, 10);
	Ошибки = Новый Массив;
	
	
	Для Инд = 0 По ЧислоИтераций Цикл
	
		Ошибка = 0;
		Для ИндСтроки = 0 По МассивИсходныхДанных.ВГраница() Цикл
			
			СтрокаХ =ВернутьВекторСтроки(МассивИсходныхДанных, ИндСтроки); 
			
			Отклонение = (МассивПравильныхОтветов[ИндСтроки] -ПороговоеЗначение(СкалярноеПеремножениеВекторов(СтрокаХ, МассивКоэффициентов)+ Смещение));
			
			Ошибка = Ошибка + ?(Отклонение = 0, 0, 1);
			
			Дельта = КоэффициентОбучения * Отклонение;
			Смещение = Смещение + Дельта;

			Для ИндКоэф = 0 По МассивКоэффициентов.ВГраница() Цикл
			
				МассивКоэффициентов[ИндКоэф] = МассивКоэффициентов[ИндКоэф] + Дельта*СтрокаХ[ИндКоэф]; 			
			
			КонецЦикла;
					
		КонецЦикла;
		Ошибки.Добавить(Ошибка);
	
	КонецЦикла;
	
	
	Результат = Новый Структура("Коэффициенты, Ошибка, Смещение", МассивКоэффициентов, Ошибки, Смещение); 
	
	ХранилищеКоэффициентов = ВекторВJSON(Результат);

	Возврат Результат;
	

КонецФункции

&НаКлиенте
Функция ВекторВJSON(Знач Вектор)

	ЗаписьJSON = Новый ЗаписьJSON();
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON, Вектор);
	Возврат ЗаписьJSON.Закрыть();

КонецФункции

&НаКлиенте
Функция ВекторИзJSON(Знач СтрокаВектор)

	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.УстановитьСтроку(СтрокаВектор);
	Возврат ПрочитатьJSON(ЧтениеJSON);

КонецФункции

&НаКлиенте
Функция Проверка(ИсходныйВектор, МатрицаКоэффициентов, Смещение)

	Возврат ПороговоеЗначение(СкалярноеПеремножениеВекторов(ИсходныйВектор, МатрицаКоэффициентов) + Смещение);

КонецФункции

&НаКлиенте
Процедура ВывестиМатрицу(Знач Матрица)

	Для ИндСтр = 0 По Матрица.ВГраница() Цикл
			
			СтрокаОтвета = "[";
			Если ТипЗнч(Матрица[ИндСтр]) = Тип("Массив") Тогда
				Для ИндКол = 0 По Матрица[ИндСтр].ВГраница() Цикл
				
					СтрокаОтвета = СтрокаОтвета + Матрица[ИндСтр][ИндКол] + ",";
				
				КонецЦикла;
			Иначе
				СтрокаОтвета = СтрокаОтвета + Матрица[ИндСтр] + ",";
			КонецЕсли;
			
			Сообщить(Сред(СтрокаОтвета, 0, СтрДлина(СтрокаОтвета) - 1) + "]");
			
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Функция ВернутьМатрицуНаОснованииJSON(СтрокаJSON)
	
	Результат = Неопределено;
	
	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.УстановитьСтроку(СтрокаJSON);
	Прочтенный = ПрочитатьJSON(ЧтениеJSON);
	
	Если Прочтенный.Свойство("matrix", Результат) Тогда
		Возврат Результат;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
		
	
КонецФункции

&НаКлиенте
Процедура ПроверитьМатрицу(Команда)
	
	МатрицаОт1До9 = ВернутьМатрицуНаОснованииJSON("{""matrix"":
	|[
	|[1,1,1,1,0,1,1,0,1,1,0,1,1,1,1],
	|[0,0,1,0,0,1,0,0,1,0,0,1,0,0,1],
	|[1,1,1,0,0,1,1,1,1,1,0,0,1,1,1],
	|[1,1,1,0,0,1,1,1,1,0,0,1,1,1,1],
	|[1,0,1,1,0,1,1,1,1,0,0,1,0,0,1],
	|[1,1,1,1,0,0,1,1,1,0,0,1,1,1,1],
	|[1,1,1,1,0,0,1,1,1,1,0,1,1,1,1],
	|[1,1,1,0,0,1,0,0,1,0,0,1,0,0,1],
	|[1,1,1,1,0,1,1,1,1,1,0,1,1,1,1],
	|[1,1,1,1,0,1,1,1,1,0,0,1,1,1,1],
	|[1,1,1,1,0,0,1,1,1,0,0,0,1,1,1]
	|]
	|}");
	
	МатрицаПроверки = ВернутьМатрицуНаОснованииJSON("{""matrix"":
	|[
	|[1,1,1,1,0,0,1,1,1,0,0,0,1,1,1],
	|[1,1,1,1,0,0,0,1,0,0,0,1,1,1,1],
	|[1,1,1,1,0,0,0,1,1,0,0,1,1,1,1],
	|[1,1,0,1,0,0,1,1,1,0,0,1,1,1,1],
	|[1,1,0,1,0,0,1,1,1,0,0,1,0,1,1],
	|[1,1,1,1,0,0,1,0,1,0,0,1,1,1,1],
	|[1,1,1,1,0,1,1,0,1,1,0,1,1,1,1],
	|[0,0,1,0,0,1,0,0,1,0,0,1,0,0,1]	
	|]
	|}");
	
	ВекторПравильныхОтветов = ВернутьМатрицуНаОснованииJSON("{""matrix"":[-1,-1,-1,-1,-1,1,-1,-1,-1,-1, 1]}");
	ВекторОжидаемыхОтветов = ВернутьМатрицуНаОснованииJSON("{""matrix"":[1,1,1,1,1,1,-1,-1]}");
	
	Результат = Обучение(МатрицаОт1До9, ВекторПравильныхОтветов, ЧислоИтераций, ШагОбучения);	
	
	
	ТаблицаПроверки.Очистить();
	Для Инд = 0  По  МатрицаПроверки.ВГраница() Цикл
	
		НоваяСтрока = ТаблицаПроверки.Добавить();
		НоваяСтрока.Представление = ВернутьСтроковоеПредставлениеВектора(МатрицаПроверки[Инд]);
		НоваяСтрока.ОжидаемыйРезультат = ВекторОжидаемыхОтветов[Инд];
		НоваяСтрока.РассчитанныйРезультат = Проверка(МатрицаПроверки[Инд], Результат.Коэффициенты, Результат.Смещение);  
	
	КонецЦикла;
	
	ВекторОшибок = ВернутьСтроковоеПредставлениеВектора(Результат.Ошибка);
	ГрафическиОтразитьКоэффициенты(Результат.Коэффициенты);
	
КонецПроцедуры

&НаКлиенте
Функция ВернутьСтроковоеПредставлениеВектора(Вектор)
	
	Строка_Вектор = "[";
	
	Для Каждого Элемент ИЗ Вектор Цикл
		Строка_Вектор = Строка_Вектор + Элемент + ",";
	КонецЦикла;
	
	Возврат Сред(Строка_Вектор, 0, СтрДлина(Строка_Вектор)-1) + "]";
	
	
КонецФункции

&НаКлиенте
Функция СкалярноеПеремножениеВекторов(Вектор1, Вектор2)

	Результат = 0;
	
	Если ТипЗнч(Вектор1) <> Тип("Массив") ИЛИ ТипЗнч(Вектор2)<>Тип("Массив") ИЛИ Вектор1.Количество() <> Вектор2.Количество() Тогда
		Возврат Результат;
	КонецЕсли;
	
	
	Для Инд = 0 По Вектор1.ВГраница() Цикл
	
		Результат = Результат + Вектор1[Инд]*Вектор2[Инд];
	
	КонецЦикла;
	
	Возврат Результат;

КонецФункции

&НаКлиенте
Функция СоздатьМногомерныйМассив(РазмерностьX, РазмерностьY)

	Результат = Новый Массив;
	
	Для Инд = 0 По РазмерностьX - 1 Цикл
	
		Результат.Добавить(Новый Массив(РазмерностьY));
	
	КонецЦикла;
	
	Возврат Результат;

КонецФункции

&НаКлиенте
Функция ПеремножитьМатрицы(Знач X, Знач Y)
	
	Если ТипЗнч(X) <> Тип("Массив") ИЛИ ТипЗнч(Y) <> Тип("Массив") Тогда
		Сообщить("Параметры некорректных типов");
		Возврат Неопределено;
	КонецЕсли;
	
	Если X.Количество() = 0 ИЛИ Y.Количество() <> X[0].Количество() Тогда
		Сообщить("Количество колонок первой матрицы должно соответствовать количеству строк второй матрицы");
		Возврат Неопределено;
	КонецЕсли;
	
	Результат = Новый Массив;
	
	Для ИндСтр = 0 По X.ВГраница() Цикл
		
		СтрокаРезультата = Новый Массив;
		
		Для ИндКол = 0 По Y[0].ВГраница() Цикл
			
			ТекРезультат = 0;

			Для ИндИтератор = 0 По X[0].ВГраница() Цикл
			
			ТекРезультат = ТекРезультат + X[ИндСтр][ИндИтератор] * Y[ИндИтератор][ИндКол];							
			
			КонецЦикла;
			СтрокаРезультата.Добавить(ТекРезультат); 
			
		КонецЦикла;
		Результат.Добавить(СтрокаРезультата);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции


&НаКлиенте
Функция ВернутьВекторСтроки(Матрица, НомерСтроки)
	
	Если ТипЗнч(Матрица)<>Тип("Массив") ИЛИ Матрица.ВГраница()<НомерСтроки Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ТекСтрока = Матрица[НомерСтроки];
	Возврат ТекСтрока; 
	
КонецФункции

&НаКлиенте
Функция ВернутьВекторКолонки(Матрица, НомерКолонки)
	
	Если ТипЗнч(Матрица) <> Тип("Массив") ИЛИ Матрица.Количество() = 0 ИЛИ Матрица[0].ВГраница()<НомерКолонки Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ТекКолонка = Новый Массив;
	Для Каждого ТекСтрока Из Матрица Цикл
	
		ТекКолонка.Добавить(ТекСтрока[НомерКолонки]);
	
	КонецЦикла;
	Возврат ТекКолонка;
	
КонецФункции


&НаКлиенте
Функция ТранспонироватьМатрицу(Знач ИсходнаяМатрица)
	
	Если ТипЗнч(ИсходнаяМатрица) <> Тип("Массив") Тогда
	
		Возврат Неопределено;
	
	КонецЕсли;
	
	Если ИсходнаяМатрица.Количество() = 0 ИЛИ ИсходнаяМатрица[0].Количество() = 0 Тогда
	
	
		Возврат Неопределено;
		
	КонецЕсли;
	
	ЧислоСтрок = ИсходнаяМатрица[0].Количество();
	ЧислоКолонок = ИсходнаяМатрица.Количество();
	
	Результат = Новый Массив();
	Для Инд = 0 По ЧислоСтрок - 1 Цикл
		
		Результат.Добавить(Новый Массив(ЧислоКолонок)); 
		
	КонецЦикла;
	
	Для ИндКол = 0 По ИсходнаяМатрица[0].ВГраница() Цикл
		
		Для ИндСтр = 0 По ИсходнаяМатрица.ВГраница() ЦИкл
		
			Результат[ИндКол][ИндСтр] = ИсходнаяМатрица[ИндСтр][ИндКол];
		
		КонецЦикла;
	
	КонецЦикла; 
	
	Возврат Результат;
	
КонецФункции