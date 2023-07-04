-- Keep a log of any SQL queries you execute as you solve the mystery.

SELECT description FROM crime_scene_reports WHERE year = 2021 AND month = 7 AND day = 28;
SELECT transcript FROM interviews WHERE year = 2021 AND month = 7 AND day = 28 AND transcript LIKE "%bakery%";
SELECT name FROM interviews WHERE year = 2021 AND month = 7 AND day = 28 AND transcript LIKE "%bakery%";
--  name  Ruth    |Eugene  |Raymond
--SELECT license_plate FROM people WHERE name = "Ruth" AND name = "Eugene" AND name = "Raymond";
SELECT bakery_security_logs.license_plate, bakery_security_logs.activity, people.name FROM bakery_security_logs
JOIN people ON people.license_plate = bakery_security_logs.license_plate
WHERE bakery_security_logs.year = 2021
AND bakery_security_logs.month = 7
AND bakery_security_logs.day = 28
AND bakery_security_logs.hour = 10
AND bakery_security_logs.minute >= 15
AND bakery_security_logs.minute <= 25;


SELECT transaction_type, people.name FROM atm_transactions
JOIN bank_accounts ON bank_accounts.account_number = atm_transactions.account_number
JOIN people ON people.id = bank_accounts.person_id
WHERE atm_transactions.year = 2021
AND atm_transactions.month = 7
AND atm_transactions.day = 28
AND atm_transactions.atm_location = "Leggett Street"
AND atm_transactions.transaction_type LIKE "withdraw";

SELECT caller, people.name FROM phone_calls
JOIN people ON phone_calls.caller = people.phone_number
WHERE year = 2021
AND month = 7
AND day = 28
AND duration < 60;

SELECT receiver, people.name FROM phone_calls
JOIN people ON phone_calls.receiver = people.phone_number
WHERE year = 2021
AND month = 7
AND day = 28
AND duration < 60;

SELECT id, hour, minute, origin_airport_id, destination_airport_id FROM flights
WHERE year = 2021
AND month = 7
AND day = 29
ORDER BY hour ASC;

SELECT id, hour, minute, origin_airport_id, destination_airport_id FROM flights
WHERE year = 2021
AND month = 7
AND day = 29
ORDER BY hour ASC
LIMIT 1;

SELECT city FROM airports
WHERE id = 8;

SELECT city FROM airports
WHERE id = 4;

SELECT flights.destination_airport_id, name, phone_number,license_plate
FROM people
JOIN passengers ON passengers.passport_number = people.passport_number
JOIN flights ON flights.id = passengers.flight_id
WHERE flights.id = 36
ORDER BY flights.hour ASC;

SELECT name FROM people
JOIN passengers ON passengers.passport_number = people.passport_number
JOIN flights ON flights.id = passengers.flight_id
WHERE(
    flights.id = 36
    AND flights.year = 2021
    AND flights.month = 7
    AND flights.day = 29)
AND name IN (
    SELECT people.name FROM phone_calls
    JOIN people ON phone_calls.caller = people.phone_number
    WHERE year = 2021
    AND month = 7
    AND day = 28
    AND duration < 60
)
AND name IN (
    SELECT people.name FROM atm_transactions
    JOIN bank_accounts ON bank_accounts.account_number = atm_transactions.account_number
    JOIN people ON people.id = bank_accounts.person_id
    WHERE atm_transactions.year = 2021
    AND atm_transactions.month = 7
    AND atm_transactions.day = 28
    AND atm_transactions.atm_location = "Leggett Street"
    AND atm_transactions.transaction_type LIKE "withdraw"
)
AND name IN(
    SELECT people.name FROM bakery_security_logs
    JOIN people ON people.license_plate = bakery_security_logs.license_plate
    WHERE bakery_security_logs.year = 2021
    AND bakery_security_logs.month = 7
    AND bakery_security_logs.day = 28
    AND bakery_security_logs.hour = 10
    AND bakery_security_logs.minute >= 15
    AND bakery_security_logs.minute <= 25);
