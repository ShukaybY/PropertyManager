-- ============================================================
--  Property & Expense Management System
--  sample_data.sql — Seed data  |  MariaDB 10.6+
--  AI generated date
-- ============================================================

USE property_manager;

-- ------------------------------------------------------------
-- PROPERTIES
-- ------------------------------------------------------------
INSERT INTO properties
    (name, address, city, state, property_type, purchase_price, purchase_date, status)
VALUES
    ('Maple Street Duplex',    '142 Maple St',      'Chicago',    'IL', 'Multi Family',  285000.00, '2020-03-15', 'Active'),
    ('Oak Avenue Condo',       '88 Oak Ave #4B',    'Naperville', 'IL', 'Condo',         195000.00, '2021-07-01', 'Active'),
    ('Elm Road Single Family', '310 Elm Rd',        'Addison',    'IL', 'Single Family', 340000.00, '2019-11-20', 'Active'),
    ('Commerce Plaza Unit',    '500 Commerce Blvd', 'Chicago',    'IL', 'Commercial',    620000.00, '2018-06-10', 'Active'),
    ('Pine Street Cottage',    '77 Pine St',        'Wheaton',    'IL', 'Single Family', 210000.00, '2022-01-05', 'Vacant');


-- ------------------------------------------------------------
-- EXPENSES
-- ------------------------------------------------------------
INSERT INTO expenses
    (property_id, expense_date, category, amount, vendor, notes)
VALUES
-- Property 1 – Maple Street Duplex
(1, '2024-01-05', 'Mortgage',      1450.00, 'Chase Bank',        'Jan mortgage'),
(1, '2024-01-12', 'Insurance',      180.00, 'State Farm',        'Monthly landlord insurance'),
(1, '2024-02-05', 'Mortgage',      1450.00, 'Chase Bank',        'Feb mortgage'),
(1, '2024-02-18', 'Repairs',        320.00, 'Mike Plumbing Co.', 'Leaking faucet unit 1'),
(1, '2024-03-05', 'Mortgage',      1450.00, 'Chase Bank',        'Mar mortgage'),
(1, '2024-03-22', 'Maintenance',    150.00, 'Green Lawn Care',   'Spring lawn cleanup'),
(1, '2024-04-05', 'Mortgage',      1450.00, 'Chase Bank',        'Apr mortgage'),
(1, '2024-04-10', 'Property Tax',   975.00, 'Cook County',       'Q2 property tax'),
(1, '2024-05-05', 'Mortgage',      1450.00, 'Chase Bank',        'May mortgage'),
(1, '2024-06-05', 'Mortgage',      1450.00, 'Chase Bank',        'Jun mortgage'),
(1, '2024-06-14', 'Repairs',        640.00, 'HVAC Pros',         'AC unit service unit 2'),

-- Property 2 – Oak Avenue Condo
(2, '2024-01-08', 'Mortgage',       890.00, 'Wells Fargo',       'Jan mortgage'),
(2, '2024-01-08', 'HOA',            225.00, 'Oak Ave HOA',       'Jan HOA fee'),
(2, '2024-02-08', 'Mortgage',       890.00, 'Wells Fargo',       'Feb mortgage'),
(2, '2024-02-08', 'HOA',            225.00, 'Oak Ave HOA',       'Feb HOA fee'),
(2, '2024-03-08', 'Mortgage',       890.00, 'Wells Fargo',       'Mar mortgage'),
(2, '2024-03-08', 'HOA',            225.00, 'Oak Ave HOA',       'Mar HOA fee'),
(2, '2024-03-30', 'Repairs',        410.00, 'QuickFix Handyman', 'Bathroom tile repair'),
(2, '2024-04-08', 'Mortgage',       890.00, 'Wells Fargo',       'Apr mortgage'),
(2, '2024-04-08', 'HOA',            225.00, 'Oak Ave HOA',       'Apr HOA fee'),
(2, '2024-05-08', 'Mortgage',       890.00, 'Wells Fargo',       'May mortgage'),
(2, '2024-05-08', 'HOA',            225.00, 'Oak Ave HOA',       'May HOA fee'),
(2, '2024-06-08', 'Mortgage',       890.00, 'Wells Fargo',       'Jun mortgage'),
(2, '2024-06-08', 'HOA',            225.00, 'Oak Ave HOA',       'Jun HOA fee'),

-- Property 3 – Elm Road Single Family
(3, '2024-01-01', 'Mortgage',      1620.00, 'Bank of America',   'Jan mortgage'),
(3, '2024-01-15', 'Insurance',      210.00, 'Allstate',          'Jan insurance'),
(3, '2024-02-01', 'Mortgage',      1620.00, 'Bank of America',   'Feb mortgage'),
(3, '2024-03-01', 'Mortgage',      1620.00, 'Bank of America',   'Mar mortgage'),
(3, '2024-03-10', 'Utilities',       95.00, 'ComEd',             'Electric – owner-paid'),
(3, '2024-04-01', 'Mortgage',      1620.00, 'Bank of America',   'Apr mortgage'),
(3, '2024-04-15', 'Property Tax',  1100.00, 'DuPage County',     'Q2 tax'),
(3, '2024-05-01', 'Mortgage',      1620.00, 'Bank of America',   'May mortgage'),
(3, '2024-05-20', 'Repairs',        875.00, 'Roof Masters',      'Shingle repair after storm'),
(3, '2024-06-01', 'Mortgage',      1620.00, 'Bank of America',   'Jun mortgage'),
(3, '2024-06-05', 'Maintenance',    200.00, 'Green Lawn Care',   'Monthly lawn service'),

-- Property 4 – Commerce Plaza
(4, '2024-01-01', 'Mortgage',      3100.00, 'Citibank',          'Jan mortgage'),
(4, '2024-01-01', 'Insurance',      450.00, 'Travelers',         'Jan commercial insurance'),
(4, '2024-02-01', 'Mortgage',      3100.00, 'Citibank',          'Feb mortgage'),
(4, '2024-03-01', 'Mortgage',      3100.00, 'Citibank',          'Mar mortgage'),
(4, '2024-03-25', 'Repairs',       1200.00, 'Commercial HVAC',   'HVAC maintenance contract'),
(4, '2024-04-01', 'Mortgage',      3100.00, 'Citibank',          'Apr mortgage'),
(4, '2024-04-01', 'Management Fee', 480.00, 'Metro PM Group',    'April mgmt fee'),
(4, '2024-05-01', 'Mortgage',      3100.00, 'Citibank',          'May mortgage'),
(4, '2024-05-01', 'Management Fee', 480.00, 'Metro PM Group',    'May mgmt fee'),
(4, '2024-06-01', 'Mortgage',      3100.00, 'Citibank',          'Jun mortgage'),
(4, '2024-06-01', 'Management Fee', 480.00, 'Metro PM Group',    'Jun mgmt fee'),

-- Property 5 – Pine Street Cottage (vacant)
(5, '2024-01-10', 'Mortgage',       980.00, 'Chase Bank',        'Jan mortgage'),
(5, '2024-01-10', 'Insurance',      140.00, 'State Farm',        'Jan insurance'),
(5, '2024-02-10', 'Mortgage',       980.00, 'Chase Bank',        'Feb mortgage'),
(5, '2024-03-10', 'Mortgage',       980.00, 'Chase Bank',        'Mar mortgage'),
(5, '2024-03-15', 'Repairs',       2400.00, 'Total Renovations', 'Kitchen remodel prep'),
(5, '2024-04-10', 'Mortgage',       980.00, 'Chase Bank',        'Apr mortgage'),
(5, '2024-05-10', 'Mortgage',       980.00, 'Chase Bank',        'May mortgage'),
(5, '2024-06-10', 'Mortgage',       980.00, 'Chase Bank',        'Jun mortgage');


-- ------------------------------------------------------------
-- PAYMENTS 
-- ------------------------------------------------------------
INSERT INTO payments
    (property_id, payment_date, amount, payment_type, tenant_name, notes)
VALUES
-- Property 1
(1, '2024-01-01', 2200.00, 'Rent',     'Johnson Family', 'Unit 1 Jan rent'),
(1, '2024-01-01', 1100.00, 'Rent',     'Garcia, Maria',  'Unit 2 Jan rent'),
(1, '2024-02-01', 2200.00, 'Rent',     'Johnson Family', 'Unit 1 Feb rent'),
(1, '2024-02-01', 1100.00, 'Rent',     'Garcia, Maria',  'Unit 2 Feb rent'),
(1, '2024-03-01', 2200.00, 'Rent',     'Johnson Family', 'Unit 1 Mar rent'),
(1, '2024-03-05', 1100.00, 'Rent',     'Garcia, Maria',  'Unit 2 Mar rent – 5 days late'),
(1, '2024-03-05',   75.00, 'Late Fee', 'Garcia, Maria',  'Late fee applied'),
(1, '2024-04-01', 2200.00, 'Rent',     'Johnson Family', 'Unit 1 Apr rent'),
(1, '2024-04-01', 1100.00, 'Rent',     'Garcia, Maria',  'Unit 2 Apr rent'),
(1, '2024-05-01', 2200.00, 'Rent',     'Johnson Family', 'Unit 1 May rent'),
(1, '2024-05-01', 1100.00, 'Rent',     'Garcia, Maria',  'Unit 2 May rent'),
(1, '2024-06-01', 2200.00, 'Rent',     'Johnson Family', 'Unit 1 Jun rent'),
(1, '2024-06-01', 1100.00, 'Rent',     'Garcia, Maria',  'Unit 2 Jun rent'),

-- Property 2
(2, '2024-01-01', 1600.00, 'Rent', 'Chen, David',     'Jan rent'),
(2, '2024-02-01', 1600.00, 'Rent', 'Chen, David',     'Feb rent'),
(2, '2024-03-01', 1600.00, 'Rent', 'Chen, David',     'Mar rent'),
(2, '2024-04-01', 1600.00, 'Rent', 'Chen, David',     'Apr rent'),
(2, '2024-05-01', 1600.00, 'Rent', 'Chen, David',     'May rent'),
(2, '2024-06-01', 1600.00, 'Rent', 'Chen, David',     'Jun rent'),

-- Property 3
(3, '2024-01-01', 2400.00, 'Rent', 'Thompson, Sarah', 'Jan rent'),
(3, '2024-02-01', 2400.00, 'Rent', 'Thompson, Sarah', 'Feb rent'),
(3, '2024-03-01', 2400.00, 'Rent', 'Thompson, Sarah', 'Mar rent'),
(3, '2024-04-01', 2400.00, 'Rent', 'Thompson, Sarah', 'Apr rent'),
(3, '2024-05-01', 2400.00, 'Rent', 'Thompson, Sarah', 'May rent'),
(3, '2024-06-01', 2400.00, 'Rent', 'Thompson, Sarah', 'Jun rent'),

-- Property 4
(4, '2024-01-01', 5500.00, 'Rent', 'Bright Star LLC', 'Jan commercial rent'),
(4, '2024-02-01', 5500.00, 'Rent', 'Bright Star LLC', 'Feb commercial rent'),
(4, '2024-03-01', 5500.00, 'Rent', 'Bright Star LLC', 'Mar commercial rent'),
(4, '2024-04-01', 5500.00, 'Rent', 'Bright Star LLC', 'Apr commercial rent'),
(4, '2024-05-01', 5500.00, 'Rent', 'Bright Star LLC', 'May commercial rent'),
(4, '2024-06-01', 5500.00, 'Rent', 'Bright Star LLC', 'Jun commercial rent');

