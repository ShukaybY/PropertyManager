-- ============================================================
--  Property & Expense Management System
--  schema.sql — MariaDB 10.6+
-- ============================================================

-- Create and select the database
CREATE DATABASE IF NOT EXISTS property_manager
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE property_manager;

-- Disable FK checks for clean re-runs
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS properties;

SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------
-- PROPERTIES
-- ------------------------------------------------------------
CREATE TABLE properties (
    property_id     INT               NOT NULL AUTO_INCREMENT,
    name            VARCHAR(150)      NOT NULL,
    address         VARCHAR(255)      NOT NULL,
    city            VARCHAR(100)      NOT NULL,
    state           CHAR(2)           NOT NULL,
    property_type   ENUM(
                        'Single Family',
                        'Multi Family',
                        'Condo',
                        'Commercial'
                    )                 NOT NULL,
    purchase_price  DECIMAL(12, 2)    NOT NULL,
    purchase_date   DATE              NOT NULL,
    status          ENUM(
                        'Active',
                        'Vacant',
                        'Sold'
                    )                 NOT NULL DEFAULT 'Active',
    created_at      TIMESTAMP         NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (property_id)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------
-- EXPENSES
-- ------------------------------------------------------------
CREATE TABLE expenses (
    expense_id      INT               NOT NULL AUTO_INCREMENT,
    property_id     INT               NOT NULL,
    expense_date    DATE              NOT NULL,
    category        ENUM(
                        'Mortgage',
                        'Insurance',
                        'Property Tax',
                        'Repairs',
                        'Maintenance',
                        'Utilities',
                        'Management Fee',
                        'HOA',
                        'Other'
                    )                 NOT NULL,
    amount          DECIMAL(10, 2)    NOT NULL,
    vendor          VARCHAR(150)      NULL,
    notes           TEXT              NULL,
    created_at      TIMESTAMP         NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (expense_id),

    CONSTRAINT chk_expense_amount
        CHECK (amount > 0),

    CONSTRAINT fk_expenses_property
        FOREIGN KEY (property_id)
        REFERENCES properties (property_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------
-- PAYMENTS 
-- ------------------------------------------------------------
CREATE TABLE payments (
    payment_id      INT               NOT NULL AUTO_INCREMENT,
    property_id     INT               NOT NULL,
    payment_date    DATE              NOT NULL,
    amount          DECIMAL(10, 2)    NOT NULL,
    payment_type    ENUM(
                        'Rent',
                        'Late Fee',
                        'Deposit',
                        'Other'
                    )                 NOT NULL DEFAULT 'Rent',
    tenant_name     VARCHAR(150)      NULL,
    notes           TEXT              NULL,
    created_at      TIMESTAMP         NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (payment_id),

    CONSTRAINT chk_payment_amount
        CHECK (amount > 0),

    CONSTRAINT fk_payments_property
        FOREIGN KEY (property_id)
        REFERENCES properties (property_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;


-- ------------------------------------------------------------
-- Indexes for common query patterns
-- ------------------------------------------------------------
CREATE INDEX idx_expenses_date       ON expenses  (expense_date);
CREATE INDEX idx_expenses_category   ON expenses  (category);
CREATE INDEX idx_payments_date       ON payments  (payment_date);
CREATE INDEX idx_payments_type       ON payments  (payment_type);
