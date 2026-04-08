-- ============================================================
--  Property & Expense Management System
--  queries.sql — MariaDB 10.6+
-- ============================================================

USE property_manager;

-- ============================================================
-- 1. TOTAL EXPENSES PER PROPERTY
-- ============================================================
SELECT
    p.property_id,
    p.name                              AS property_name,
    p.city,
    p.property_type,
    COUNT(e.expense_id)                 AS expense_count,
    ROUND(SUM(e.amount), 2)             AS total_expenses
FROM properties p
LEFT JOIN expenses e ON p.property_id = e.property_id
GROUP BY p.property_id, p.name, p.city, p.property_type
ORDER BY total_expenses DESC;


-- ============================================================
-- 2. TOTAL INCOME PER PROPERTY
-- ============================================================
SELECT
    p.property_id,
    p.name                              AS property_name,
    COUNT(pay.payment_id)               AS payment_count,
    ROUND(SUM(pay.amount), 2)           AS total_income
FROM properties p
LEFT JOIN payments pay ON p.property_id = pay.property_id
GROUP BY p.property_id, p.name
ORDER BY total_income DESC;


-- ============================================================
-- 3. NET PROFIT PER PROPERTY  
-- ============================================================
SELECT
    p.property_id,
    p.name                                                      AS property_name,
    p.property_type,
    p.status,
    ROUND(COALESCE(pay.total_income, 0), 2)                     AS total_income,
    ROUND(COALESCE(e.total_expenses, 0), 2)                     AS total_expenses,
    ROUND(COALESCE(pay.total_income, 0)
        - COALESCE(e.total_expenses, 0), 2)                     AS net_profit
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
ORDER BY net_profit DESC;


-- ============================================================
-- 4. MONTHLY PROFIT TREND  
-- ============================================================
SELECT
    DATE_FORMAT(month_date, '%Y-%m')                            AS month,
    ROUND(COALESCE(SUM(monthly_income),   0), 2)                AS income,
    ROUND(COALESCE(SUM(monthly_expenses), 0), 2)                AS expenses,
    ROUND(COALESCE(SUM(monthly_income), 0)
        - COALESCE(SUM(monthly_expenses), 0), 2)                AS net_profit
FROM (
    SELECT
        payment_date                AS month_date,
        amount                      AS monthly_income,
        NULL                        AS monthly_expenses
    FROM payments

    UNION ALL

    SELECT
        expense_date                AS month_date,
        NULL                        AS monthly_income,
        amount                      AS monthly_expenses
    FROM expenses
) AS combined
GROUP BY DATE_FORMAT(month_date, '%Y-%m')
ORDER BY month;


-- ============================================================
-- 5. HIGHEST EXPENSE CATEGORIES  
-- ============================================================
SELECT
    e.category,
    COUNT(e.expense_id)             AS transaction_count,
    ROUND(SUM(e.amount), 2)         AS total_spent,
    ROUND(AVG(e.amount), 2)         AS avg_per_transaction,
    ROUND(
        SUM(e.amount) * 100.0
        / (SELECT SUM(amount) FROM expenses)
    , 1)                            AS pct_of_total
FROM expenses e
GROUP BY e.category
ORDER BY total_spent DESC;


-- ============================================================
-- 6. EXPENSE BREAKDOWN BY PROPERTY + CATEGORY
-- ============================================================
SELECT
    p.name                          AS property_name,
    e.category,
    ROUND(SUM(e.amount), 2)         AS total
FROM expenses e
JOIN properties p ON e.property_id = p.property_id
GROUP BY p.property_id, p.name, e.category
ORDER BY p.name, total DESC;


-- ============================================================
-- 7. MOST PROFITABLE PROPERTY
-- ============================================================
SELECT
    p.name                                                      AS property_name,
    ROUND(COALESCE(pay.total_income, 0)
        - COALESCE(e.total_expenses, 0), 2)                     AS net_profit
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
ORDER BY net_profit DESC
LIMIT 1;


-- ============================================================
-- 8. ROI PER PROPERTY
-- ============================================================
SELECT
    p.name                                                      AS property_name,
    p.purchase_price,
    ROUND(COALESCE(pay.total_income, 0)
        - COALESCE(e.total_expenses, 0), 2)                     AS net_profit,
    ROUND(
        (COALESCE(pay.total_income, 0) - COALESCE(e.total_expenses, 0))
        / p.purchase_price * 100
    , 2)                                                        AS roi_pct
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
ORDER BY roi_pct DESC;


-- ============================================================
-- 9. VACANCY / NON-PAYING PROPERTIES
-- ============================================================
SELECT
    p.property_id,
    p.name              AS property_name,
    p.status,
    p.city
FROM properties p
LEFT JOIN payments pay ON p.property_id = pay.property_id
WHERE pay.payment_id IS NULL;


-- ============================================================
-- 10. MONTHLY EXPENSES PER PROPERTY
-- ============================================================
SELECT
    p.name                                  AS property_name,
    DATE_FORMAT(e.expense_date, '%Y-%m')    AS month,
    ROUND(SUM(e.amount), 2)                 AS monthly_expenses
FROM expenses e
JOIN properties p ON e.property_id = p.property_id
GROUP BY p.property_id, p.name, DATE_FORMAT(e.expense_date, '%Y-%m')
ORDER BY p.name, month;


-- ============================================================
-- 11. REPAIR & MAINTENANCE SPEND 
-- ============================================================
SELECT
    p.name                                          AS property_name,
    ROUND(SUM(e.amount), 2)                         AS repair_maintenance_cost,
    ROUND(SUM(e.amount) / p.purchase_price * 100, 2) AS pct_of_purchase_price
FROM expenses e
JOIN properties p ON e.property_id = p.property_id
WHERE e.category IN ('Repairs', 'Maintenance')
GROUP BY p.property_id, p.name, p.purchase_price
ORDER BY repair_maintenance_cost DESC;


-- ============================================================
-- 12. INCOME vs EXPENSE RATIO PER PROPERTY
-- ============================================================
SELECT
    p.name                                                      AS property_name,
    ROUND(COALESCE(pay.total_income, 0), 2)                     AS total_income,
    ROUND(COALESCE(e.total_expenses, 0), 2)                     AS total_expenses,
    ROUND(
        COALESCE(pay.total_income, 0) /
        NULLIF(COALESCE(e.total_expenses, 0), 0)
    , 2)                                                        AS income_to_expense_ratio
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
ORDER BY income_to_expense_ratio DESC;
