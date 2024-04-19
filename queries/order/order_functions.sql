--   -This function retrieves all orders from the database.
--   -get_all_orders()
--   -Output: returns a table of orders
--   -Example: SELECT * FROM get_all_orders()
CREATE OR REPLACE FUNCTION get_all_orders()
RETURNS TABLE(orderID uuid, userID uuid, orderDate date, orderStatus status) AS $$
BEGIN
RETURN QUERY SELECT * FROM public.order;
END;
$$ LANGUAGE plpgsql;

--   -This function retrieves an order with the given id from the database.
--   -get_order_by_id(orderId UUID)
--   -Input: orderID (id of the order to be retreived)
--   -Output: returns an order
--   -Example: SELECT * FROM get_order_by_id('ac4f3e1c-16c5-4c20-aa7b-3e8d929268e3');
CREATE OR REPLACE FUNCTION get_order_by_id(id uuid)
RETURNS TABLE(orderID uuid, userID uuid, orderDate date, orderStatus status) AS $$
BEGIN
	IF NOT EXISTS (SELECT * FROM public.order WHERE order_id = id)
	THEN RAISE EXCEPTION no_data_found USING message = 'Order id not found';
	END IF;

	RETURN QUERY SELECT * FROM public.order WHERE order_id = id;
END;
$$ LANGUAGE plpgsql;

--   -This function retrieves all orders with the given id from the database.
--   -get_orders_by_user(userID UUID)
--   -Input: user_id_to_find (id of the user whose orders are retreived)
--   -Output: returns a table of orders
--   -Example: SELECT * FROM get_orders_by_user('d63133a3-6c20-4a49-ae1b-9bf61ef3271a');
CREATE OR REPLACE FUNCTION get_orders_by_user(user_id_to_find uuid)
RETURNS TABLE(orderID uuid, userID uuid, orderDate date, orderStatus status) AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM public.user WHERE user_id = user_id_to_find)
	THEN RAISE EXCEPTION no_data_found USING message = 'User not found';
	END IF;

	RETURN QUERY SELECT * FROM public.order WHERE user_id = user_id_to_find;

    EXCEPTION
		WHEN no_data_found THEN RAISE;
END;
$$ LANGUAGE plpgsql;

--   -This function adds an order in the database.
--   -add_order(user_id_add uuid, order_status_add status)
--   -Input: user_id_add (id of the customer who makes the order), order_status_add (status of the order: pending, processing, shipped, delivered, completed or cancelled)
--   -Output: returns a table containing the added order
--   -Example: SELECT * FROM add_order('d63133a3-6c20-4a49-ae1b-9bf61ef3271a', 'shipped');
CREATE OR REPLACE FUNCTION add_order(user_id_add uuid, order_status_add status)
RETURNS TABLE(orderID uuid, userID uuid, orderDate date, orderStatus status) AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM public.user WHERE user_id = user_id_add)
	THEN RAISE EXCEPTION no_data_found USING message = 'User not found';
	END IF;

    RETURN QUERY 
        INSERT INTO public.order (order_id, user_id, order_date, order_status)
        VALUES(gen_random_uuid(), user_id_add, now(), order_status_add)
        RETURNING *;
END;
$$ LANGUAGE plpgsql;

--   -This function updates the status of an order in the database.
--   -update_order_status(order_id_update UUID, new_order_status STATUS)
--   -Input: order_id_update (id of the order to be updated), new_order_status (the new status of the order)
--   -Output: returns a table containing the updated order
CREATE OR REPLACE FUNCTION update_order_status(order_id_update UUID, new_order_status STATUS)
RETURNS TABLE(orderID uuid, userID uuid, orderDate date, orderStatus status) AS $$
BEGIN
    RETURN QUERY
        UPDATE public.order
        SET order_status = new_order_status
        WHERE order_id = order_id_update
        RETURNING *;
END;
$$ LANGUAGE plpgsql;

--   -This function deletes an order in the database.
--   -delete_order(order_id_delete UUID)
--   -Input: order_id_delete (id of the order to be deleted), 
--   -Output: boolean
CREATE OR REPLACE FUNCTION delete_order(order_id_delete uuid)
RETURNS BOOLEAN AS $$
DECLARE
    deleted BOOLEAN;
BEGIN
    IF NOT EXISTS (SELECT * FROM public.order WHERE order_id = order_id_delete)
	THEN RAISE EXCEPTION no_data_found USING message = 'Order id not found';
	END IF;
    
    deleted := FALSE;
    DELETE FROM public.order WHERE order_id = order_id_delete;
    GET DIAGNOSTICS deleted = ROW_COUNT;
    RETURN deleted;
END;
$$ LANGUAGE plpgsql;