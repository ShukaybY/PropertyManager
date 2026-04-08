-- ============================================================
--  Property & Expense Management System
--  export_reports.sql — CSV exports for report outputs
--  MariaDB 10.6+
-- ============================================================

USE property_manager;

-- ------------------------------------------------------------
-- 1. NET PROFIT PER PROPERTY
-- ------------------------------------------------------------
SELECT 'property_id', 'property_name', 'property_type', 'status',
       'total_income', 'total_expenses', 'net_profit'
UNION ALL
SELECT
    p.property_id,
    p.name,
    p.property_type,
    p.status,
    ROUND(COALESCE(pay.total_income, 0), 2),
    ROUND(COALESCE(e.total_expenses, 0), 2),
    ROUND(COALESCE(pay.total_income, 0) - COALESCE(e.total_expenses, 0), 2)
FROM properties p
LEFT JOIN (
    SELECT
        property_id,
        SUM(amount) AS total_income
    FROM payments
    GROUP BY property_id
) pay ON p.property_id = pay.property_id
LEFT JOIN (
    SELECT
        property_id,
        SUM(amount) AS total_expenses
    FROM expenses
    GROUP BY property_id
) e ON p.property_id = e.property_id
INTO OUTFILE 'property_net_profit.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- ------------------------------------------------------------
-- 2. MONTHLY PROFIT TREND
-- ------------------------------------------------------------
SELECT 'month', 'income', 'expenses', 'net_profit'
UNION ALL
SELECT
    DATE_FORMAT(month_date, '%Y-%m'),
    ROUND(COALESCE(SUM(monthly_income), 0), 2),
    ROUND(COALESCE(SUM(monthly_expenses), 0), 2),
    ROUND(COALESCE(SUM(monthly_income), 0) - COALESCE(SUM(monthly_expenses), 0), 2)
FROM (
    SELECT
        payment_date AS month_date,
        amount AS monthly_income,
        NULL AS monthly_expenses
    FROM payments

    UNION ALL

    SELECT
        expense_date AS month_date,
        NULL AS monthly_income,
        amount AS monthly_expenses
    FROM expenses
) combined
GROUP BY DATE_FORMAT(month_date, '%Y-%m')
INTO OUTFILE 'monthly_profit_trend.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- ------------------------------------------------------------
-- 3. EXPENSE BREAKDOWN BY PROPERTY + CATEGORY
-- ------------------------------------------------------------
SELECT 'property_name', 'category', 'total'
UNION ALL
SELECT
    p.name,
    e.category,
    ROUND(SUM(e.amount), 2)
FROM expenses e
JOIN properties p ON e.property_id = p.property_id
GROUP BY p.property_id, p.name, e.category
INTO OUTFILE 'expense_breakdown_by_property.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';
