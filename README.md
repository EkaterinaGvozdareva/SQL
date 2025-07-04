# SQL

# Анализ продаж в SQL

## Описание проекта
Анализ данных о продажах из CSV-файла с использованием SQL-запросов. Проект демонстрирует навыки работы с базовыми и оконными функциями.

## Навыки и технологии
- SQL-агрегации (`SUM`, `COUNT`, `AVG`)
- Оконные функции (`OVER`, `PARTITION BY`)
- Фильтрация и сортировка
- Работа с датами

## Инсайты из данных
1. **Самый прибыльный месяц**: Ноябрь (продажи на $205 513)
2. **Топ-5 товаров по прибыли**:
  - Hewlett Packard 610 Color Digital Copier / Printer	($2750)
  - Sharp 1540cs Digital Laser Copier	($1650)
  - GBC DocuBind TL200 Manual Binding Machine	($1591)
  - Hot File 7-Pocket, Floor Stand ($1537)
  - Dot Matrix Printer Tape Reel Labels, White, 5000/Box	($1518)
3. **Средний чек**: $265.95
4. **Самый популярный способ доставки**: Standard Class (2952 дня в среднем)

## Как запустить
1. Импортируйте data.csv в MySQL Workbench
2. Выполните запросы из файла `sales_analysis.sql`

## Примеры запросов
```sql
-- Топ 10 самых прибыльных товаровов
SELECT
	product_name,
    category,
    SUM(profit) AS profit_of_product,
    SUM(SUM(profit)) OVER (PARTITION BY category) AS profit_of_category
FROM data
GROUP BY product_name, category
ORDER BY profit_of_product DESC
LIMIT 10;
