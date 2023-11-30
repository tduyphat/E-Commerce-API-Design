--   -This function retrieves all reviews from the database.
SELECT * FROM get_all_reviews()

--   -This function retrieves a review with the given id from the database.
SELECT * FROM get_review_by_id('e440b850-09b8-4e54-9328-9b29a42d9e7d');

--   -This function retrieves all review with the given product id from the database.
SELECT * FROM get_reviews_by_product('ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee');

--   -This function retrieves all reviews with the given user id from the database.
SELECT * FROM get_reviews_by_user('d63133a3-6c20-4a49-ae1b-9bf61ef3271a');

--   -This function adds a review in the database.
SELECT * FROM add_review(4, 'Great shirt', '8c222aae-0e54-49e7-8e48-37842fbc8f6c', 'd63133a3-6c20-4a49-ae1b-9bf61ef3271a');

--   -This function updates a review in the database.
SELECT * FROM update_review('d63133a3-6c20-4a49-ae1b-9bf61ef3271a', 3, null)

--   -This function deletes a review in the database.
SELECT * FROM delete_review('d63133a3-6c20-4a49-ae1b-9bf61ef3271a')