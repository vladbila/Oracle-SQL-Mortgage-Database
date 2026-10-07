-- Query 1: Retrieve the name, personal identification number (CNP), and phone number of clients who have registered at least one loan file for a banking product in 'EUR'
SELECT c.nume, c.cnp, c.telefon
FROM CLIENT c
WHERE EXISTS (
    SELECT 1
    FROM DOSAR_CREDIT d
    JOIN PRODUS_BANCAR p ON d.id_produs = p.id_produs
    WHERE d.id_client = c.id_client
      AND p.moneda = 'EUR'
);

-- Query 2: Retrieve clients whose net income exceeds the bank's overall average
SELECT c.nume, c.venit_net, ROUND(m.medie_venituri, 2) AS "Media Bancii"
FROM CLIENT c,
    (SELECT AVG(venit_net) AS medie_venituri FROM CLIENT WHERE venit_net IS NOT NULL) m
WHERE c.venit_net > m.medie_venituri;

-- Query 3: Using the WITH clause to retrieve valid clients, display the net income and the number of clients for the income group that registers the maximum number of clients across the entire bank
WITH Date_Clienti AS (
    SELECT id_client, venit_net
    FROM CLIENT
    WHERE venit_net IS NOT NULL
)
SELECT venit_net AS "Venit Net",
    COUNT(id_client) AS "Numar Clienti"
FROM Date_Clienti
GROUP BY venit_net
HAVING COUNT(id_client) = (
    SELECT MAX(COUNT(id_client))
    FROM CLIENT
    GROUP BY venit_net
);

-- Query 4: Display alphabetically the names of clients who have loan files, along with their net income (displaying 0 if the income is null) and the full name of the banking product's currency (using the DECODE function to transform 'EUR' to 'Euro' and 'LEI' to 'Lei'). The results will be ordered in ascending order by client name.
SELECT c.nume,
    NVL(c.venit_net, 0) AS "Venit Net",
    DECODE(p.moneda, 'EUR', 'Euro', 'LEI', 'Lei') AS "Tip Moneda"
FROM CLIENT c
JOIN DOSAR_CREDIT d ON c.id_client = d.id_client
JOIN PRODUS_BANCAR p ON d.id_produs = p.id_produs
ORDER BY c.nume ASC;

-- Query 5: Display the clients' names in uppercase and the first 3 digits of their CNP. For their loan files, extract the application year and calculate the age in months from the application date to the present. Also, using a CASE expression, classify the applications as 'Current Year Application' if they were submitted in the current year, or 'Previous Year Application' otherwise.
SELECT UPPER(c.nume) AS "Nume Client",
    SUBSTR(c.cnp, 1, 3) AS "Inceput CNP",
    EXTRACT(YEAR FROM d.data_cerere) AS "An Cerere",
    ROUND(MONTHS_BETWEEN(SYSDATE, d.data_cerere)) AS "Vechime Luni",
    CASE
        WHEN EXTRACT(YEAR FROM d.data_cerere) = EXTRACT(YEAR FROM SYSDATE) THEN 'Cerere An Curent'
        ELSE 'Cerere An Anterior'
        END AS "Status Cerere"
FROM CLIENT c
JOIN DOSAR_CREDIT d ON c.id_client = d.id_client;
