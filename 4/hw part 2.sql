use 4_sem;
# Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю
SELECT a.an_name AS 'Наименование анализа', SUM(a.an_cost) AS 'Общая стоимость' 
FROM orders AS o 
INNER JOIN analysis AS a
ON a.an_id=o.ord_an
WHERE (o.ord_datetime>'2020-02-05 00:00:00') AND (datediff(o.ord_datetime,'2020-02-05 00:00:00')<7)
GROUP BY a.an_name;