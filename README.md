## 1. Общая структура программы. Ввод и вывод информации. Форматы
### Задание:  
1. Ознакомиться с примером программы, приведенном в
теоретической части лабораторной работы. Набрать текст программыпримера и осуществить выполнение программы.
2. Разработать программу на Perl, которая:
- вводит с клавиатуры текущую дату;
- выдает на экран сообщения с указанием названия и темы
лабораторной работы, фамилий членов бригады, текущей даты (ранее
введенной с клавиатуры).  

Вывод информации производить с использованием форматов. При
выводе информации использовать все известные символы
форматирования. Обеспечить выдачу верхнего колонтитула.  
Изменить длину страницы, задаваемую значением соответсвующей
системной переменной.

3.  Разработать программу генерации простейшей
HTML-страницы с помощью функции print. Вывод производить в файл, для
чего перенаправить стандартный выходной поток из командной строки с
помощью операции “>“.

## 2. Типы данных. Массивы и хеш-массивы
### Задание:  
При выполнении данной лабораторной работы необходимо учесть
следующие требования:  
- количество элементов любого массива заранее не известно ни
программисту, ни самому пользователю, ввод элементов массива может
быть прерван пользователем в любой момент (для обеспечения
корректного решения этой задачи использовать свойства операции <>);
- если в программе выполняется обработка двух массивов, нет
гарантии, что пользователь введет одинаковое количество элементов в оба
массива; следует предусмотреть обработку ситуации несовпадения
количества элементов массивов.
  

1. Для двух произвольных массивов вычислить:  
- объединение;
- пересечение;
- разность;
- симметричнуюразность их элементов.  

2. Произвести попарную перестановку элементов массива — 1
элемент поменять местами со 2, 3 поменять с 4, и т.д. Для решения задачи
обязательно использовать операцию присваивания в списковом контексте.

3. Из двух произвольных массивов сконструировать третий, у
которого элементы с четными индексами взяты из первого массива, а
элементы с нечетными индексами — из второго.

4. С помощью хеш-массива организовать линейный
лексикографичеки упорядоченный список строк. Программа должна
предоставлять пользователю средства, позволяющие осуществить:  
- добавление строки в список;
- удаление строки из списка;
- просмотр списка.  

Выполнение указанных операций не должно нарушать упорядоченности
списка. Вызов перечисленных операций на выполнение должен
осуществляться через меню, выдаваемое на экран.

## 3. Рекурсивные функции
### Задание
1. Разработать программу поддержки упорядоченного по ключу
односвязного списка, содержащего сведения о студентах (ФИО, номер
зачетной книжки, номер группы, специальность, год рождения). В качестве
ключа использовать номер зачетной книжки. Над элементами списка
должны выполняться следующие операции, не нарушающие
упорядоченности:  
- добавление элемента в список;
- удаление элемента из списка;
- вывод списка на экран.  

Список создается и обслуживается с помощью рекурсивных подпрограмм.
Для создания элементов списка использовать анонимные хеш-массивы.

2. Разработать программу поддержки упорядоченного бинарного
дерева. Элементами дерева являются целые числа. Программа должна
осуществлять следующие операции над деревом:
- генерация дерева;
- добавление элемента;
- вывод элементов дерева на экран;
- удаление элемента.  

Значения добавляемых и удаляемых элементов вводятся
пользователем.

3. Решить задачу о ханойских башнях. На плоскости установлены 3
стержня: a, b и с. На стержень a нанизано n дисков (число дисков вводится
пользователем), расположенных по возрастанию диаметра. Необходимо
переместить диски со стержня a на стержень c, используя стержень b и
соблюдая следующие ограничения:  
- можно перемещать только один диск одновременно;
можно перемещать только один диск одновременно;
- диск большего диаметра никогда не может находиться на диске
меньшего диаметра.  

Разработать программу, которая описывает последовательность
переноса дисков в ходе решения задачи, выводя сообщение вида:  
“Перенос диска диаметра 4 со стержня a на стержень c.”,
а также печатает сообщения о текущем состоянии каждого из стержней
(сколько дисков находится на стержне и в каком порядке они
расположены).

## 4. Объектно-ориентированное программирование
### Задание
Разработать класс для представления информации о заданном
объекте и выполнения операций над этой информацией, не нарушающих ее
целостности. Объект выбирается из таблицы в соответствии с номером
варианта и указанием преподавателя. Класс реализовать в виде
самостоятельного модуля.

Номер варианта | Объект |  
-------------- | -------|  
1 | ЭВМ (тип компьютера, конфигурация, принадлежность к той или иной сети и т.д.) |

## 5. Файлы и каталоги
### Задание
1. Решить задачу 3 из лабораторной работы № 3, выдавая выходную
информацию в текстовый файл
2. Разработать программу, которая печатает дерево каталогов и
имена содержащихся в них файлов с их атрибутами (размер, дата и время
создания, доступность для чтения и записи). В качестве корня дерева
использовать каталог, имя которого вводится пользователем.
Предусмотреть возможность вывода информации как на экран, так и в
текстовый файл. Решение о способе вывода информации принимается на
основе списка аргументов программы, переданного ей через командную
строку.
3. Разработать программу, которая просматривает дерево каталогов и
удаляет файлы с заданным расширением. Требуемое расширение вводится
с клавиатуры или через командную строку. В качестве корня дерева
использовать каталог, имя которого вводится пользователем.
4. Разработать программу, которая перемещает каталог вместе со
всем его содержимым. Имя исходного каталога и место назначения
вводятся пользователем

## 6. Обработка строк и регулярные выражения
### Задание
1. Разработать программу просмотра дерева каталогов и
формирования отчета, в котором находятся имена файлов, содержащих
заданную последовательность символов, а также счетчик числа таких
последовательностей, обнаруженных в каждом из перечисленных файлов.
Последовательность символов вводится с клавиатуры или через командную
строку. Предусмотреть возможность вызова программы в двух режимах:  
- с учетом регистра;
- без учета регистра  

В качестве корня дерева использовать каталог, имя которого
вводится пользователем.

2. Разработать программу, которая во входном файле отыскивает
последовательности символов (лексемы), соответствующие записи чисел
арабскими цифрами, и заменяет их последовательностями символов,
соответствующих записи чисел римскими цифрами. Имя входного файла
вводится через командную строку или с клавиатуры.

3. Решить задачу, обратную предыдущей — изменить форму записи
чисел с римской на арабскую.

4. Разработать программу, которая во входном файле выполняет
преобразование русского текста из одной кодировки в другую. Системы
кодировки выбираются в соответствии с номером бригады (табл. 14).
Соответствия систем кодировок приведены в табл. 15.

Номер бригады | Способы кодировки |
--------------| ------------------|
1, 11 | Dos 866 =>Windows1251, Windows1251=>Dos 866|