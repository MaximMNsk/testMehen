# Mehen

## Привет!

## По заданиям.

1. Для проверки первого - достаточно склонировать реп к себе и запустить `php -f test.php`. Не стал покрывать тестами, не было задачи. 
2. Ко второму - решение в файле sql.sql. Первый вариант запросом, второй процедурами. 
3. Ответы на задачки. Для случая, когда взвешивание - это сравнение только двух объектов:
* Первое взвешивание - две монеты. Если весы уравновешены, то оставшаяся монета - фальшивая. Если нет, то. На второе взвешивание, монету на левой чаше меняем на оставшуюся.  Если весы уравновешены, то оставшаяся монета - фальшивая. Если нет, то монета на правой чаше фальшивая.
* Для определения фальшивой монеты среди 8 штук за 3 взвешивания необходимо знать, тяжелее эта монета или легче. Возможно, это опеределено в п.1. Тем не менее, если это так и фальшивая монета легче, то тогда монеты в 1-м взвешивании делим на 2 стопки и взвешиваем. Монета будет в наиболее легкой стопке. И так до взвешивания 1-1.
* Для 13 монет в условиях большинства неизвестных задача неразрешима. Разве что в какой-то степени вероятности. 