CREATE EXTENSION pgcrypto;
SELECT gen_random_uuid();

CREATE TABLE IF NOT EXISTS Details(
    id    UUID  PRIMARY  KEY DEFAULT gen_random_uuid(),
    firstname    varchar(30) not null,
    lastname varchar(250) not null,
    email varchar (30) not null,
    is_banned BOOLEAN not null
    );

INSERT INTO Details(firstname,lastname,email,is_baned)
values ( 'Adam', 'Pawlak','adampawlak@wp.pl',false);
INSERT INTO Details(firstname,lastname,email,is_baned)
values ('Mieczysław', 'Grab','mieczyslawgrab@wp.pl',true);

CREATE TABLE IF NOT EXISTS Users(
    id    UUID  PRIMARY  KEY DEFAULT gen_random_uuid(),
    nick    VARCHAR(30) NOT NULL ,
    password VARCHAR(200) not null,
    details_id UUID not null,
    UNIQUE(nick),
    constraint fk_details
        foreign key(details_id)
            references Details(id)
    );
INSERT INTO Users (nick,password,details_id)
values ('Adam', 'password123', (select id from Details where firstname ='Adam'));
INSERT INTO Users (nick,password,details_id)
values ('Mieczyslaw', 'password123', (select id from Details where firstname ='Mieczysław'));

CREATE TABLE IF NOT EXISTS Friend(
    id    UUID  PRIMARY  KEY DEFAULT gen_random_uuid(),
    user_id    UUID not null,
    friend_id UUID not null,
    constraint fk_user_details
        foreign key(user_id)
            references Users(id),
    constraint fk_friend_details
        foreign key(friend_id)
            references Users(id)
    );

INSERT INTO Friend (user_id,friend_id)
values ((select id from Users where nick ='Mieczyslaw'), (select id from Users where nick ='Adam'));
values ( (select id from Users where nick ='Adam'),(select id from Users where nick ='Mieczyslaw'));