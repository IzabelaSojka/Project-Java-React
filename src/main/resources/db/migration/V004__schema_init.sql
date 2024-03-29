BEGIN;


ALTER TABLE public.game
    ALTER COLUMN id TYPE integer;

ALTER TABLE public.game ALTER COLUMN id
    ADD GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1000 );

ALTER TABLE public.game
    ALTER COLUMN name TYPE character varying(200);
ALTER TABLE public.game
    ADD COLUMN board_id integer;
ALTER TABLE public.game
    ADD COLUMN winner_user_id integer;

CREATE TABLE IF NOT EXISTS public.board
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1000 ),
    name character varying(200) NOT NULL,
    max_players smallint NOT NULL,
    number_of_fields smallint NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.pawn
(
    "number" smallint NOT NULL,
    progress smallint NOT NULL,
    user_id integer NOT NULL,
    game_id integer NOT NULL,
    PRIMARY KEY (user_id, game_id, "number")
);

CREATE TABLE IF NOT EXISTS public."user"
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1000 ),
    nickname character varying(200) NOT NULL,
    full_name character varying(200),
    profile_picture bytea,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.user_game
(
    user_id integer NOT NULL,
    game_id integer NOT NULL,
    player_colour character varying(50) NOT NULL,
    PRIMARY KEY (user_id, game_id)
);

CREATE TABLE IF NOT EXISTS public.user_friend
(
    first_user_id integer NOT NULL,
    second_user_id integer NOT NULL,
    PRIMARY KEY (first_user_id, second_user_id)
);

CREATE TABLE IF NOT EXISTS public.user_game_invite
(
    inviting_user_id integer NOT NULL,
    invited_user_id integer NOT NULL,
    game_id integer NOT NULL,
    PRIMARY KEY (inviting_user_id, invited_user_id, game_id)
);

CREATE TABLE IF NOT EXISTS public.user_friend_invite
(
    inviting_user_id integer NOT NULL,
    invited_user_id integer NOT NULL,
    PRIMARY KEY (inviting_user_id, invited_user_id)
);

ALTER TABLE IF EXISTS public.game
    ADD FOREIGN KEY (board_id)
        REFERENCES public.board (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;


ALTER TABLE IF EXISTS public.game
    ADD FOREIGN KEY (winner_user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;


ALTER TABLE IF EXISTS public.pawn
    ADD FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;


ALTER TABLE IF EXISTS public.pawn
    ADD FOREIGN KEY (game_id)
        REFERENCES public.game (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;


ALTER TABLE IF EXISTS public.user_game
    ADD FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;


ALTER TABLE IF EXISTS public.user_game
    ADD FOREIGN KEY (game_id)
        REFERENCES public.game (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;


ALTER TABLE IF EXISTS public.user_friend
    ADD FOREIGN KEY (first_user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;


ALTER TABLE IF EXISTS public.user_friend
    ADD FOREIGN KEY (second_user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;


ALTER TABLE IF EXISTS public.user_game_invite
    ADD FOREIGN KEY (inviting_user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;


ALTER TABLE IF EXISTS public.user_game_invite
    ADD FOREIGN KEY (invited_user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;


ALTER TABLE IF EXISTS public.user_game_invite
    ADD FOREIGN KEY (game_id)
        REFERENCES public.game (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;


ALTER TABLE IF EXISTS public.user_friend_invite
    ADD FOREIGN KEY (inviting_user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;


ALTER TABLE IF EXISTS public.user_friend_invite
    ADD FOREIGN KEY (invited_user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID;

END;