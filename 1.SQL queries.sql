use mavenmovies;

--Task 1.1

with monthly_rental as
(
select year(rental_date) as year, month(rental_date)as month, sum(amount)as Monthwise_revenue
  from rental
  left join payment on rental.rental_id=payment.payment_id
group by year,month
order by year,month
 ) 
select *, Monthwise_revenue-lag(Monthwise_revenue) over(order by year,month)as MonthOverMonth
  from monthly_rental
group by year, month;

--Task 1.2
 
 select dayname(rental_date)as Renting_Day,hour(rental_date)as hours,count(*)as peak_rental_hours
    from rental
 group by Renting_Day,hours
 order by peak_rental_hours desc;
 
 --Task 2.1

 select title,count(rental_id)as Number_of_Times_Rented
   from film
     join inventory on film.film_id=inventory.film_id
     join rental on inventory.inventory_id=rental.inventory_id
 group by title
 order by Number_of_Times_Rented desc
 limit 10;
 
 --Task 2.2
 
 select name as Film_Category_Name,count(rental_id)as Number_of_Rentals
   from category
     left join film_category on category.category_id=film_category.category_id
     left join inventory on film_category.film_id=inventory.film_id
     left join rental on inventory.inventory_id=rental.inventory_id
 group by Film_Category_Name
 order by Number_of_Rentals desc;
     
--Task 3.1

select store.store_id, sum(amount)as Highest_Rental_Revenue
  from store
     join staff on store.store_id=staff.store_id
   	 join payment on staff.staff_id=payment.staff_id
group by store_id
order by Highest_Rental_Revenue desc
limit 1;

--Task3.2

select staff.staff_id, concat(first_name," ",last_name)as Staff_Name,count(rental_id)as Rental_Count
  from staff
  join rental on staff.staff_id=rental.staff_id
group by staff_id,Staff_Name
order by Rental_Count desc;

