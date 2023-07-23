-- Keep a log of any SQL queries you execute as you solve the mystery.
-- checks to see what's going on
schema
table
-- Did many repeated querries to find information that was not all documented on here, but notes were made under each suspects name to show the information was gathered
select activity from bakery_security_logs;
select name from people;
select amount from atm_transactions
--Date: July 28
--Humphrey Street
select description from crime_scene_reports where street like "%humphrey street%" and month = 7 and day = 28;
select name, transcript from interviews where transcript like "%bakery%";
select license_plate from bakery_security_logs where hour = 10 and 15 < minute < 25 and day = 28 and month = 7;
--Ruth, Eugene, Raymond, Kiana
-- Richard, Leggett Street, Earliest Flight, Within 10 minutes of the robbery, car drove away, 10:15
select people.name from people
join bakery_security_logs on people.license_plate = bakery_security_logs.license_plate
where bakery_security_logs.hour = 10 and 15 < bakery_security_logs.minute < 25 and bakery_security_logs.day = 28 and bakery_security_logs.month = 7;

-- Brandon Sophia Vanessa Bruce Barry Luca Sofia Iman Diana Kelsey Taylor Denise Thomas Jeremy
select interviews.name, interviews.transcript from interviews
join bakery_security_logs on people.license_plate = bakery_security_logs.license_plate
join people on people.name = interviews.name
where interviews.name in
(select people.name from people where bakery_security_logs.hour = 10 and 15 < bakery_security_logs.minute < 25 and bakery_security_logs.day = 28 and bakery_security_logs.month = 7);
-- Got all IDs from names using:
select name, id from people where name = "Name";

select account_number from bank_accounts
join people on bank_accounts.person_id = people.id
where people.id = 514354;

select phone_number from people
where name = "NAME"

select * from phone_calls where caller = "(771) 555-6667" or receiver = "(771) 555-6667";

select * from phone_calls where month = 7 and day = 28 and ( duration < 70) and caller = "(286) 555-6063";
/*SUSPECTS
Sophia- 745650, AN - 42445987, PHN: (027) 555-1068, Pass - 3642612721
    - 5 phone calls, 3 calling, 2 recieving
    - Flights = 6, 31, 43
    - No withdrawel
    +----------------------+------------------+--------+
|     atm_location     | transaction_type | amount |
+----------------------+------------------+--------+
| Carvalho Road        | deposit          | 75     |
| Humphrey Lane        | deposit          | 100    |
| Carvalho Road        | withdraw         | 65     |
| Daboin Sanchez Drive | withdraw         | 80     |
| Leggett Street       | deposit          | 55     |
| Humphrey Lane        | withdraw         | 75     |
| Daboin Sanchez Drive | withdraw         | 55     |
| Blumberg Boulevard   | withdraw         | 80     |
+----------------------+------------------+--------+
Thomas - 660982, AN - ??None??, PHN: (286) 555-0131, Pass - 6034823042
    - 6 phone calls, 3 calling, 3 recieving (One from Bruce)
    -Flights 16, 20, 53, 58
    -No withdrawel
Bruce- 686048, AN - 49610011, PHN: (367) 555-5533, Pass - 5773159633
    - Lots of calls 13. 11 calling 2 recieving
    - Flights - 36 (No return flight?)
    - Withdrawel from Legget Street
    - Made a short call on the right day to "Robin"
    - Flew from FiftyVille to NYC the da after crime
     Two withdrawls from leggett street of 10 and 50
Jeremy - 748674, AN - 16113845, PHN: (194) 555-5027, Pass - 1207566299
    - 6 calls 3 in 3 out
    - No withdrawel
    -Flights - 4, 27, 41
    |     atm_location     | transaction_type | amount |
+----------------------+------------------+--------+
| Blumberg Boulevard   | withdraw         | 5      |
| Daboin Sanchez Drive | withdraw         | 55     |
| Humphrey Lane        | withdraw         | 75     |
| Blumberg Boulevard   | deposit          | 20     |
| Humphrey Lane        | withdraw         | 95     |
| Carvalho Road        | withdraw         | 60     |
| Daboin Sanchez Drive | deposit          | 80     |
| Blumberg Boulevard   | deposit          | 40     |
| Humphrey Lane        | withdraw         | 65     |
| Humphrey Lane        | withdraw         | 35     |
| Leggett Street       | deposit          | 80     |
+----------------------+------------------+--------+
Diana - 514354, AN - 26013199, PHN: (770) 555-1861, Pass - 3592750733
    -  7 calls, 4 out 3 in
    -Flights - 18, 24, 54
    No withdrawel
      atm_location  | transaction_type | amount |
+----------------+------------------+--------+
| Leggett Street | deposit          | 55     |
| Leggett Street | withdraw         | 35     |

Other Possible:

They werent interviewed??
            ID      PHONE               PASS            LICENSE
Brandon: 325548 | (771) 555-6667 | 7874488539      | R3G7486 | Bank - 86850293

+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 200 | (771) 555-6667 | (168) 555-6126 | 2021 | 7     | 27  | 169      |
| 337 | (771) 555-6667 | (918) 555-5327 | 2021 | 7     | 29  | 498      |
| 352 | (601) 555-6795 | (771) 555-6667 | 2021 | 7     | 29  | 571      |
| 405 | (420) 555-5821 | (771) 555-6667 | 2021 | 7     | 30  | 312      |
| 454 | (771) 555-6667 | (190) 555-4928 | 2021 | 7     | 30  | 273      |
| 464 | (786) 555-5321 | (771) 555-6667 | 2021 | 7     | 31  | 200      |
+-----+----------------+----------------+------+-------+-----+----------+

Vanessa: 221103 | (725) 555-4692 | 2963008352      | 5P2BI95
 id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 64  | (725) 555-4692 | (604) 555-0153 | 2021 | 7     | 25  | 528      |
| 257 | (725) 555-4692 | (821) 555-5262 | 2021 | 7     | 28  | 456      |
| 334 | (911) 555-0229 | (725) 555-4692 | 2021 | 7     | 29  | 296      |
| 371 | (035) 555-2997 | (725) 555-4692 | 2021 | 7     | 29  | 113      |
| 390 | (356) 555-6641 | (725) 555-4692 | 2021 | 7     | 30  | 224      |
| 502 | (725) 555-4692 | (962) 555-5827 | 2021 | 7     | 31  | 272      |

Barry: 243696 | (301) 555-4174 | 7526138472      | 6P58WS2 | Bank - 56171033
+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 2   | (741) 555-1748 | (301) 555-4174 | 2021 | 7     | 25  | 350      |
| 70  | (301) 555-4174 | (994) 555-3373 | 2021 | 7     | 25  | 125      |
| 230 | (301) 555-4174 | (711) 555-3007 | 2021 | 7     | 28  | 583      |
| 323 | (544) 555-8087 | (301) 555-4174 | 2021 | 7     | 29  | 419      |
| 378 | (301) 555-4174 | (394) 555-3247 | 2021 | 7     | 30  | 432      |
| 490 | (604) 555-0153 | (301) 555-4174 | 2021 | 7     | 31  | 250      |
+-----+----------------+----------------+------+-------+-----+----------+

Luca: 467400 | (389) 555-5198 | 8496433585      | 4328GD8 | 28500762 - Made withdrawel
+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 57  | (389) 555-5198 | (368) 555-3561 | 2021 | 7     | 25  | 414      |
| 227 | (544) 555-8087 | (389) 555-5198 | 2021 | 7     | 28  | 595      |
| 234 | (609) 555-5876 | (389) 555-5198 | 2021 | 7     | 28  | 60       |
| 326 | (389) 555-5198 | (609) 555-5876 | 2021 | 7     | 29  | 397      |
| 408 | (609) 555-5876 | (389) 555-5198 | 2021 | 7     | 30  | 255      |
+-----+----------------+----------------+------+-------+-----+----------+

Sofia: 398010 | (130) 555-0289 | 1695452385      | G412CB7

| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 85  | (130) 555-0289 | (730) 555-5115 | 2021 | 7     | 26  | 422      |
| 120 | (491) 555-2505 | (130) 555-0289 | 2021 | 7     | 26  | 381      |
| 182 | (130) 555-0289 | (042) 555-1772 | 2021 | 7     | 27  | 273      |
| 221 | (130) 555-0289 | (996) 555-8899 | 2021 | 7     | 28  | 51       |
| 320 | (821) 555-5262 | (130) 555-0289 | 2021 | 7     | 29  | 263      |
| 444 | (258) 555-5627 | (130) 555-0289 | 2021 | 7     | 30  | 160      |
| 501 | (130) 555-0289 | (427) 555-0556 | 2021 | 7     | 31  | 458      |


Iman: 396669 | (829) 555-5269 | 7049073643      | L93JTIZ | Bank - 25506511 Made Withdrawel

+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 145 | (321) 555-6083 | (829) 555-5269 | 2021 | 7     | 26  | 77       |
| 345 | (829) 555-5269 | (286) 555-0131 | 2021 | 7     | 29  | 337      |
| 367 | (328) 555-1152 | (829) 555-5269 | 2021 | 7     | 29  | 302      |
| 442 | (829) 555-5269 | (022) 555-4052 | 2021 | 7     | 30  | 232      |
| 462 | (243) 555-7229 | (829) 555-5269 | 2021 | 7     | 31  | 78       |
| 465 | (829) 555-5269 | (367) 555-0409 | 2021 | 7     | 31  | 412      |
+-----+----------------+----------------+------+-------+-----+----------+


Kelsey: 560886 | (499) 555-9472 | 8294398571      | 0NTHK55

+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 73  | (499) 555-9472 | (770) 555-1861 | 2021 | 7     | 25  | 317      |
| 115 | (704) 555-2131 | (499) 555-9472 | 2021 | 7     | 26  | 221      |
| 140 | (831) 555-0973 | (499) 555-9472 | 2021 | 7     | 26  | 118      |
| 224 | (499) 555-9472 | (892) 555-8872 | 2021 | 7     | 28  | 36       |
| 251 | (499) 555-9472 | (717) 555-1342 | 2021 | 7     | 28  | 50       |
| 424 | (499) 555-9472 | (996) 555-8899 | 2021 | 7     | 30  | 506      |
| 478 | (499) 555-9472 | (020) 555-6715 | 2021 | 7     | 31  | 102      |
+-----+----------------+----------------+------+-------+-----+----------+

Taylor: 449774 : (286) 555-6063 | 1988161715      | 1106N58 | Bank - 76054385 - Made withdrawel
Made call that matches
Flew from origin airport 8 to desination 4
+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 31  | (771) 555-7880 | (286) 555-6063 | 2021 | 7     | 25  | 119      |
| 32  | (487) 555-5865 | (286) 555-6063 | 2021 | 7     | 25  | 199      |
| 46  | (286) 555-6063 | (789) 555-8833 | 2021 | 7     | 25  | 125      |
| 97  | (060) 555-2489 | (286) 555-6063 | 2021 | 7     | 26  | 371      |
| 254 | (286) 555-6063 | (676) 555-6554 | 2021 | 7     | 28  | 43       |
| 284 | (286) 555-6063 | (310) 555-8568 | 2021 | 7     | 28  | 235      |
| 451 | (286) 555-6063 | (344) 555-9601 | 2021 | 7     | 30  | 154      |
+-----+----------------+----------------+------+-------+-----+----------+

Denise: 652412 | (994) 555-3373 | 4001449165      | NRYN856 | Bank - 58552019


+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 70  | (301) 555-4174 | (994) 555-3373 | 2021 | 7     | 25  | 125      |
| 106 | (452) 555-8550 | (994) 555-3373 | 2021 | 7     | 26  | 48       |
| 172 | (994) 555-3373 | (328) 555-9658 | 2021 | 7     | 27  | 600      |
| 183 | (994) 555-3373 | (027) 555-1068 | 2021 | 7     | 27  | 194      |
| 296 | (994) 555-3373 | (260) 555-0610 | 2021 | 7     | 29  | 281      |
| 379 | (738) 555-2050 | (994) 555-3373 | 2021 | 7     | 30  | 491      |
*/
/*
| Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
| I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
| As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |
| I saw Richard take a bite out of his pastry at the bakery before his pastry was stolen from him.

*/
/*



CREATE TABLE crime_scene_reports (
    id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    street TEXT,
    description TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE interviews (
    id INTEGER,
    name TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    transcript TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE atm_transactions (
    id INTEGER,
    account_number INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    atm_location TEXT,
    transaction_type TEXT,
    amount INTEGER,
    PRIMARY KEY(id)
);
CREATE TABLE bank_accounts (
    account_number INTEGER,
    person_id INTEGER,
    creation_year INTEGER,
    FOREIGN KEY(person_id) REFERENCES people(id)
);
CREATE TABLE airports (
    id INTEGER,
    abbreviation TEXT,
    full_name TEXT,
    city TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE flights (
    id INTEGER,
    origin_airport_id INTEGER,
    destination_airport_id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    minute INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(origin_airport_id) REFERENCES airports(id),
    FOREIGN KEY(destination_airport_id) REFERENCES airports(id)
);
CREATE TABLE passengers (
    flight_id INTEGER,
    passport_number INTEGER,
    seat TEXT,
    FOREIGN KEY(flight_id) REFERENCES flights(id)
);
CREATE TABLE phone_calls (
    id INTEGER,
    caller TEXT,
    receiver TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    duration INTEGER,
    PRIMARY KEY(id)
);
CREATE TABLE people (
    id INTEGER,
    name TEXT,
    phone_number TEXT,
    passport_number INTEGER,
    license_plate TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE bakery_security_logs (
    id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    minute INTEGER,
    activity TEXT,
    license_plate TEXT,
    PRIMARY KEY(id)










*/
