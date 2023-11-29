# Category

- [GET](#get-categories)
- [POST](#post-categories)
- [PUT](#put-categoriescategoryid)
- [DELETE](#delete-categoriescategoryid)

## GET /categories

### Parameters
- no parameters

### Headers
- no authorization needed

### Request body
- not needed

### Response
- list of categories
#### Status codes
- 200 OK

### Example

```
GET /categories
```

```
200 OK
[
    {
        "category_id": f2e28553-2b43-4d61-bb4d-20a2b88048a0
        "name": "Electronics"
        "image": "https://placekitten.com/200/200"
    },
    {
        "category_id": 2ff524f8-e00a-47d3-b2a4-2fe8ec64987d
        "name": "Clothing"
        "image": "https://placekitten.com/200/201"
    },
    {
        "category_id": 136d0e79-295b-4cf1-8e86-d7578c637d94
        "name": "Home and Furniture"
        "image": "https://placekitten.com/200/202"
    }
]
```

## GET /categories/:categoryId

### Parameters
- categoryId: UUID

### Headers
- no authorization needed

### Request body
- not needed

### Response
- found category
#### Status codes
- 200 OK
- 404 Not found (id not found)

### Example

```
GET /categories/f2e28553-2b43-4d61-bb4d-20a2b88048a0
```

```
200 OK
{
    "category_id": f2e28553-2b43-4d61-bb4d-20a2b88048a0
    "name": "Electronics"
    "image": "https://placekitten.com/200/200"
}
```

## GET /categories/:categoryId/products

### Parameters
- categoryId: UUID

### Headers
- no authorization needed

### Request body
- not needed

### Response
- list of products associated with the category
#### Status codes
- 200 OK
- 404 Not found (id not found)

### Example

```
GET /categories/f2e28553-2b43-4d61-bb4d-20a2b88048a0/products
```

```
200 OK
[
    {
        "product_id": ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee,
        "title": "Laptop", 
        "description":"High-performance laptop",
        "price": 999.99
        "category_id": f2e28553-2b43-4d61-bb4d-20a2b88048a0
    },
    {
        "product_id": 3a89e838-23c3-4782-808a-b5c0a1f4f6e1,
        "title": "Smartphone", 
        "description":"Flagship smartphone",
        "price": 599.99
        "category_id": f2e28553-2b43-4d61-bb4d-20a2b88048a0
    }
]
```

## POST /categories

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
- image has to be a valid url
```
{
    "name": {string}
    "image": {string}
}
```

### Response
- created category
#### Status codes
- 201 Created
- 400 Bad request (parts of request body missing, invalid image url)
- 401 Unauthorized (invalid token, no authorization token)
- 403 Forbidden (token not belonging to admin)

### Example

```
POST /categories/
Authorization: Bearer {token} 
{
    "name": "New category"
    "image": "https://picsum.photos/200"
}
```

```
201 Created
{
    category_id: f2e28553-2b43-4d61-bb4d-20a2b88048a0
    name: "Changed category"
    image: "https://picsum.photos/200"
}
```

## PUT /categories/:categoryId

### Parameters
- categoryId: UUID

### Headers
- authorization needed: 
```
{
  "Authorization": "Bearer {token}"
}
```

### Request body
- provide fields to be changed (at least one)
- image has to be a valid url
```
{
    "name": {string}
    "image": {string}
}
```

### Response
- updated category
#### Status codes
- 200 OK
- 400 Bad request (invalid request body, invalid image url)
- 401 Unauthorized (invalid token, no authorization token)
- 403 Forbidden (token not belonging to admin)
- 404 Not found (id not found)

### Example

```
PUT /categories/f2e28553-2b43-4d61-bb4d-20a2b88048a0
Authorization: Bearer {token} 
{
    "name": "Changed category"
    "image": "https://picsum.photos/200"
}
```

```
200 OK
{
    category_id: f2e28553-2b43-4d61-bb4d-20a2b88048a0
    name: "Changed category"
    image: "https://picsum.photos/200"
}
```

## DELETE /categories/:categoryId

### Parameters
- categoryId: UUID

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
DELETE /categories/f2e28553-2b43-4d61-bb4d-20a2b88048a0
Authorization: Bearer {token} 
```
```
200 OK
{
    true
}
```