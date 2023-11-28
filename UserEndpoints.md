## Users Endpoints
baseURL: www.ecommerce.com 
Retrieve a list of all registered users. [GET] /api/v1/users 
HTTP response status codes 200  
Response: 
[
    {
        "id": 1,
        "email": "jenny@mail.com",
        "password": "happynewyear",
        "name": "Jenny",
        "role": "customer",
        "avatar": "https://i.imgur.com/LDOO4Qs.jpg",
    },
    {
        "id": 2,
        "email": "minna@mail.com",
        "password": "threadwest",
        "name": "Minna",
        "role": "customer",
        "avatar": "https://i.imgur.com/LDOO4Qs.jpg",
    },
    ...
]


