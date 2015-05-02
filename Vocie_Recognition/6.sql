
Insert into Students(SID,Name,Address)
values('S011','Rong Zheng',Null);

Select *
from students;

Create Table client(
	clientID INT NOT NULL,
    name VARCHAR(45) NULL,
    Age INT NULL,
    PRIMARY KEY (clientID));

INSERT INTO client(clientID, name, age) values (1,'client1',21);

INSERT INTO client(clientID, name, age) values (3,'client3',18);

Delimiter $$
Create TRIGGER client_trigger
BEFORE INSERT ON client
FOR EACH ROW
BEGIN
DECLARE msg varchar(100);
	IF (NEW.age < 18) THEN
		/*UPDATE students s set s.address='Ruston';*/
		Set msg= 'Error: Invalid age of client';
        signal sqlstate '45000' set message_text = msg;
	END IF;
END $$

DELIMITER ;

INSERT INTO client(clientID, name, age) values (8,'client3',17);

Drop trigger client_trigger;
select *
from client;

Create Table users(
	username varchar(45) not null,
    email varchar(45) null,
    password varchar(45) null,
    primary key (username,email));

Create Table users_logs(
	username varchar(45) not null,
    oldpassword varchar(45) null,
    newpassword varchar(45) null);

insert into users values('user1','user1@mail.com',123);


DELIMITER $$
Create trigger users_trigger
After update on users
for each row
begin
	if(new.password<>old.password)then
		insert into users_logs values(new.username, old.password, new.password);
	end if;
end $$
delimiter ;


drop trigger users_trigger;


update users set password='475' where username='user1';

select *
from users_logs;

