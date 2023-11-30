--   -This function retrieves all orders from the database.
SELECT * FROM get_all_orders()

--   -This function retrieves an order with the given id from the database.
SELECT * FROM get_order_by_id('ac4f3e1c-16c5-4c20-aa7b-3e8d929268e3');

--   -This function retrieves all orders with the given id from the database.
SELECT * FROM get_orders_by_user('d63133a3-6c20-4a49-ae1b-9bf61ef3271a');

--   -This function adds an order in the database.
SELECT * FROM add_order('d63133a3-6c20-4a49-ae1b-9bf61ef3271a', 'shipped');

--   -This function updates the status of an order in the database.
SELECT * FROM update_order_status('ac4f3e1c-16c5-4c20-aa7b-3e8d929268e3', 'delivered')

--   -This function deletes an order in the database.
SELECT * FROM delete_order('ac4f3e1c-16c5-4c20-aa7b-3e8d929268e3')