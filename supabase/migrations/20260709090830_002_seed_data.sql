-- Insert Categories
INSERT INTO categories (name, slug, description, display_order) VALUES
('Tri Clamp', 'tri-clamp', 'Sanitary tri-clamp fittings for hygienic connections in food, dairy, and pharmaceutical applications.', 1),
('SMS', 'sms', 'SMS (Swedish Metric Standard) fittings for sanitary connections in the food and beverage industry.', 2),
('DIN', 'din', 'DIN standard fittings manufactured to German industrial standards for precision applications.', 3),
('BSP Threaded Fittings', 'bsp-threaded-fittings', 'British Standard Pipe threaded fittings for general industrial piping applications.', 4),
('Stainless Steel Valves', 'stainless-steel-valves', 'Premium stainless steel valves including ball, butterfly, check, and diaphragm valves.', 5),
('Stainless Steel Flanges', 'stainless-steel-flanges', 'High-quality stainless steel flanges for pipe connections in various pressure ratings.', 6),
('Pipe Fittings', 'pipe-fittings', 'Elbows, tees, reducers, and other pipe fittings for industrial piping systems.', 7),
('Steam Equipment', 'steam-equipment', 'Steam traps, separators, and steam control equipment for thermal processing systems.', 8),
('Pressure Gauges', 'pressure-gauges', 'Precision pressure measuring instruments for industrial process monitoring.', 9),
('Industrial Instruments', 'industrial-instruments', 'Temperature sensors, level indicators, and flow meters for process control.', 10)
ON CONFLICT (slug) DO NOTHING;

-- Insert Products for Tri Clamp Category
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, image_url, pdf_datasheet_url, is_featured) VALUES
('Tri Clamp Ferrule', 'tri-clamp-ferrule', 'TC-FER-01', 'TCF-1', (SELECT id FROM categories WHERE slug = 'tri-clamp'), 
'High-quality tri-clamp ferrule for sanitary pipe connections. Polished interior for maximum hygiene.',
'{"Standard": "ISO 2852", "Finish": "Ra ≤ 0.8 μm", "Temperature": "-20°C to 180°C", "Pressure": "Up to 10 bar"}',
'304', ARRAY['1"', '1.5"', '2"', '2.5"', '3"', '4"'],
'https://images.unsplash.com/photo-1635814965924-eb7a5e81c0f7?w=800',
NULL, true),
('Tri Clamp Elbow 90 Degree', 'tri-clamp-elbow-90', 'TC-ELB-01', 'TCE-90-1', (SELECT id FROM categories WHERE slug = 'tri-clamp'),
'90-degree tri-clamp elbow for changing flow direction in sanitary piping systems.',
'{"Standard": "ISO 2852", "Finish": "Ra ≤ 0.8 μm", "Angle": "90°", "Pressure": "Up to 10 bar"}',
'316', ARRAY['1"', '1.5"', '2"', '2.5"', '3"'],
'https://images.unsplash.com/photo-1615111784767-4d7f92680d45?w=800',
NULL, false)
ON CONFLICT (sku) DO NOTHING;

-- Insert Products for SMS Category
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, image_url, pdf_datasheet_url, is_featured) VALUES
('SMS Union', 'sms-union', 'SMS-UNI-01', 'SMSU-1', (SELECT id FROM categories WHERE slug = 'sms'),
'SMS standard sanitary union for food and beverage processing lines. Easy assembly and disassembly.',
'{"Standard": "SMS 1145", "Finish": "Internal Ra ≤ 0.8 μm", "Temperature": "-20°C to 150°C"}',
'304', ARRAY['DN25', 'DN32', 'DN40', 'DN50', 'DN65'],
'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800',
NULL, true),
('SMS Weld Ferrule', 'sms-weld-ferrule', 'SMS-WF-01', 'SMSWF-1', (SELECT id FROM categories WHERE slug = 'sms'),
'SMS weld ferrule for permanent sanitary connections. Butt weld or clamp options available.',
'{"Standard": "SMS 1145", "Weld Type": "Butt weld", "Finish": "Ra ≤ 1.6 μm"}',
'304', ARRAY['DN25', 'DN40', 'DN50', 'DN80'],
'https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?w=800',
NULL, false
) ON CONFLICT (sku) DO NOTHING;

-- Insert Products for DIN Category
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, image_url, pdf_datasheet_url, is_featured) VALUES
('DIN 11851 Union', 'din-11851-union', 'DIN-UNI-01', 'DINU-1', (SELECT id FROM categories WHERE slug = 'din'),
'DIN 11851 standard sanitary union with threaded connection for German standard processing lines.',
'{"Standard": "DIN 11851", "Thread": "Metric", "Pressure": "Up to 25 bar"}',
'316', ARRAY['DN25', 'DN40', 'DN50', 'DN80', 'DN100'],
'https://images.unsplash.com/photo-1615811361523-6d03b1f77aa8?w=800',
NULL, false),
('DIN Clamp Fitting', 'din-clamp-fitting', 'DIN-CLP-01', 'DINC-1', (SELECT id FROM categories WHERE slug = 'din'),
'DIN standard clamp fitting for secure pipe connections in hygienic applications.',
'{"Standard": "DIN 32676", "Clamp Type": "Heavy duty", "Gasket": "Silicone or EPDM"}',
'304', ARRAY['DN25', 'DN32', 'DN40', 'DN50', 'DN65', 'DN100'],
'https://images.unsplash.com/photo-1563720660852-59c4e26e7830?w=800',
NULL, true
) ON CONFLICT (sku) DO NOTHING;

-- Insert Products for BSP Threaded Fittings Category
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, image_url, pdf_datasheet_url, is_featured) VALUES
('BSP Hex Nipple', 'bsp-hex-nipple', 'BSP-NIP-01', 'BSPN-1', (SELECT id FROM categories WHERE slug = 'bsp-threaded-fittings'),
'BSP threaded hex nipple for connecting pipes with British Standard Pipe threads.',
'{"Thread": "BSP Tapered", "Hex Size": "Standard", "Pressure": "Up to 20 bar"}',
'304', ARRAY['1/4"', '3/8"', '1/2"', '3/4"', '1"', '1.5"', '2"'],
'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
NULL, false),
('BSP Street Elbow', 'bsp-street-elbow', 'BSP-ELB-01', 'BSPE-1', (SELECT id FROM categories WHERE slug = 'bsp-threaded-fittings'),
'BSP threaded street elbow (male/female) for changing pipe direction with minimal pressure drop.',
'{"Thread": "BSP Tapered", "Angle": "90°", "Design": "Male and Female"}',
'316', ARRAY['1/2"', '3/4"', '1"', '1.5"', '2"'],
'https://images.unsplash.com/photo-1518709268481-1f9539bc89a6?w=800',
NULL, true
) ON CONFLICT (sku) DO NOTHING;

-- Insert Products for Stainless Steel Valves Category
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, image_url, pdf_datasheet_url, is_featured) VALUES
('Sanitary Ball Valve', 'sanitary-ball-valve', 'VAL-BAL-01', 'VSB-1', (SELECT id FROM categories WHERE slug = 'stainless-steel-valves'),
'Manual sanitary ball valve with tri-clamp ends for hygienic flow control applications.',
'{"Type": "2-way Ball Valve", "Ends": "Tri-clamp", "Handle": "Lever or IP67 option", "Pressure": "PN16"}',
'316', ARRAY['1"', '1.5"', '2"', '2.5"', '3"', '4"'],
'https://images.unsplash.com/photo-1572961778304-5c3db60e3b93?w=800',
NULL, true),
('Butterfly Valve Sanitary', 'butterfly-valve-sanitary', 'VAL-BUT-01', 'VBF-1', (SELECT id FROM categories WHERE slug = 'stainless-steel-valves'),
'Sanitary butterfly valve with pull-handle for quick and easy flow control in food processing.',
'{"Type": "Wafer Butterfly", "Disc": "316 Stainless", "Handle": "Pull handle or Multi-position", "Pressure": "PN10"}',
'316', ARRAY['DN25', 'DN50', 'DN80', 'DN100', 'DN150'],
'https://images.unsplash.com/photo-1563989269965-c4e1e23e90a0?w=800',
NULL, false
) ON CONFLICT (sku) DO NOTHING;

-- Insert Products for Stainless Steel Flanges Category
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, image_url, pdf_datasheet_url, is_featured) VALUES
('Weld Neck Flange', 'weld-neck-flange', 'FLG-WN-01', 'FWN-1', (SELECT id FROM categories WHERE slug = 'stainless-steel-flanges'),
'Weld neck flange for high-pressure applications with smooth transition to pipe.',
'{"Standard": "DIN or ANSI", "Face": "Raised Face RF", "Pressure": "PN16 or PN25"}',
'304', ARRAY['DN25', 'DN50', 'DN80', 'DN100', 'DN150', 'DN200'],
'https://images.unsplash.com/photo-1609761935692-44e975b7a3be?w=800',
NULL, true),
('Blind Flange', 'blind-flange', 'FLG-BL-01', 'FBL-1', (SELECT id FROM categories WHERE slug = 'stainless-steel-flanges'),
'Solid blind flange for closing pipe ends and creating pressure-tight seals.',
'{"Standard": "DIN or ANSI", "Type": "Blind", "Face": "Raised Face RF"}',
'316', ARRAY['DN25', 'DN50', 'DN100', 'DN150', 'DN200'],
'https://images.unsplash.com/photo-1580894732930-0babd108d3ee?w=800',
NULL, false
) ON CONFLICT (sku) DO NOTHING;

-- Insert Products for Pipe Fittings Category
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, image_url, pdf_datasheet_url, is_featured) VALUES
('Concentric Reducer', 'concentric-reducer', 'PIP-RED-01', 'PRC-1', (SELECT id FROM categories WHERE slug = 'pipe-fittings'),
'Concentric reducer for reducing pipe diameter while maintaining centered flow.',
'{"Type": "Concentric", "Ends": "Butt weld", "Standard": "ASTM A403"}',
'304', ARRAY['2x1.5', '3x2', '4x3', '6x4'],
'https://images.unsplash.com/photo-1615111784767-4d7f92680d45?w=800',
NULL, false),
('Stainless Tee Equal', 'stainless-tee-equal', 'PIP-TEE-01', 'PTE-1', (SELECT id FROM categories WHERE slug = 'pipe-fittings'),
'Equal tee fitting for splitting or combining flow in piping systems.',
'{"Type": "Equal Tee", "Ends": "Butt weld", "Standard": "ASTM A403"}',
'316', ARRAY['1"', '1.5"', '2"', '3"', '4"'],
'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800',
NULL, true
) ON CONFLICT (sku) DO NOTHING;

-- Insert Products for Steam Equipment Category
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, image_url, pdf_datasheet_url, is_featured) VALUES
('Float Steam Trap', 'float-steam-trap', 'STM-TRP-01', 'STF-1', (SELECT id FROM categories WHERE slug = 'steam-equipment'),
'Mechanical float-type steam trap for continuous condensate removal in process heating.',
'{"Type": "Float and Thermostatic", "Body": "Cast Iron or Stainless", "MaxPressure": "21 bar", "MaxTemp": "250°C"}',
'304', ARRAY['DN15', 'DN20', 'DN25', 'DN40'],
'https://images.unsplash.com/photo-1563720660852-59c4e26e7830?w=800',
NULL, true),
('Steam Separator', 'steam-separator', 'STM-SEP-01', 'SSP-1', (SELECT id FROM categories WHERE slug = 'steam-equipment'),
'Centrifugal steam separator for removing entrained water droplets from steam lines.',
'{"Type": "Centrifugal", "Efficiency": "99 percent", "MaxPressure": "PN25"}',
'304', ARRAY['DN25', 'DN50', 'DN80', 'DN100'],
'https://images.unsplash.com/photo-1615811361523-6d03b1f77aa8?w=800',
NULL, false
) ON CONFLICT (sku) DO NOTHING;

-- Insert Products for Pressure Gauges Category
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, image_url, pdf_datasheet_url, is_featured) VALUES
('Stainless Pressure Gauge', 'stainless-pressure-gauge', 'GAG-SS-01', 'GSS-1', (SELECT id FROM categories WHERE slug = 'pressure-gauges'),
'Industrial pressure gauge with stainless steel case for corrosive environments.',
'{"Range": "0-10 bar various", "Dial": "100mm", "Accuracy": "1.6 percent", "Connection": "1/2 inch NPT or BSP"}',
'316', ARRAY['0-4 bar', '0-10 bar', '0-16 bar', '0-25 bar', '0-40 bar'],
'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
NULL, true),
('Diaphragm Pressure Gauge', 'diaphragm-pressure-gauge', 'GAG-DIA-01', 'GDI-1', (SELECT id FROM categories WHERE slug = 'pressure-gauges'),
'Diaphragm seal pressure gauge for viscous and corrosive media measurement.',
'{"Type": "Diaphragm Seal", "Accuracy": "1.0 percent", "Materials": "316L Diaphragm"}',
'316', ARRAY['0-1 bar', '0-2.5 bar', '0-6 bar', '0-10 bar'],
'https://images.unsplash.com/photo-1518709268481-1f9539bc89a6?w=800',
NULL, false
) ON CONFLICT (sku) DO NOTHING;

-- Insert Products for Industrial Instruments Category
INSERT INTO products (name, slug, sku, reference, category_id, description, technical_specifications, material, available_sizes, image_url, pdf_datasheet_url, is_featured) VALUES
('RTD Temperature Sensor', 'rtd-temperature-sensor', 'INS-RTD-01', 'IRT-1', (SELECT id FROM categories WHERE slug = 'industrial-instruments'),
'PT100 RTD temperature sensor with sanitary thermowell for food processing.',
'{"Type": "PT100 or PT1000", "Accuracy": "Class A or B", "Connection": "Tri-clamp or Threaded", "Length": "Custom"}',
'304', ARRAY['50mm', '100mm', '150mm', '200mm', '300mm'],
'https://images.unsplash.com/photo-1572961778304-5c3db60e3b93?w=800',
NULL, false),
('Electromagnetic Flow Meter', 'electromagnetic-flow-meter', 'INS-EMF-01', 'IEM-1', (SELECT id FROM categories WHERE slug = 'industrial-instruments'),
'Electromagnetic flow meter for accurate measurement of conductive liquids.',
'{"Type": "Electromagnetic", "Accuracy": "0.5 percent", "Lining": "PTFE", "Electrode": "316L or Hastelloy"}',
'304', ARRAY['DN25', 'DN50', 'DN80', 'DN100', 'DN150'],
'https://images.unsplash.com/photo-1563989269965-c4e1e23e90a0?w=800',
NULL, true
) ON CONFLICT (sku) DO NOTHING;

-- Insert Product Relations (for cross-selling)
INSERT INTO product_relations (product_id, related_product_id)
SELECT 
    p1.id, 
    p2.id 
FROM products p1 
CROSS JOIN products p2 
WHERE p1.sku = 'TC-FER-01' AND p2.sku IN ('VAL-BAL-01', 'TC-ELB-01', 'SMS-UNI-01', 'DIN-CLP-01')
ON CONFLICT (product_id, related_product_id) DO NOTHING;

INSERT INTO product_relations (product_id, related_product_id)
SELECT 
    p1.id, 
    p2.id 
FROM products p1 
CROSS JOIN products p2 
WHERE p1.sku = 'VAL-BAL-01' AND p2.sku IN ('TC-FER-01', 'VAL-BUT-01', 'STM-TRP-01', 'GAG-SS-01')
ON CONFLICT (product_id, related_product_id) DO NOTHING;