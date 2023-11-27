CREATE DATABASE "e-commerce"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE IF NOT EXISTS public.category
(
    category_id uuid NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    image character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT category_pkey PRIMARY KEY (category_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.category
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."order"
(
    order_id uuid NOT NULL,
    user_id uuid NOT NULL,
    order_date date NOT NULL,
    CONSTRAINT order_pkey PRIMARY KEY (order_id),
    CONSTRAINT order_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public."user" (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."order"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.order_product
(
    order_id uuid NOT NULL,
    product_id uuid NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT order_product_order_id_fkey FOREIGN KEY (order_id)
        REFERENCES public."order" (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT order_product_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT order_product_quantity_positive CHECK (quantity > 0) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_product
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.product
(
    product_id uuid NOT NULL,
    title character varying COLLATE pg_catalog."default" NOT NULL,
    description character varying COLLATE pg_catalog."default" NOT NULL,
    price numeric NOT NULL,
    category_id uuid NOT NULL,
    CONSTRAINT product_pkey PRIMARY KEY (product_id),
    CONSTRAINT category FOREIGN KEY (category_id)
        REFERENCES public.category (category_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_price_positive CHECK (price > 0::numeric) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.product_image
(
    image_id uuid NOT NULL,
    url character varying COLLATE pg_catalog."default",
    product_id uuid NOT NULL,
    CONSTRAINT product_image_pkey PRIMARY KEY (image_id),
    CONSTRAINT product_image_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_image
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.review
(
    review_id uuid NOT NULL,
    rating smallint NOT NULL,
    content text COLLATE pg_catalog."default" NOT NULL,
    review_date date NOT NULL,
    product_id uuid NOT NULL,
    user_id uuid NOT NULL,
    CONSTRAINT review_pkey PRIMARY KEY (review_id),
    CONSTRAINT review_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT review_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public."user" (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.review
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.role
(
    role_id smallint NOT NULL,
    role character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT role_pkey PRIMARY KEY (role_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.role
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."user"
(
    user_id uuid NOT NULL,
    email character varying COLLATE pg_catalog."default" NOT NULL,
    password character varying COLLATE pg_catalog."default" NOT NULL,
    avatar character varying COLLATE pg_catalog."default" NOT NULL,
    role_id smallint NOT NULL,
    CONSTRAINT user_pkey PRIMARY KEY (user_id),
    CONSTRAINT user_email_unique UNIQUE (email),
    CONSTRAINT user_role_id_fkey FOREIGN KEY (role_id)
        REFERENCES public.role (role_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."user"
    OWNER to postgres;