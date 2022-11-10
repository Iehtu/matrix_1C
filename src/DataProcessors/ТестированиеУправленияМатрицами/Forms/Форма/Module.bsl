
&НаКлиенте
Процедура ВывестиМатрицу(Знач Матрица)

	Для ИндСтр = 0 По Матрица.ВГраница() Цикл

			СтрокаОтвета = "[";
			Для ИндКол = 0 По Матрица[ИндСтр].ВГраница() Цикл
			
				СтрокаОтвета = СтрокаОтвета + Матрица[ИндСтр][ИндКол] + ",";
			
			КонецЦикла;
			
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
	
	Матрица1_JSON = "{""matrix"":[[1,2,3],
	|[3,4,5],
	|[5,6,7]]}";
	
	
	
	Матрица1 = ВернутьМатрицуНаОснованииJSON(Матрица1_JSON);
	Матрица2 = СоздатьМногомерныйМассив(3,1);
	
	
	Матрица2[0][0] = 2;
	Матрица2[1][0] = 2;
	Матрица2[2][0] = 2;
	
	ПеремноженнаяМатрица = ПеремножитьМатрицы(Матрица1, Матрица2);
	Если ПеремноженнаяМатрица <> Неопределено Тогда
		ВывестиМатрицу(ПеремноженнаяМатрица);
	
		ВывестиМатрицу(ТранспонироватьМатрицу(ПеремноженнаяМатрица));
	КонецЕсли;
	
	Сообщить(СкалярноеПеремножениеВекторов(ВернутьВекторСтроки(Матрица1, 0), ВернутьВекторКолонки(Матрица2, 0)));
	
КонецПроцедуры


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