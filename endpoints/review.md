# Review

- [GET](#get-reviews)
- [POST](#post-reviews)
- [PUT](#put-reviewsreviewid)
- [DELETE](#delete-reviewsreviewid)

## GET /reviews

### Parameters
- no parameters

### Headers
- no authorization needed

### Request body
- not needed

### Response
- list of reviews
#### Status codes
- 200 OK

### Example

```
GET /reviews
```

```
200 OK
[
    {
        "review_id": e440b850-09b8-4e54-9328-9b29a42d9e7d
        "rating": 4,
        "content": "Great laptop!"
        "review_date": "2023-02-01"
        "product_id": ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee,
        "user_id": d63133a3-6c20-4a49-ae1b-9bf61ef3271a
    },
    {
        "review_id": b4e4d4ad-e320-4cf2-9293-4f8c8800cf50
        "rating": 5,
        "content": "Excellent smartphone"
        "review_date": "2023-02-02"
        "product_id": 3a89e838-23c3-4782-808a-b5c0a1f4f6e1,
        "user_id": f5f02984-78e3-4c11-83cf-7694b907d9fe
    },
    {
        "review_id": 3c3f01b4-eeb4-4cc5-94a5-85d11602f6f6
        "rating": 4,
        "content": "Comfortable T-shirt"
        "review_date": "2023-02-03"
        "product_id": 8c222aae-0e54-49e7-8e48-37842fbc8f6c,
        "user_id": 3e5b1ed1-5125-4eb9-a06c-0f672d33fe69
    }
]
```

## GET /review/:reviewId

### Parameters
- reviewId: UUID

### Headers
- no authorization needed

### Request body
- not needed

### Response
- found review
#### Status codes
- 200 OK
- 404 Not found (id not found)

### Example

```
GET /reviews/e440b850-09b8-4e54-9328-9b29a42d9e7d
```

```
200 OK
{
    "review_id": e440b850-09b8-4e54-9328-9b29a42d9e7d
    "rating": 4,
    "content": "Great laptop!"
    "review_date": "2023-02-01"
    "product_id": ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee,
    "user_id": d63133a3-6c20-4a49-ae1b-9bf61ef3271a
}
```

## GET /reviews/product/:productId

### Parameters
- productId: UUID

### Headers
- no authorization needed

### Request body
- not needed

### Response
- list of reviews
#### Status codes
- 200 OK
- 404 Not found (id not found)

### Example

```
GET /reviews/ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee
```

```
200 OK
[
    {
        "review_id": e440b850-09b8-4e54-9328-9b29a42d9e7d
        "rating": 4,
        "content": "Great laptop!"
        "review_date": "2023-02-01"
        "product_id": ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee,
        "user_id": d63133a3-6c20-4a49-ae1b-9bf61ef3271a
    }
]

```

## GET /reviews/user/:userId

### Parameters
- userId: UUID

### Headers
- no authorization needed

### Request body
- not needed

### Response
- list of reviews
#### Status codes
- 200 OK
- 404 Not found (id not found)

### Example

```
GET /reviews/user/d63133a3-6c20-4a49-ae1b-9bf61ef3271a
```

```
200 OK
[
    {
        "review_id": e440b850-09b8-4e54-9328-9b29a42d9e7d
        "rating": 4,
        "content": "Great laptop!"
        "review_date": "2023-02-01"
        "product_id": ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee,
        "user_id": d63133a3-6c20-4a49-ae1b-9bf61ef3271a
    }
]

```

## POST /reviews

### Parameters
- no parameters

### Headers
- authorization needed: 
```
{
  "Authorization": "Bearer {token}"
}
```

### Request body
- all fields required
- product_id and user_id must be found in database
- rating should be between 1 and 5
```
{
    "rating": {integer}
    "content": {string}
    "product_id": {uuid}
    "user_id": {uuid}
}
```

### Response
- created review
#### Status codes
- 201 Created
- 400 Bad request (invalid request body)
- 401 Unauthorized (invalid token, no authorization token)
- 403 Forbidden (token not belonging to admin)

### Example

```
POST /reviews/
Authorization: Bearer {token} 
{
    "rating": 4,
    "content": "Great laptop!"
    "product_id": ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee,
    "user_id": d63133a3-6c20-4a49-ae1b-9bf61ef3271a
}
```

```
201 Created
{
    "review_id": e440b850-09b8-4e54-9328-9b29a42d9e7d
    "rating": 4,
    "content": "Great laptop!"
    "review_date": "2023-02-01"
    "product_id": ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee,
    "user_id": d63133a3-6c20-4a49-ae1b-9bf61ef3271a
}
```

## PUT /reviews/:reviewId

### Parameters
- reviewId: UUID

### Headers
- authorization needed: 
```
{
  "Authorization": "Bearer {token}"
}
```

### Request body
- provide fields to be changed (at least one)
- product_id and user_id must be found in database
- rating should be between 1 and 5
```
{
    "rating": {integer}
    "content": {string}
    "product_id": {uuid}
    "user_id": {uuid}
}
```

### Response
- updated review
#### Status codes
- 200 OK
- 400 Bad request (invalid request body)
- 401 Unauthorized (invalid token, no authorization token)
- 403 Forbidden (token not belonging to admin)
- 404 Not found (id not found)

### Example

```
PUT /reviews/e440b850-09b8-4e54-9328-9b29a42d9e7d
Authorization: Bearer {token} 
{
    "rating": "3"
    "content": "Laptop is ok"
}
```

```
200 OK
{
    "review_id": e440b850-09b8-4e54-9328-9b29a42d9e7d
    "rating": 3,
    "content": "Laptop is ok"
    "review_date": "2023-02-01"
    "product_id": ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee,
    "user_id": d63133a3-6c20-4a49-ae1b-9bf61ef3271a
}
```

## DELETE /reviews/:reviewId

### Parameters
- reviewId: UUID

### Headers
- authorization needed: 
```
{
  "Authorization": "Bearer {token}"
}
```

### Request body
- no request body needed

### Response
- boolean
#### Status codes
- 200 OK
- 401 Unauthorized (invalid token, no authorization token)
- 403 Forbidden (token not belonging to admin)
- 404 Not found (id not found)

### Example

```
DELETE /reviews/e440b850-09b8-4e54-9328-9b29a42d9e7d
Authorization: Bearer {token} 
```
```
200 OK
{
    true
}
```