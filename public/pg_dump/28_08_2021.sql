--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: sp_delete_airline(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_delete_airline(_id bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
    declare
        rows_count int:=0;
    begin
        With rows AS (
            DELETE FROM airlines
            WHERE id=_id
            RETURNING 1)
            select count(*) into rows_count from rows;
            return rows_count;
    end ;
    $$;


ALTER FUNCTION public.sp_delete_airline(_id bigint) OWNER TO postgres;

--
-- Name: sp_delete_and_reset_airlines(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_delete_and_reset_airlines()
    LANGUAGE plpgsql
    AS $$
begin
        delete from airlines
        where id >= 1;
        alter sequence airlines_id_seq restart with 1;
    end;
$$;


ALTER PROCEDURE public.sp_delete_and_reset_airlines() OWNER TO postgres;

--
-- Name: sp_delete_and_reset_countries(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_delete_and_reset_countries()
    LANGUAGE plpgsql
    AS $$
    begin
        delete from countries
        where id >= 1;
        alter sequence countries_id_seq restart with 1;
    end;
    $$;


ALTER PROCEDURE public.sp_delete_and_reset_countries() OWNER TO postgres;

--
-- Name: sp_delete_and_reset_customers(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_delete_and_reset_customers()
    LANGUAGE plpgsql
    AS $$
begin
        delete from customers
        where id >= 1;
        alter sequence customers_id_seq restart with 1;
    end;
$$;


ALTER PROCEDURE public.sp_delete_and_reset_customers() OWNER TO postgres;

--
-- Name: sp_delete_and_reset_flights(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_delete_and_reset_flights()
    LANGUAGE plpgsql
    AS $$
begin
        delete from flights
        where id >= 1;
        alter sequence flights_id_seq restart with 1;
    end;
$$;


ALTER PROCEDURE public.sp_delete_and_reset_flights() OWNER TO postgres;

--
-- Name: sp_delete_and_reset_tickets(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_delete_and_reset_tickets()
    LANGUAGE plpgsql
    AS $$
begin
        delete from tickets
        where id >= 1;
        alter sequence tickets_id_seq restart with 1;
    end;
$$;


ALTER PROCEDURE public.sp_delete_and_reset_tickets() OWNER TO postgres;

--
-- Name: sp_delete_and_reset_users(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_delete_and_reset_users()
    LANGUAGE plpgsql
    AS $$
begin
        delete from users
        where id >= 1;
        alter sequence users_id_seq restart with 1;
    end;
$$;


ALTER PROCEDURE public.sp_delete_and_reset_users() OWNER TO postgres;

--
-- Name: sp_delete_countries(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_delete_countries(_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
        DECLARE
            rows_count int := 0;
        BEGIN
            WITH rows AS (
            DELETE FROM countries
            WHERE id = _id
            RETURNING 1)
            select count(*) into rows_count from rows;
            return rows_count;
        END;
    $$;


ALTER FUNCTION public.sp_delete_countries(_id integer) OWNER TO postgres;

--
-- Name: sp_delete_customers(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_delete_customers(_id bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
    declare
        rows_count int:=0;
    begin
        With rows AS (
            DELETE FROM customers
            WHERE id=_id
            RETURNING 1)
            select count(*) into rows_count from rows;
            return rows_count;
    end ;
    $$;


ALTER FUNCTION public.sp_delete_customers(_id bigint) OWNER TO postgres;

--
-- Name: sp_delete_flights(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_delete_flights(_id bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
    declare
        rows_count int:=0;
    begin
        With rows AS (
            DELETE FROM flights
            WHERE id=_id
            RETURNING 1)
            select count(*) into rows_count from rows;
            return rows_count;
    end ;
    $$;


ALTER FUNCTION public.sp_delete_flights(_id bigint) OWNER TO postgres;

--
-- Name: sp_delete_ticket(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_delete_ticket(_id bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
    declare
        rows_count int:=0;
    begin
        With rows AS (
            DELETE FROM tickets
            WHERE id=_id
            RETURNING 1)
            select count(*) into rows_count from rows;
            return rows_count;
    end ;
    $$;


ALTER FUNCTION public.sp_delete_ticket(_id bigint) OWNER TO postgres;

--
-- Name: sp_delete_user(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_delete_user(_id bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
        DECLARE
            rows_count int := 0;
        BEGIN
            WITH rows AS (
            DELETE FROM users
            WHERE id = _id
            RETURNING 1)
            select count(*) into rows_count from rows;
            return rows_count;
        END;
    $$;


ALTER FUNCTION public.sp_delete_user(_id bigint) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: airlines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.airlines (
    id bigint NOT NULL,
    name text NOT NULL,
    country_id integer NOT NULL,
    user_id bigint
);


ALTER TABLE public.airlines OWNER TO postgres;

--
-- Name: sp_get_airline_by_id(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_airline_by_id(_id bigint) RETURNS SETOF public.airlines
    LANGUAGE plpgsql
    AS $$

    begin
        RETURN QUERY
        SELECT * from airlines
        WHERE id=_id;
    end;

    $$;


ALTER FUNCTION public.sp_get_airline_by_id(_id bigint) OWNER TO postgres;

--
-- Name: sp_get_all_airlines(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_all_airlines() RETURNS TABLE(_id bigint, _name text, _country_id integer, _user_id bigint)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT * from airlines;
    END;
    $$;


ALTER FUNCTION public.sp_get_all_airlines() OWNER TO postgres;

--
-- Name: sp_get_all_airlines_join(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_all_airlines_join() RETURNS TABLE(id bigint, name text, country text, username text)
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN QUERY
            SELECT a.id, a.name, c.name, u.username
             from airlines a
            join countries c on a.country_id = c.id
            join users u on a.user_id=u.id;
        END;
    $$;


ALTER FUNCTION public.sp_get_all_airlines_join() OWNER TO postgres;

--
-- Name: sp_get_all_countries(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_all_countries() RETURNS TABLE(id integer, name text)
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN QUERY
            SELECT * from countries;
        END;
    $$;


ALTER FUNCTION public.sp_get_all_countries() OWNER TO postgres;

--
-- Name: sp_get_all_customers(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_all_customers() RETURNS TABLE(_id bigint, _first_name text, _last_name text, _address text, _phone_no text, _user_id bigint, _credit_card_no text)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT * from customers;
    END;
    $$;


ALTER FUNCTION public.sp_get_all_customers() OWNER TO postgres;

--
-- Name: sp_get_all_flights(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_all_flights() RETURNS TABLE(_id bigint, _airline_id bigint, _origin_country_id integer, _destination_country_id integer, _departure_time timestamp without time zone, _landing_time timestamp without time zone, _remaining_tickets integer)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT * from flights;
    END;
    $$;


ALTER FUNCTION public.sp_get_all_flights() OWNER TO postgres;

--
-- Name: sp_get_all_tickets(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_all_tickets() RETURNS TABLE(_id bigint, _flight_id bigint, _customer_id bigint)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT * from tickets;
    END;
    $$;


ALTER FUNCTION public.sp_get_all_tickets() OWNER TO postgres;

--
-- Name: sp_get_all_tickets_join(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_all_tickets_join() RETURNS TABLE(id bigint, name text, first_name text, last_name text, departure_time timestamp without time zone, landing_time timestamp without time zone, origin text)
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN QUERY
            SELECT t.id, a.name , c.first_name, c.last_name,f.departure_time,f.landing_time,cu.name
             from tickets t
            join flights f on t.flight_id = f.id
            join customers c on t.customer_id=c.id
            join airlines a on f.airline_id=a.id
            join countries cu on f.origin_country_id=cu.id;
        END;
    $$;


ALTER FUNCTION public.sp_get_all_tickets_join() OWNER TO postgres;

--
-- Name: sp_get_all_users(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_all_users() RETURNS TABLE(_id bigint, _username text, _password text, _email text)
    LANGUAGE plpgsql
    AS $$
       BEGIN
           return query
           select * from users;
       END;
    $$;


ALTER FUNCTION public.sp_get_all_users() OWNER TO postgres;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: sp_get_country_by_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_country_by_id(_id integer) RETURNS SETOF public.countries
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN QUERY
            SELECT * from countries
            WHERE id = _id;
        END;
    $$;


ALTER FUNCTION public.sp_get_country_by_id(_id integer) OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id bigint NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    address text NOT NULL,
    phone_no text NOT NULL,
    user_id bigint NOT NULL,
    credit_card_no text NOT NULL
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: sp_get_customer_by_id(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_customer_by_id(_id bigint) RETURNS SETOF public.customers
    LANGUAGE plpgsql
    AS $$

    begin
        RETURN QUERY
        SELECT * from customers
        WHERE id=_id;
    end;


    $$;


ALTER FUNCTION public.sp_get_customer_by_id(_id bigint) OWNER TO postgres;

--
-- Name: flights; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flights (
    id bigint NOT NULL,
    airline_id bigint NOT NULL,
    origin_country_id integer NOT NULL,
    destination_country_id integer NOT NULL,
    departure_time timestamp without time zone NOT NULL,
    landing_time timestamp without time zone NOT NULL,
    remaining_tickets integer NOT NULL
);


ALTER TABLE public.flights OWNER TO postgres;

--
-- Name: sp_get_flight_by_id(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_flight_by_id(_id bigint) RETURNS SETOF public.flights
    LANGUAGE plpgsql
    AS $$

    begin
        RETURN QUERY
        SELECT * from flights
        WHERE id=_id;
    end;


    $$;


ALTER FUNCTION public.sp_get_flight_by_id(_id bigint) OWNER TO postgres;

--
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickets (
    id bigint NOT NULL,
    flight_id bigint NOT NULL,
    customer_id bigint NOT NULL
);


ALTER TABLE public.tickets OWNER TO postgres;

--
-- Name: sp_get_ticket_by_id(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_ticket_by_id(_id bigint) RETURNS SETOF public.tickets
    LANGUAGE plpgsql
    AS $$

    begin
        RETURN QUERY
        SELECT * from tickets
        WHERE id=_id;
    end;

    $$;


ALTER FUNCTION public.sp_get_ticket_by_id(_id bigint) OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    email text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: sp_get_user_by_id(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_get_user_by_id(_id bigint) RETURNS SETOF public.users
    LANGUAGE plpgsql
    AS $$
        BEGIN
            RETURN QUERY
            SELECT * from users
            WHERE id = _id;
        END;
    $$;


ALTER FUNCTION public.sp_get_user_by_id(_id bigint) OWNER TO postgres;

--
-- Name: sp_insert_airline(text, integer, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_insert_airline(_name text, _country_id integer, _user_id bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
    declare
        new_id bigint;
    begin
        INSERT INTO airlines(name, country_id, user_id)
        VALUES (_name,_country_id,_user_id)
        returning id into  new_id;
        return new_id;
    end;

    $$;


ALTER FUNCTION public.sp_insert_airline(_name text, _country_id integer, _user_id bigint) OWNER TO postgres;

--
-- Name: sp_insert_country(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_insert_country(_name text) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
        DECLARE
            new_id bigint;
        BEGIN
            INSERT INTO countries (name)
            VALUES (_name)
            RETURNING id into new_id;

            return new_id;
        END;
    $$;


ALTER FUNCTION public.sp_insert_country(_name text) OWNER TO postgres;

--
-- Name: sp_insert_customer(text, text, text, text, bigint, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_insert_customer(_first_name text, _last_name text, _address text, _phone_no text, _user_id bigint, _credit_card_no text) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
    declare
        new_id bigint;
    begin
        INSERT INTO customers(first_name, last_name, address, phone_no, user_id, credit_card_no)
        VALUES (_first_name,_last_name,_address,_phone_no,_user_id,_credit_card_no)
        returning id into  new_id;
        return new_id;
    end;

    $$;


ALTER FUNCTION public.sp_insert_customer(_first_name text, _last_name text, _address text, _phone_no text, _user_id bigint, _credit_card_no text) OWNER TO postgres;

--
-- Name: sp_insert_flight(bigint, integer, integer, timestamp without time zone, timestamp without time zone, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_insert_flight(_airline_id bigint, _origin_country_id integer, _destination_country_id integer, _departure_time timestamp without time zone, _landing_time timestamp without time zone, _remaining_tickets integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
    declare
        new_id bigint;
    begin
        INSERT INTO flights(airline_id, origin_country_id, destination_country_id,
                            departure_time, landing_time,remaining_tickets)
        VALUES (_airline_id,_origin_country_id,_destination_country_id,_departure_time,
                _landing_time,_remaining_tickets)
        returning id into  new_id;
        return new_id;
    end;

    $$;


ALTER FUNCTION public.sp_insert_flight(_airline_id bigint, _origin_country_id integer, _destination_country_id integer, _departure_time timestamp without time zone, _landing_time timestamp without time zone, _remaining_tickets integer) OWNER TO postgres;

--
-- Name: sp_insert_ticket(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_insert_ticket(_flight_id bigint, _customer_id bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
    declare
        new_id bigint;
    begin
        INSERT INTO tickets( flight_id, customer_id)
        VALUES (_flight_id,_customer_id)
        returning id into  new_id;
        return new_id;
    end;

    $$;


ALTER FUNCTION public.sp_insert_ticket(_flight_id bigint, _customer_id bigint) OWNER TO postgres;

--
-- Name: sp_insert_users(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_insert_users(_username text, _password text, _email text) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
            new_id bigint;
        BEGIN
            INSERT INTO users (username,password,email)
            VALUES (_username,_password,_email)
            RETURNING id into new_id;

            return new_id;
        END;
$$;


ALTER FUNCTION public.sp_insert_users(_username text, _password text, _email text) OWNER TO postgres;

--
-- Name: sp_update_airlines(bigint, text, integer, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_update_airlines(_id bigint, _name text, _country_id integer, _user_id bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
    declare
        rows_count int:=0;
    begin
        WITH rows as (
            UPDATE airlines
            SET name=_name,country_id=_country_id,user_id=_user_id
            WHERE id=_id
            returning 1)
            select count(*) into rows_count from rows;
            return rows_count;
    end;
    $$;


ALTER FUNCTION public.sp_update_airlines(_id bigint, _name text, _country_id integer, _user_id bigint) OWNER TO postgres;

--
-- Name: sp_update_countries(integer, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_update_countries(_id integer, _name text)
    LANGUAGE plpgsql
    AS $$
        BEGIN
            UPDATE countries
            SET name = _name
            WHERE id = _id;
        END;
    $$;


ALTER PROCEDURE public.sp_update_countries(_id integer, _name text) OWNER TO postgres;

--
-- Name: sp_update_customers(bigint, text, text, text, text, bigint, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_update_customers(_id bigint, _first_name text, _last_name text, _address text, _phone_no text, _user_id bigint, _credit_card_no text) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
    declare
        rows_count int:=0;
    begin
        WITH rows as (
            UPDATE customers
            SET first_name=_first_name,last_name=_last_name,address=_address,phone_no=_phone_no,
                user_id=_user_id,credit_card_no=_credit_card_no
            WHERE id=_id
            returning 1)
            select count(*) into rows_count from rows;
            return rows_count;

    end;



    $$;


ALTER FUNCTION public.sp_update_customers(_id bigint, _first_name text, _last_name text, _address text, _phone_no text, _user_id bigint, _credit_card_no text) OWNER TO postgres;

--
-- Name: sp_update_flights(bigint, bigint, integer, integer, timestamp without time zone, timestamp without time zone, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_update_flights(_id bigint, _airline_id bigint, _origin_country_id integer, _destination_country_id integer, _departure_time timestamp without time zone, _landing_time timestamp without time zone, _remaining_tickets integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
    declare
        rows_count int:=0;
    begin
        WITH rows as (
            UPDATE flights
            SET airline_id=_airline_id,origin_country_id=_origin_country_id,destination_country_id=_destination_country_id,
                departure_time=_departure_time,landing_time=_landing_time,remaining_tickets=_remaining_tickets
            WHERE id=_id
            returning 1)
            select count(*) into rows_count from rows;
            return rows_count;
    end;
    $$;


ALTER FUNCTION public.sp_update_flights(_id bigint, _airline_id bigint, _origin_country_id integer, _destination_country_id integer, _departure_time timestamp without time zone, _landing_time timestamp without time zone, _remaining_tickets integer) OWNER TO postgres;

--
-- Name: sp_update_flights_remaining_ticket(bigint, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_update_flights_remaining_ticket(_id bigint, _before_tickets integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
declare
        rows_count int:=0;
    begin
        WITH rows as (
            UPDATE flights
            SET remaining_tickets=_before_tickets-1
            WHERE id=_id
            returning 1)
            select count(*) into rows_count from rows;
            return rows_count;
    end;
$$;


ALTER FUNCTION public.sp_update_flights_remaining_ticket(_id bigint, _before_tickets integer) OWNER TO postgres;

--
-- Name: sp_update_tickets(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_update_tickets(_id bigint, _flight_id bigint, _customer_id bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
    declare
        rows_count int:=0;
    begin
        WITH rows as (
            UPDATE tickets
            SET flight_id=_flight_id,customer_id=_customer_id
            WHERE id=_id
            returning 1)
            select count(*) into rows_count from rows;
            return rows_count;
    end;
    $$;


ALTER FUNCTION public.sp_update_tickets(_id bigint, _flight_id bigint, _customer_id bigint) OWNER TO postgres;

--
-- Name: sp_update_user(bigint, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_update_user(_id bigint, _username text, _password text, _email text) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
        DECLARE
            rows_count int := 0;
        BEGIN
            WITH rows AS (
            UPDATE users
            SET username = _username, password = _password,
                email=_email
            WHERE id = _id
            RETURNING 1)
            select count(*) into rows_count from rows;
            return rows_count;
        END;
    $$;


ALTER FUNCTION public.sp_update_user(_id bigint, _username text, _password text, _email text) OWNER TO postgres;

--
-- Name: sp_upsert_airlines(text, integer, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_upsert_airlines(_name text, _country_id integer, _user_id bigint) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare
        new_id bigint := 0;
    begin
        if not exists(select 1 from airlines where name = _name) then
            insert into airlines (name,country_id,user_id) values (_name,_country_id,_user_id)
            returning id into new_id;
            return new_id;
        else
            update airlines
            set country_id = _country_id,user_id=_user_id
            where name = _name;
            return 0;
        end if;
    end;
    $$;


ALTER FUNCTION public.sp_upsert_airlines(_name text, _country_id integer, _user_id bigint) OWNER TO postgres;

--
-- Name: sp_upsert_users(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_upsert_users(_username text, _password text, _email text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    declare
        new_id bigint := 0;
    begin
        if not exists(select 1 from users where username = _username) then
            insert into users (username, password,email) values (_username,_password,_email)
            returning id into new_id;
            return new_id;
        else
            update users
            set password = _password,email=_email
            where username = _username;
            return 0;
        end if;
    end;
    $$;


ALTER FUNCTION public.sp_upsert_users(_username text, _password text, _email text) OWNER TO postgres;

--
-- Name: airlines_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.airlines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.airlines_id_seq OWNER TO postgres;

--
-- Name: airlines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.airlines_id_seq OWNED BY public.airlines.id;


--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.countries_id_seq OWNER TO postgres;

--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: flights_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flights_id_seq OWNER TO postgres;

--
-- Name: flights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flights_id_seq OWNED BY public.flights.id;


--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tickets_id_seq OWNER TO postgres;

--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: airlines id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.airlines ALTER COLUMN id SET DEFAULT nextval('public.airlines_id_seq'::regclass);


--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: flights id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights ALTER COLUMN id SET DEFAULT nextval('public.flights_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: airlines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.airlines (id, name, country_id, user_id) FROM stdin;
1	Norwegian Air	1	1
2	North Flying	11	2
3	Star Peru	21	3
4	Air France	31	4
5	Air Mekong	41	5
6	Eastern Airlines, LLC	51	6
7	IBS Software Services Americas, Inc.	61	7
8	Ellinair	71	8
9	Shanghai Airlines	81	9
10	Belavia	91	10
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.countries (id, name) FROM stdin;
1	Afghanistan
2	Åland Islands
3	Albania
4	Algeria
5	American Samoa
6	AndorrA
7	Angola
8	Anguilla
9	Antarctica
10	Antigua and Barbuda
11	Argentina
12	Armenia
13	Aruba
14	Australia
15	Austria
16	Azerbaijan
17	Bahamas
18	Bahrain
19	Bangladesh
20	Barbados
21	Belarus
22	Belgium
23	Belize
24	Benin
25	Bermuda
26	Bhutan
27	Bolivia
28	Bosnia and Herzegovina
29	Botswana
30	Bouvet Island
31	Brazil
32	British Indian Ocean Territory
33	Brunei Darussalam
34	Bulgaria
35	Burkina Faso
36	Burundi
37	Cambodia
38	Cameroon
39	Canada
40	Cape Verde
41	Cayman Islands
42	Central African Republic
43	Chad
44	Chile
45	China
46	Christmas Island
47	Cocos (Keeling) Islands
48	Colombia
49	Comoros
50	Congo
51	Congo, The Democratic Republic of the
52	Cook Islands
53	Costa Rica
54	Cote D'Ivoire
55	Croatia
56	Cuba
57	Cyprus
58	Czech Republic
59	Denmark
60	Djibouti
61	Dominica
62	Dominican Republic
63	Ecuador
64	Egypt
65	El Salvador
66	Equatorial Guinea
67	Eritrea
68	Estonia
69	Ethiopia
70	Falkland Islands (Malvinas)
71	Faroe Islands
72	Fiji
73	Finland
74	France
75	French Guiana
76	French Polynesia
77	French Southern Territories
78	Gabon
79	Gambia
80	Georgia
81	Germany
82	Ghana
83	Gibraltar
84	Greece
85	Greenland
86	Grenada
87	Guadeloupe
88	Guam
89	Guatemala
90	Guernsey
91	Guinea
92	Guinea-Bissau
93	Guyana
94	Haiti
95	Heard Island and Mcdonald Islands
96	Holy See (Vatican City State)
97	Honduras
98	Hong Kong
99	Hungary
100	Iceland
101	India
102	Indonesia
103	Iran, Islamic Republic Of
104	Iraq
105	Ireland
106	Isle of Man
107	Israel
108	Italy
109	Jamaica
110	Japan
111	Jersey
112	Jordan
113	Kazakhstan
114	Kenya
115	Kiribati
116	Korea, Democratic People'S Republic of
117	Korea, Republic of
118	Kuwait
119	Kyrgyzstan
120	Lao People'S Democratic Republic
121	Latvia
122	Lebanon
123	Lesotho
124	Liberia
125	Libyan Arab Jamahiriya
126	Liechtenstein
127	Lithuania
128	Luxembourg
129	Macao
130	Macedonia, The Former Yugoslav Republic of
131	Madagascar
132	Malawi
133	Malaysia
134	Maldives
135	Mali
136	Malta
137	Marshall Islands
138	Martinique
139	Mauritania
140	Mauritius
141	Mayotte
142	Mexico
143	Micronesia, Federated States of
144	Moldova, Republic of
145	Monaco
146	Mongolia
147	Montserrat
148	Morocco
149	Mozambique
150	Myanmar
151	Namibia
152	Nauru
153	Nepal
154	Netherlands
155	Netherlands Antilles
156	New Caledonia
157	New Zealand
158	Nicaragua
159	Niger
160	Nigeria
161	Niue
162	Norfolk Island
163	Northern Mariana Islands
164	Norway
165	Oman
166	Pakistan
167	Palau
168	Palestinian Territory, Occupied
169	Panama
170	Papua New Guinea
171	Paraguay
172	Peru
173	Philippines
174	Pitcairn
175	Poland
176	Portugal
177	Puerto Rico
178	Qatar
179	Reunion
180	Romania
181	Russian Federation
182	RWANDA
183	Saint Helena
184	Saint Kitts and Nevis
185	Saint Lucia
186	Saint Pierre and Miquelon
187	Saint Vincent and the Grenadines
188	Samoa
189	San Marino
190	Sao Tome and Principe
191	Saudi Arabia
192	Senegal
193	Serbia and Montenegro
194	Seychelles
195	Sierra Leone
196	Singapore
197	Slovakia
198	Slovenia
199	Solomon Islands
200	Somalia
201	South Africa
202	South Georgia and the South Sandwich Islands
203	Spain
204	Sri Lanka
205	Sudan
206	Suriname
207	Svalbard and Jan Mayen
208	Swaziland
209	Sweden
210	Switzerland
211	Syrian Arab Republic
212	Taiwan, Province of China
213	Tajikistan
214	Tanzania, United Republic of
215	Thailand
216	Timor-Leste
217	Togo
218	Tokelau
219	Tonga
220	Trinidad and Tobago
221	Tunisia
222	Turkey
223	Turkmenistan
224	Turks and Caicos Islands
225	Tuvalu
226	Uganda
227	Ukraine
228	United Arab Emirates
229	United Kingdom
230	United States
231	United States Minor Outlying Islands
232	Uruguay
233	Uzbekistan
234	Vanuatu
235	Venezuela
236	Viet Nam
237	Virgin Islands, British
238	Virgin Islands, U.S.
239	Wallis and Futuna
240	Western Sahara
241	Yemen
242	Zambia
243	Zimbabwe
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, first_name, last_name, address, phone_no, user_id, credit_card_no) FROM stdin;
1	Thresa	Armstrong	Margaritestad,13951 MacGyver Tunnel,United States	+44 848.020.6992	10	6771-8959-7238-4421
2	Lucien	Anderson	Buckridgefort,7217 Noah Viaduct,United States	+502 930.417.7366 x253	11	5156-1517-4155-4481
3	Leanna	Gusikowski	O'Haraville,96660 Chang Stream,United States	+389 (666) 935-5432 x26000	12	6771-8934-1510-1478
4	Daisey	Hermann	Abbottstad,736 Hessel Turnpike,United States	+690 283-649-4801	13	4171809318756
5	Felix	Crist	North Damianland,541 Yost Trace,United States	+30 283.820.3534 x28693	14	6771-8985-4557-3405
6	Robbyn	Auer	East Emilchester,3423 Lilla Lock,United States	+376 1-483-014-4918	15	4858757577637
7	Sung	Rosenbaum	Rathmouth,723 Chin Course,United States	+503 120.407.4220 x615	16	4544051342627
8	Kurt	Fritsch	Tillmanborough,712 Block Branch,United States	+48 1-502-319-0494 x0955	17	5178-3898-4109-3588
9	Merna	Mohr	Spencerchester,873 Elwood Course,United States	+216 1-464-437-4706 x9670	18	5166-3591-9256-4747
10	Mitchel	Watsica	North Jeffrybury,287 Feil Summit,United States	+976 536.465.1464 x9170	19	6771-8982-6607-7966
\.


--
-- Data for Name: flights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flights (id, airline_id, origin_country_id, destination_country_id, departure_time, landing_time, remaining_tickets) FROM stdin;
2	2	189	90	2021-05-19 17:58:58.606	2021-05-19 19:58:58.606	450
3	7	192	158	2021-01-15 16:31:31.058	2021-01-15 18:31:31.058	450
5	2	225	141	2021-07-03 05:41:15.327	2021-07-03 13:41:15.327	450
6	7	145	115	2021-05-09 06:20:31.394	2021-05-09 14:20:31.394	450
8	8	97	93	2021-05-13 09:22:25.364	2021-05-13 10:22:25.364	450
9	1	67	242	2021-07-15 10:10:45.302	2021-07-15 19:10:45.302	450
11	1	235	220	2021-07-13 23:06:18.777	2021-07-14 06:06:18.777	450
12	1	107	104	2021-03-23 15:56:56.643	2021-03-23 18:56:56.643	450
14	7	228	185	2021-07-25 20:04:19.822	2021-07-26 05:04:19.822	450
15	5	208	4	2021-04-07 11:03:13.156	2021-04-07 16:03:13.156	450
17	10	171	90	2021-07-28 02:10:17.574	2021-07-28 07:10:17.574	450
18	3	115	43	2021-08-10 13:03:44.302	2021-08-10 20:03:44.302	450
20	8	204	127	2021-08-02 07:00:49.014	2021-08-02 12:00:49.014	450
21	1	193	126	2021-06-26 04:05:04.234	2021-06-26 14:05:04.234	450
23	8	147	148	2021-07-27 03:59:08.068	2021-07-27 08:59:08.068	450
24	1	239	220	2021-04-06 14:11:38.345	2021-04-07 01:11:38.345	450
26	10	190	97	2021-04-28 16:53:49.736	2021-04-29 01:53:49.736	450
27	1	27	1	2021-02-09 08:45:45.429	2021-02-09 21:45:45.429	450
29	1	172	128	2021-07-04 01:03:41.749	2021-07-04 02:03:41.749	450
30	1	112	166	2021-03-04 00:47:20.921	2021-03-04 05:47:20.921	450
31	1	191	125	2021-05-02 15:21:22.317	2021-05-03 00:21:22.317	450
32	7	130	89	2021-02-03 07:54:29.363	2021-02-03 10:54:29.363	450
33	9	71	96	2021-05-15 00:05:54.177	2021-05-15 07:05:54.177	450
34	5	118	152	2021-03-27 04:38:29.189	2021-03-27 12:38:29.189	450
35	6	121	217	2021-05-12 19:39:49.422	2021-05-13 01:39:49.422	450
36	8	217	176	2021-01-21 02:31:01.164	2021-01-21 15:31:01.164	450
37	1	229	177	2021-02-04 22:58:55.125	2021-02-05 12:58:55.125	450
38	9	240	140	2021-04-02 19:36:37.74	2021-04-03 00:36:37.74	450
39	5	36	183	2021-02-08 16:56:10.155	2021-02-09 00:56:10.155	450
40	1	36	19	2021-06-08 09:30:22.816	2021-06-08 11:30:22.816	450
41	5	192	120	2021-02-27 00:34:42.457	2021-02-27 10:34:42.457	450
42	7	154	171	2021-07-16 13:53:42.855	2021-07-16 18:53:42.855	450
43	4	228	87	2021-01-01 11:41:58.421	2021-01-02 01:41:58.421	450
44	7	52	78	2021-07-08 01:26:19.157	2021-07-08 11:26:19.157	450
45	5	109	136	2021-04-20 08:05:57.166	2021-04-20 20:05:57.166	450
46	10	8	27	2021-04-23 19:34:19.008	2021-04-24 08:34:19.008	450
47	1	238	204	2021-06-15 05:07:46.024	2021-06-15 14:07:46.024	450
48	6	236	111	2021-03-12 00:57:17.592	2021-03-12 03:57:17.592	450
49	5	123	198	2021-08-02 11:51:58.496	2021-08-02 19:51:58.496	450
50	5	241	71	2021-03-17 22:05:08.331	2021-03-18 00:05:08.331	450
1	5	80	25	2021-06-16 22:25:55.755	2021-06-17 07:25:55.755	449
4	4	173	163	2021-05-13 23:44:32.174	2021-05-14 07:44:32.174	449
7	3	212	52	2021-07-06 16:44:11.996	2021-07-07 05:44:11.996	449
10	8	93	233	2021-04-15 14:18:52.589	2021-04-16 03:18:52.589	449
13	1	223	20	2021-07-25 21:39:04.879	2021-07-26 05:39:04.879	449
19	7	231	85	2021-02-18 02:20:00.875	2021-02-18 07:20:00.875	449
16	3	93	42	2021-03-16 01:06:18.854	2021-03-16 13:06:18.854	449
22	10	42	155	2021-07-16 22:03:53.386	2021-07-17 12:03:53.386	449
25	4	204	43	2021-01-15 17:02:34.954	2021-01-15 18:02:34.954	449
28	9	62	94	2021-08-17 21:09:26.896	2021-08-18 08:09:26.896	449
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickets (id, flight_id, customer_id) FROM stdin;
1	1	1
2	4	2
3	7	3
4	10	4
5	13	5
6	16	6
7	19	7
8	22	8
9	25	9
10	28	10
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password, email) FROM stdin;
1	angryostrich988	r2d2	louane.vidal@example.com
2	angryduck156	0101	don.white@example.com
3	orangepanda844	wonderboy	loan.lucas@example.com
4	whitebutterfly474	shonuf	arno.brun@example.com
5	smallzebra743	0007	aubrey.martin@example.com
6	goldenpeacock890	141414	julia.smith@example.com
7	bigdog376	scooby	guro.rostad@example.com
8	tinykoala661	christin	katarina.mostad@example.com
9	tinydog827	bigballs	aada.heinonen@example.com
10	greencat124	mememe	eeli.kivisto@example.com
11	greenostrich463	carla	tindra.klavenes@example.com
12	purplesnake302	thrasher	francis.garnier@example.com
13	lazytiger529	hardball	jonas.legrand@example.com
14	heavyfish660	temp123	rachel.hughes@example.com
15	lazybird338	airplane	louise.perkins@example.com
16	blackbear771	talk	megan.jensen@example.com
17	ticklishfish230	micro	ali.karadas@example.com
18	organicdog519	blanco	owen.morin@example.com
19	goldenleopard560	franklin	niilo.autio@example.com
20	biggorilla496	crew	bajram.caron@example.com
\.


--
-- Name: airlines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.airlines_id_seq', 10, true);


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.countries_id_seq', 243, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 10, true);


--
-- Name: flights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flights_id_seq', 50, true);


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tickets_id_seq', 10, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 20, true);


--
-- Name: airlines airlines_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.airlines
    ADD CONSTRAINT airlines_pk PRIMARY KEY (id);


--
-- Name: countries countries_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pk PRIMARY KEY (id);


--
-- Name: customers customers_first_name_last_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_first_name_last_name_key UNIQUE (first_name, last_name);


--
-- Name: customers customers_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pk PRIMARY KEY (id);


--
-- Name: flights flights_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_pk PRIMARY KEY (id);


--
-- Name: tickets tickets_flight_id_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_flight_id_customer_id_key UNIQUE (flight_id, customer_id);


--
-- Name: tickets tickets_flight_id_customer_id_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_flight_id_customer_id_key1 UNIQUE (flight_id, customer_id);


--
-- Name: tickets tickets_flight_id_customer_id_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_flight_id_customer_id_key2 UNIQUE (flight_id, customer_id);


--
-- Name: tickets tickets_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pk PRIMARY KEY (id);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: airlines_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX airlines_name_uindex ON public.airlines USING btree (name);


--
-- Name: airlines_user_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX airlines_user_id_uindex ON public.airlines USING btree (user_id);


--
-- Name: countries_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX countries_name_uindex ON public.countries USING btree (name);


--
-- Name: customers_credit_card_no_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX customers_credit_card_no_uindex ON public.customers USING btree (credit_card_no);


--
-- Name: customers_phone_no_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX customers_phone_no_uindex ON public.customers USING btree (phone_no);


--
-- Name: customers_user_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX customers_user_id_uindex ON public.customers USING btree (user_id);


--
-- Name: tickets_customer_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tickets_customer_id_uindex ON public.tickets USING btree (customer_id);


--
-- Name: tickets_flight_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tickets_flight_id_uindex ON public.tickets USING btree (flight_id);


--
-- Name: users_email_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_uindex ON public.users USING btree (email);


--
-- Name: users_username_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_username_uindex ON public.users USING btree (username);


--
-- Name: airlines airlines_country_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.airlines
    ADD CONSTRAINT airlines_country_id_fk FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- Name: airlines airlines_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.airlines
    ADD CONSTRAINT airlines_user_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: customers customers_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_user_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: flights flights___origin_country_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights___origin_country_id_fk FOREIGN KEY (origin_country_id) REFERENCES public.countries(id);


--
-- Name: flights flights_airlines_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_airlines_id_fk FOREIGN KEY (airline_id) REFERENCES public.airlines(id);


--
-- Name: flights flights_destination_country_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_destination_country_id_fk FOREIGN KEY (destination_country_id) REFERENCES public.countries(id);


--
-- Name: tickets tickets_customer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_customer_id_fk FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: tickets tickets_flight_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_flight_id_fk FOREIGN KEY (flight_id) REFERENCES public.flights(id);


--
-- PostgreSQL database dump complete
--

