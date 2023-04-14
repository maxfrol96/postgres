-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select distinct customers.company_name, concat(first_name, ' ', last_name) as emp_name
from customers
inner join orders using(customer_id)
inner join employees using(employee_id)
inner join shippers on orders.ship_via = shippers.shipper_id
where employees.city = 'London' and customers.city = 'London' and shippers.company_name = 'United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select product_name, units_in_stock, contact_name, phone from products
left join suppliers using (supplier_id)
left join categories using (category_id)
where discontinued = 0 and units_in_stock < 25 and category_name in('Dairy Products', 'Condiments')
order by units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select distinct company_name from customers
left join orders using (customer_id)
where orders.order_id is null

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select product_name from products
where product_id in (select product_id from order_details where quantity = 10)