--   -This function retrieves all reviews from the database.
--   -get_all_reviews()
--   -Output: returns a table of reviews
--   -Example: SELECT * FROM get_all_reviews()
CREATE OR REPLACE FUNCTION get_all_reviews()
RETURNS SETOF review AS $$
BEGIN
RETURN QUERY SELECT * FROM public.review;
END;
$$ LANGUAGE plpgsql;

--   -This function retrieves a review with the given id from the database.
--   -get_review_by_id(reviewId UUID)
--   -Input: reviewID (id of the review to be retreived)
--   -Output: returns a review
--   -Example: SELECT * FROM get_review_by_id('e440b850-09b8-4e54-9328-9b29a42d9e7d');
CREATE OR REPLACE FUNCTION get_review_by_id(id uuid)
RETURNS review AS $$
DECLARE
	r review;
BEGIN
	IF NOT EXISTS (SELECT * FROM public.review WHERE review_id = id)
	THEN RAISE EXCEPTION no_data_found USING message = 'Review id not found';
	END IF;

	SELECT * INTO r FROM public.review WHERE review_id = id;
	RETURN r;

	EXCEPTION
		WHEN no_data_found THEN RAISE;
END;
$$ LANGUAGE plpgsql;

--   -This function retrieves all review with the given product id from the database.
--   -get_reviews_by_product(productID UUID)
--   -Input: productID (id of the product of which reviews are retreived)
--   -Output: returns a table of reviews
--   -Example: SELECT * FROM get_reviews_by_product('ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee');
CREATE OR REPLACE FUNCTION get_reviews_by_product(productID uuid)
RETURNS SETOF review AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM public.product WHERE product_id = productID)
	THEN RAISE EXCEPTION no_data_found USING message = 'Product not found';
	END IF;

	RETURN QUERY SELECT * FROM public.review WHERE product_id = productID;

    EXCEPTION
		WHEN no_data_found THEN RAISE;
END;
$$ LANGUAGE plpgsql;

--   -This function retrieves all reviews with the given user id from the database.
--   -get_reviews_by_user(userID UUID)
--   -Input: userID (id of the user whose reviews are retreived)
--   -Output: returns a table of reviews
--   -Example: SELECT * FROM get_reviews_by_user('d63133a3-6c20-4a49-ae1b-9bf61ef3271a');
CREATE OR REPLACE FUNCTION get_reviews_by_user(userID uuid)
RETURNS SETOF review AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM public.user WHERE user_id = userID)
	THEN RAISE EXCEPTION no_data_found USING message = 'User not found';
	END IF;

	RETURN QUERY SELECT * FROM public.review WHERE user_id = userID;

    EXCEPTION
		WHEN no_data_found THEN RAISE;
END;
$$ LANGUAGE plpgsql;

--   -This function adds a review in the database.
--   -add_review(rating integer, content text, productID uuid, userID uuid)
--   -Input: rating (1-5), content (review content), productID (id of the reviewed product), userID (id of the reviewer)
--   -Output: returns a table containing the added review
--   -Example: SELECT * FROM add_review(4, 'Great shirt', '8c222aae-0e54-49e7-8e48-37842fbc8f6c', 'd63133a3-6c20-4a49-ae1b-9bf61ef3271a');
CREATE OR REPLACE FUNCTION add_review(rating integer, content text, productID uuid, userID uuid)
RETURNS SETOF review AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM public.user WHERE user_id = userID)
	THEN RAISE EXCEPTION no_data_found USING message = 'User not found';
    ELSIF NOT EXISTS (SELECT * FROM public.product WHERE product_id = productID)
	THEN RAISE EXCEPTION no_data_found USING message = 'Product not found';
	END IF;
    RETURN QUERY 
        INSERT INTO public.review (review_id, rating, content, review_date, product_id, user_id)
        VALUES(gen_random_uuid(), rating, content, now(), productID, userID)
        RETURNING *;
END;
$$ LANGUAGE plpgsql;

--   -This function updates a review in the database.
--   -update_review(reviewID UUID, new_rating INTEGER, new_content TEXT)
--   -Input: rating (1-5), content (review content) any can be null, which keeps the existing value
--   -Output: returns a table containing the updated review
CREATE OR REPLACE FUNCTION update_review(reviewID uuid, new_rating integer, new_content text)
RETURNS SETOF review AS $$
BEGIN
    RETURN QUERY
        UPDATE public.review
        SET rating = COALESCE(new_rating, rating),
        content = COALESCE(new_content, content),
        WHERE review_id = reviewID
        RETURNING *;
END;
$$ LANGUAGE plpgsql;

--   -This function deletes a review in the database.
--   -delete_review(reviewID UUID)
--   -Input: reviewID (id of the review to be deleted), 
--   -Output: void
CREATE OR REPLACE FUNCTION delete_review(reviewID uuid)
RETURNS BOOLEAN AS $$
DECLARE
    deleted BOOLEAN;
BEGIN
    IF NOT EXISTS (SELECT * FROM public.review WHERE review_id = reviewID)
	THEN RAISE EXCEPTION no_data_found USING message = 'Review id not found';
	END IF;

    deleted := FALSE;
    DELETE FROM public.review WHERE review_id = reviewID;
	GET DIAGNOSTICS deleted = ROW_COUNT;
    RETURN deleted;
END;
$$ LANGUAGE plpgsql;