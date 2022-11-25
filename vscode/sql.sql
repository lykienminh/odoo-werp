CREATE TABLE IF NOT EXISTS public.res_partner
(
    id integer NOT NULL DEFAULT nextval('res_partner_id_seq'::regclass),
    name character varying COLLATE pg_catalog."default",
    company_id integer,
    create_date timestamp without time zone,
    display_name character varying COLLATE pg_catalog."default",
    date date,
    title integer,
    parent_id integer,
    ref character varying COLLATE pg_catalog."default",
    lang character varying COLLATE pg_catalog."default",
    tz character varying COLLATE pg_catalog."default",
    user_id integer,
    vat character varying COLLATE pg_catalog."default",
    website character varying COLLATE pg_catalog."default",
    comment text COLLATE pg_catalog."default",
    credit_limit double precision,
    active boolean,
    employee boolean,
    function character varying COLLATE pg_catalog."default",
    type character varying COLLATE pg_catalog."default",
    street character varying COLLATE pg_catalog."default",
    street2 character varying COLLATE pg_catalog."default",
    zip character varying COLLATE pg_catalog."default",
    city character varying COLLATE pg_catalog."default",
    state_id integer,
    country_id integer,
    partner_latitude numeric,
    partner_longitude numeric,
    email character varying COLLATE pg_catalog."default",
    phone character varying COLLATE pg_catalog."default",
    mobile character varying COLLATE pg_catalog."default",
    is_company boolean,
    industry_id integer,
    color integer,
    partner_share boolean,
    commercial_partner_id integer,
    commercial_company_name character varying COLLATE pg_catalog."default",
    company_name character varying COLLATE pg_catalog."default",
    create_uid integer,
    write_uid integer,
    write_date timestamp without time zone,
    message_main_attachment_id integer,
    email_normalized character varying COLLATE pg_catalog."default",
    message_bounce integer,
    signup_token character varying COLLATE pg_catalog."default",
    signup_type character varying COLLATE pg_catalog."default",
    signup_expiration timestamp without time zone,
    partner_gid integer,
    additional_info character varying COLLATE pg_catalog."default",
    phone_sanitized character varying COLLATE pg_catalog."default",
    picking_warn character varying COLLATE pg_catalog."default",
    picking_warn_msg text COLLATE pg_catalog."default",
    CONSTRAINT res_partner_pkey PRIMARY KEY (id),
    CONSTRAINT res_partner_commercial_partner_id_fkey FOREIGN KEY (commercial_partner_id)
        REFERENCES public.res_partner (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT res_partner_company_id_fkey FOREIGN KEY (company_id)
        REFERENCES public.res_company (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT res_partner_country_id_fkey FOREIGN KEY (country_id)
        REFERENCES public.res_country (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE RESTRICT,
    CONSTRAINT res_partner_create_uid_fkey FOREIGN KEY (create_uid)
        REFERENCES public.res_users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT res_partner_industry_id_fkey FOREIGN KEY (industry_id)
        REFERENCES public.res_partner_industry (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT res_partner_message_main_attachment_id_fkey FOREIGN KEY (message_main_attachment_id)
        REFERENCES public.ir_attachment (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT res_partner_parent_id_fkey FOREIGN KEY (parent_id)
        REFERENCES public.res_partner (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT res_partner_state_id_fkey FOREIGN KEY (state_id)
        REFERENCES public.res_country_state (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE RESTRICT,
    CONSTRAINT res_partner_title_fkey FOREIGN KEY (title)
        REFERENCES public.res_partner_title (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT res_partner_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.res_users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT res_partner_write_uid_fkey FOREIGN KEY (write_uid)
        REFERENCES public.res_users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT res_partner_check_name CHECK (type::text = 'contact'::text AND name IS NOT NULL OR type::text <> 'contact'::text)
)
