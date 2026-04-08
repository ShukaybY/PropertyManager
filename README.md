# Property & Expense Management System

A relational database project built with **MariaDB 10.6+** that tracks rental properties, expenses, and income then surfaces business insights through analytical SQL queries.

> Built as a portfolio project to demonstrate real-world SQL skills in a domain directly connected to real estate and financial data management.

---

## Project Structure

```
MariaDB_Property/
├── schema.sql                         
├── sample_data.sql                   
├── sample_data.csv                    
├── queries.sql                        
├── export_reports.sql                 
├── property_net_profit.csv            
├── monthly_profit_trend.csv           
├── expense_breakdown_by_property.csv  
└── README.md                          
```

---

## Database Schema

### `properties`
| Column | Type | Description |
|---|---|---|
| property_id | INT PK AUTO_INCREMENT | Surrogate key |
| name | VARCHAR(150) | Friendly property name |
| address | VARCHAR(255) | Street address |
| city / state | VARCHAR / CHAR(2) | Location |
| property_type | ENUM | Single Family, Multi Family, Condo, Commercial |
| purchase_price | DECIMAL(12,2) | Original purchase price |
| purchase_date | DATE | Date acquired |
| status | ENUM | Active, Vacant, Sold |
| created_at | TIMESTAMP | Auto-set on insert |

### `expenses`
| Column | Type | Description |
|---|---|---|
| expense_id | INT PK AUTO_INCREMENT | Surrogate key |
| property_id | INT FK | References properties |
| expense_date | DATE | Date of expense |
| category | ENUM | Mortgage, Repairs, Insurance, etc. |
| amount | DECIMAL(10,2) | Dollar amount (CHECK > 0) |
| vendor | VARCHAR(150) | Who was paid |
| notes | TEXT | Optional description |

### `payments`
| Column | Type | Description |
|---|---|---|
| payment_id | INT PK AUTO_INCREMENT | Surrogate key |
| property_id | INT FK | References properties |
| payment_date | DATE | Date payment received |
| amount | DECIMAL(10,2) | Dollar amount (CHECK > 0) |
| payment_type | ENUM | Rent, Late Fee, Deposit, Other |
| tenant_name | VARCHAR(150) | Who paid |
| notes | TEXT | Optional description |

---

## Queries Included (`queries.sql`)

| # | Query | Business Question |
|---|---|---|
| 1 | Total expenses per property | Where is money going? |
| 2 | Total income per property | Which properties earn most? |
| 3 | Net profit per property | Core P&L by asset |
| 4 | Monthly profit trend | Seasonal patterns? |
| 5 | Highest expense categories | Top cost drivers |
| 6 | Expenses by property + category | Detailed cost breakdown |
| 7 | Most profitable property | Single best performer |
| 8 | ROI per property | Return on investment % |
| 9 | Vacant / non-paying properties | Risk flag — no income |
| 10 | Monthly expenses per property | Rolling cost history |
| 11 | Repair & maintenance spend | Aging asset risk |
| 12 | Income-to-expense ratio | Financial health ratio |

---

## How to Run

### Option A — MariaDB CLI
```bash
cd /path/to/MariaDB_Property

mariadb -u <db_user> -p < schema.sql
mariadb -u <db_user> -p property_manager < sample_data.sql
mariadb -u <db_user> -p property_manager < queries.sql
```

Replace `<db_user>` with your MariaDB username, such as `root` or your own local database user.

### Option B — Interactive shell
```bash
mariadb -u <db_user> -p

-- Inside the shell:
SOURCE /path/to/schema.sql;
SOURCE /path/to/sample_data.sql;
SOURCE /path/to/queries.sql;
```

Example:
```sql
SOURCE /full/path/to/MariaDB_Property/schema.sql;
SOURCE /full/path/to/MariaDB_Property/sample_data.sql;
SOURCE /full/path/to/MariaDB_Property/queries.sql;
```

### Option C — GUI (DBeaver / TablePlus / HeidiSQL)
1. Create a new MariaDB connection
2. Open and run `schema.sql`
3. Open and run `sample_data.sql`
4. Run individual queries from `queries.sql`

### Option D — Export report results to CSV
```bash
mariadb -u <db_user> -p property_manager < export_reports.sql
```

This writes CSV files for key reports into the project folder:
- `property_net_profit.csv`
- `monthly_profit_trend.csv`
- `expense_breakdown_by_property.csv`

Before running `export_reports.sql`, update the `INTO OUTFILE` paths if they point to a user-specific directory on your machine.

---

## Sample Results

**Net Profit per Property (Jan–Jun 2024)**

| Property | Income | Expenses | Net Profit |
|---|---|---|---|
| Commerce Plaza Unit | $33,000 | $20,510 | $12,490 |
| Maple Street Duplex | $20,975 | $10,515 | $10,460 |
| Elm Road Single Family | $14,400 | $11,580 | $2,820 |
| Oak Avenue Condo | $9,600 | $8,100 | $1,500 |
| Pine Street Cottage | $0 | $7,420 | -$7,420 |

---

## SQL Concepts Demonstrated

- `JOIN` 
- Aggregate functions: `SUM`, `COUNT`, `AVG`, `ROUND`
- `GROUP BY` and `ORDER BY`
- `COALESCE` and `NULLIF` for null-safe arithmetic
- `DATE_FORMAT()` for month/year grouping
- Subqueries and `UNION ALL`
- `ENUM` types for data integrity
- `DECIMAL` for precise monetary values
- `CHECK` constraints and named foreign keys
- `InnoDB` engine with `utf8mb4` charset
- Index strategy 
- `SET FOREIGN_KEY_CHECKS` for safe teardown/rebuild

---
