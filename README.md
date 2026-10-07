#  Oracle SQL Mortgage Credit Management System

A relational database system designed in **Oracle SQL** to manage the lifecycle of mortgage loans, client portfolios, banking branches, and real estate valuations. 

##  System Architecture & Schema
The database models a real-world banking environment using **14 interconnected tables** with strict relational integrity (Primary, Foreign, and Composite Keys).
* **Core Entities:** `CLIENT`, `DOSAR_CREDIT` (Loan File), `PRODUS_BANCAR` (Bank Product), `IMOBIL` (Real Estate Asset), and `SUCURSALA` (Branch).
* **Specialized Employee Roles:** Utilizes a supertype/subtype architecture for `ANGAJAT` (Employee), branching into `OFITER_CREDIT` (Credit Officer), `ANALIST_RISC` (Risk Analyst), and `EVALUATOR` (Appraiser).
* **Complex Relationships:** Implements ternary relationships (Associating a Loan, a Service, and an Insurance Provider via `POLITA_ASIGURARE`), many-to-many associative entities (`EVALUARE_IMOBIL`), and recursive relationships to track loan refinancing.
* **Normalization:** The schema is fundamentally designed around the Third Normal Form (3NF) to eliminate data anomalies and ensure efficient data storage.

##  Technical Implementation
* **DDL & Constraints:** Engineered robust domain constraints (`CHECK`, `UNIQUE`, `DEFAULT`, `NOT NULL`) to maintain business logic at the database level.
* **Automated Keys:** Utilized `CREATE SEQUENCE` for automated primary key generation across all tables.
* **Analytical Reporting (Read):** Developed complex `SELECT` queries utilizing Common Table Expressions (`WITH` clauses), inline views, multi-table `JOIN` operations, aggregate functions, `DECODE`, and `CASE` statements to extract business intelligence.
* **Data Modification (Update/Delete):** Implemented targeted `UPDATE` and `DELETE` operations using subqueries to handle dynamic record modifications (e.g., bulk loan approvals based on income thresholds).

##  Repository Contents
* `database_setup.sql`: The complete Oracle SQL script containing all table creations, data insertions, and analytical queries.
* `er_diagram.png`: The Entity-Relationship diagram defining system cardinality.
* `conceptual_schema.png`: The detailed conceptual UML mapping.
