-- Update existing products with enhanced data
UPDATE products SET 
  brand = 'INO-VAP ZONE',
  connection_type = CASE 
    WHEN categories.slug IN ('tri-clamp') THEN 'Tri-Clamp'
    WHEN categories.slug = 'sms' THEN 'SMS'
    WHEN categories.slug = 'din' THEN 'DIN'
    WHEN categories.slug = 'bsp-threaded-fittings' THEN 'BSP Threaded'
    WHEN categories.slug = 'stainless-steel-valves' THEN 'Tri-Clamp'
    WHEN categories.slug = 'stainless-steel-flanges' THEN 'Flanged'
    ELSE 'General'
  END,
  standard = CASE
    WHEN categories.slug = 'tri-clamp' THEN 'ISO 2852'
    WHEN categories.slug = 'sms' THEN 'SMS 1145'
    WHEN categories.slug = 'din' THEN 'DIN 11851'
    WHEN categories.slug = 'bsp-threaded-fittings' THEN 'BS 21'
    WHEN categories.slug = 'stainless-steel-flanges' THEN 'ANSI B16.5'
    ELSE 'AISI'
  END,
  applications = CASE
    WHEN categories.slug IN ('tri-clamp', 'sms', 'din') THEN ARRAY['Food Processing', 'Dairy', 'Pharmaceutical', 'Beverage']
    WHEN categories.slug IN ('stainless-steel-valves') THEN ARRAY['Food Processing', 'Pharmaceutical', 'Chemical']
    WHEN categories.slug = 'bsp-threaded-fittings' THEN ARRAY['Industrial', 'Water Treatment', 'Chemical']
    WHEN categories.slug = 'stainless-steel-flanges' THEN ARRAY['Oil & Gas', 'Chemical', 'Industrial']
    WHEN categories.slug = 'pipe-fittings' THEN ARRAY['Industrial', 'Chemical', 'Oil & Gas']
    WHEN categories.slug = 'steam-equipment' THEN ARRAY['Steam Systems', 'Process Heating', 'Industrial']
    WHEN categories.slug = 'pressure-gauges' THEN ARRAY['Industrial Instruments', 'Process Control', 'Steam Systems']
    WHEN categories.slug = 'industrial-instruments' THEN ARRAY['Process Control', 'Industrial Instruments']
    ELSE ARRAY['Industrial']
  END,
  surface_finish = CASE
    WHEN material = '316' THEN 'Ra 0.5'
    WHEN material = '304' THEN 'Ra 0.8'
    ELSE 'Ra 1.6'
  END
FROM categories WHERE products.category_id = categories.id;

-- Add more Tri Clamp products
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, brand, connection_type, standard, is_featured, applications) VALUES
('Tri Clamp Reducer', 'tri-clamp-reducer', 'TC-RED-01', 'TCR-1', (SELECT id FROM categories WHERE slug = 'tri-clamp'), 
'Concentric tri-clamp reducer for connecting pipes of different diameters in sanitary systems.',
'{"Standard": "ISO 2852", "Finish": "Ra 0.8", "Type": "Concentric"}',
'304', ARRAY['2x1.5', '3x2', '4x3', '6x4'], 'INO-VAP ZONE', 'Tri-Clamp', 'ISO 2852', false, ARRAY['Food Processing', 'Dairy', 'Beverage']),
('Tri Clamp Tee Equal', 'tri-clamp-tee-equal', 'TC-TEE-01', 'TCT-1', (SELECT id FROM categories WHERE slug = 'tri-clamp'),
'Equal tri-clamp tee for splitting or combining flow in sanitary piping systems.',
'{"Standard": "ISO 2852", "Finish": "Ra 0.5", "Type": "Equal Tee"}',
'316', ARRAY['1"', '1.5"', '2"', '2.5"', '3"', '4"'], 'INO-VAP ZONE', 'Tri-Clamp', 'ISO 2852', true, ARRAY['Pharmaceutical', 'Biotechnology', 'Food Processing']),
('Tri Clamp Cross', 'tri-clamp-cross', 'TC-CRS-01', 'TCC-1', (SELECT id FROM categories WHERE slug = 'tri-clamp'),
'Tri-clamp cross fitting for four-way flow distribution in sanitary systems.',
'{"Standard": "ISO 2852", "Finish": "Ra 0.8"}',
'304', ARRAY['1.5"', '2"', '2.5"', '3"'], 'INO-VAP ZONE', 'Tri-Clamp', 'ISO 2852', false, ARRAY['Dairy', 'Beverage', 'Food Processing']),
('Tri Clamp Sight Glass', 'tri-clamp-sight-glass', 'TC-SG-01', 'TCSG-1', (SELECT id FROM categories WHERE slug = 'tri-clamp'),
'Sanitary sight glass for visual inspection of process flow.',
'{"Standard": "ISO 2852", "Glass": "Borosilicate", "MaxPressure": "10 bar"}',
'304', ARRAY['1.5"', '2"', '3"'], 'INO-VAP ZONE', 'Tri-Clamp', 'ISO 2852', true, ARRAY['Pharmaceutical', 'Food Processing', 'Biotechnology'])
ON CONFLICT (sku) DO NOTHING;

-- Add more Valve products
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, brand, connection_type, standard, is_featured, applications) VALUES
('Check Valve Sanitary', 'check-valve-sanitary', 'VAL-CHK-01', 'VCH-1', (SELECT id FROM categories WHERE slug = 'stainless-steel-valves'),
'Sanitary check valve for preventing backflow.',
'{"Type": "Spring-loaded Check", "Crack Pressure": "0.5 bar"}',
'316', ARRAY['1"', '1.5"', '2"', '2.5"', '3"'], 'INO-VAP ZONE', 'Tri-Clamp', 'ISO 2852', true, ARRAY['Food Processing', 'Pharmaceutical', 'Beverage']),
('Diaphragm Valve', 'diaphragm-valve', 'VAL-DIA-01', 'VDI-1', (SELECT id FROM categories WHERE slug = 'stainless-steel-valves'),
'Sanitary diaphragm valve for sterile applications.',
'{"Type": "Weir Diaphragm", "Diaphragm": "EPDM/PTFE"}',
'316L', ARRAY['DN15', 'DN25', 'DN40', 'DN50', 'DN65'], 'INO-VAP ZONE', 'Tri-Clamp', 'ISO 2852', true, ARRAY['Pharmaceutical', 'Biotechnology', 'Chemical']),
('Safety Relief Valve', 'safety-relief-valve', 'VAL-SRV-01', 'VSR-1', (SELECT id FROM categories WHERE slug = 'stainless-steel-valves'),
'Safety relief valve for overpressure protection of vessels.',
'{"Type": "Safety Relief", "Setting": "Adjustable", "Orifice": "Full lift"}',
'316', ARRAY['DN20', 'DN25', 'DN40', 'DN50'], 'INO-VAP ZONE', 'Flanged', 'API 526', true, ARRAY['Steam Systems', 'Pressure Vessels', 'Industrial'])
ON CONFLICT (sku) DO NOTHING;

-- Add more Pipe Fittings
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, brand, connection_type, standard, is_featured, applications) VALUES
('Eccentric Reducer', 'eccentric-reducer', 'PIP-ERE-01', 'PER-1', (SELECT id FROM categories WHERE slug = 'pipe-fittings'),
'Eccentric reducer for horizontal pipe runs, prevents air locking.',
'{"Type": "Eccentric", "Ends": "Butt weld", "Standard": "ASTM A403"}',
'304', ARRAY['2x1.5', '3x2', '4x3', '6x4'], 'INO-VAP ZONE', 'Butt Weld', 'ASTM A403', false, ARRAY['Chemical', 'Water Treatment', 'Oil & Gas']),
('Stainless Reducing Tee', 'reducing-tee', 'PIP-RDT-01', 'PRT-1', (SELECT id FROM categories WHERE slug = 'pipe-fittings'),
'Reducing tee for combining flows of different diameters.',
'{"Type": "Reducing Tee", "Ends": "Butt weld"}',
'316', ARRAY['2x1.5x2', '3x2', '4x3', '6x4'], 'INO-VAP ZONE', 'Butt Weld', 'ASTM A403', true, ARRAY['Oil & Gas', 'Chemical'])
ON CONFLICT (sku) DO NOTHING;

-- Add more Steam Equipment
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, brand, connection_type, standard, is_featured, applications) VALUES
('Thermodynamic Steam Trap', 'thermodynamic-steam-trap', 'STM-TD-01', 'STD-1', (SELECT id FROM categories WHERE slug = 'steam-equipment'),
'Thermodynamic steam trap for main steam lines and tracing.',
'{"Type": "Thermodynamic", "Body": "Stainless", "MaxPressure": "32 bar"}',
'304', ARRAY['DN15', 'DN20', 'DN25'], 'INO-VAP ZONE', 'Threaded', 'ISO 6553', true, ARRAY['Steam Systems', 'Process Heating', 'Industrial'])
ON CONFLICT (sku) DO NOTHING;

-- Add more Pressure Gauges
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, brand, connection_type, standard, is_featured, applications) VALUES
('Glycerin Filled Gauge', 'glycerin-filled-gauge', 'GAG-GLY-01', 'GGL-1', (SELECT id FROM categories WHERE slug = 'pressure-gauges'),
'Glycerin filled pressure gauge for vibration resistance.',
'{"Type": "Glycerin Filled", "Accuracy": "1.6 percent", "Case": "SS304"}',
'304', ARRAY['0-10', '0-16', '0-25', '0-40', '0-60'], 'INO-VAP ZONE', 'BSP Threaded', 'EN 837-1', true, ARRAY['Industrial', 'Steam Systems', 'Hydraulics']),
('Digital Pressure Gauge', 'digital-pressure-gauge', 'GAG-DIG-01', 'GDG-1', (SELECT id FROM categories WHERE slug = 'pressure-gauges'),
'Digital pressure gauge with battery power and data logging.',
'{"Type": "Digital", "Accuracy": "0.25 percent", "Display": "LCD"}',
'316', ARRAY['0-10', '0-25', '0-100', '0-250'], 'INO-VAP ZONE', 'Threaded', 'EN 837-1', true, ARRAY['Process Control', 'Calibration', 'Laboratory'])
ON CONFLICT (sku) DO NOTHING;

-- Add more Industrial Instruments
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, brand, connection_type, standard, is_featured, applications) VALUES
('Thermocouple Assembly', 'thermocouple-assembly', 'INS-TC-01', 'ITC-1', (SELECT id FROM categories WHERE slug = 'industrial-instruments'),
'Industrial thermocouple assembly with thermowell for process temperature.',
'{"Type": "Type K/J", "Sheath": "SS316", "MaxTemp": "1000C"}',
'316', ARRAY['150mm', '300mm', '450mm', '600mm'], 'INO-VAP ZONE', 'Threaded', 'IEC 60584', true, ARRAY['Process Control', 'Industrial', 'Steam Systems']),
('Coriolis Flow Meter', 'coriolis-flow-meter', 'INS-CM-01', 'ICM-1', (SELECT id FROM categories WHERE slug = 'industrial-instruments'),
'Coriolis mass flow meter for high-accuracy liquid and gas measurement.',
'{"Type": "Coriolis", "Accuracy": "0.1 percent", "Outputs": "4-20mA, Pulse"}',
'316L', ARRAY['DN15', 'DN25', 'DN40', 'DN50'], 'INO-VAP ZONE', 'Flanged', 'ISO 4064', true, ARRAY['Oil & Gas', 'Pharmaceutical', 'Food Processing'])
ON CONFLICT (sku) DO NOTHING;

-- Add Downloads for Technical Documentation
INSERT INTO downloads (product_id, type, title, filename, file_size_kb) VALUES
((SELECT id FROM products WHERE sku = 'TC-FER-01'), 'datasheet', 'Tri Clamp Ferrule Datasheet', 'TC-FER-01-datasheet.pdf', 245),
((SELECT id FROM products WHERE sku = 'VAL-BAL-01'), 'datasheet', 'Sanitary Ball Valve Datasheet', 'VAL-BAL-01-datasheet.pdf', 312),
((SELECT id FROM products WHERE sku = 'STM-TRP-01'), 'datasheet', 'Float Steam Trap Datasheet', 'STM-TRP-01-datasheet.pdf', 278),
((SELECT id FROM products WHERE sku = 'GAG-SS-01'), 'datasheet', 'Stainless Pressure Gauge Datasheet', 'GAG-SS-01-datasheet.pdf', 198),
((SELECT id FROM products WHERE sku = 'INS-EMF-01'), 'datasheet', 'Electromagnetic Flow Meter Datasheet', 'INS-EMF-01-datasheet.pdf', 456),
((SELECT id FROM products WHERE sku = 'VAL-BAL-01'), 'certificate', 'Material Certificate EN 10204 3.1', 'VAL-BAL-01-certificate.pdf', 89),
((SELECT id FROM products WHERE sku = 'INS-EMF-01'), 'manual', 'Installation and Operation Manual', 'INS-EMF-01-manual.pdf', 1250),
((SELECT id FROM products WHERE sku = 'VAL-DIA-01'), 'datasheet', 'Diaphragm Valve Datasheet', 'VAL-DIA-01-datasheet.pdf', 356)
ON CONFLICT DO NOTHING;