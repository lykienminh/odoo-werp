CREATE TABLE IF NOT EXISTS public.account_account_type
(
    id integer NOT NULL DEFAULT nextval('account_account_type_id_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    include_initial_balance boolean,
    type character varying COLLATE pg_catalog."default" NOT NULL,
    internal_group character varying COLLATE pg_catalog."default" NOT NULL,
    note text COLLATE pg_catalog."default",
    create_uid integer,
    create_date timestamp without time zone,
    write_uid integer,
    write_date timestamp without time zone,
    CONSTRAINT account_account_type_pkey PRIMARY KEY (id),
    CONSTRAINT account_account_type_create_uid_fkey FOREIGN KEY (create_uid)
        REFERENCES public.res_users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT account_account_type_write_uid_fkey FOREIGN KEY (write_uid)
        REFERENCES public.res_users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL
)
