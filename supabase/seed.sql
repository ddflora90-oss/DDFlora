-- ============================================================
-- DD Flora – Seed Data
-- Run AFTER schema.sql
-- Creates 8 sample bouquets with placeholder image URLs
-- ============================================================

-- ─── Products ────────────────────────────────────────────────────────────────
INSERT INTO products (id, slug, name, description, flowers, category, images, cost_price, visible) VALUES
(
  'a1b2c3d4-0001-0000-0000-000000000001',
  'pink-paradise',
  'Pink Paradise',
  'A dreamy arrangement of the softest pink roses and fluffy peonies, wrapped in blush satin ribbon. Perfect for telling someone they are simply wonderful.',
  ARRAY['Pink Roses', 'Peonies', 'Baby''s Breath', 'Eucalyptus'],
  'Birthday',
  ARRAY['/images/sample/pink-paradise-1.jpg', '/images/sample/pink-paradise-2.jpg'],
  1200,
  true
),
(
  'a1b2c3d4-0002-0000-0000-000000000002',
  'eternal-love',
  'Eternal Love',
  'Deep red roses intertwined with burgundy dahlias and dark foliage — a bold, passionate statement for the one who holds your heart.',
  ARRAY['Red Roses', 'Burgundy Dahlias', 'Dark Foliage', 'Eucalyptus'],
  'Anniversary',
  ARRAY['/images/sample/eternal-love-1.jpg', '/images/sample/eternal-love-2.jpg'],
  1500,
  true
),
(
  'a1b2c3d4-0003-0000-0000-000000000003',
  'sunshine-bloom',
  'Sunshine Bloom',
  'Bright yellow sunflowers and cheerful gerberas arranged with lush greenery to lift any spirit. The perfect way to say congratulations!',
  ARRAY['Sunflowers', 'Yellow Gerberas', 'Greenery', 'Wax Flowers'],
  'Graduation',
  ARRAY['/images/sample/sunshine-bloom-1.jpg'],
  900,
  true
),
(
  'a1b2c3d4-0004-0000-0000-000000000004',
  'lavender-dreams',
  'Lavender Dreams',
  'Delicate lavender stems and soft purple statice, tied with gold ribbon and nestled in rustic kraft paper. A gentle, romantic touch.',
  ARRAY['Lavender', 'Purple Statice', 'White Gypsophila', 'Silver Leaves'],
  'Love & Romance',
  ARRAY['/images/sample/lavender-dreams-1.jpg', '/images/sample/lavender-dreams-2.jpg'],
  1100,
  true
),
(
  'a1b2c3d4-0005-0000-0000-000000000005',
  'gentle-healing',
  'Gentle Healing',
  'A soft, comforting arrangement of white lilies, chamomile, and pastel pink roses — designed to bring peace and warmth to someone who needs it.',
  ARRAY['White Lilies', 'Chamomile', 'Pastel Pink Roses', 'Baby''s Breath'],
  'Get Well',
  ARRAY['/images/sample/gentle-healing-1.jpg'],
  1050,
  true
),
(
  'a1b2c3d4-0006-0000-0000-000000000006',
  'bridal-bliss',
  'Bridal Bliss',
  'An elegant, cascading bridal bouquet of ivory roses, white orchids, and trailing stephanotis — timeless beauty for your perfect day.',
  ARRAY['Ivory Roses', 'White Orchids', 'Stephanotis', 'Greenery', 'Satin Ribbon'],
  'Wedding',
  ARRAY['/images/sample/bridal-bliss-1.jpg', '/images/sample/bridal-bliss-2.jpg', '/images/sample/bridal-bliss-3.jpg'],
  2500,
  true
),
(
  'a1b2c3d4-0007-0000-0000-000000000007',
  'coral-sunset',
  'Coral Sunset',
  'A vibrant mix of coral roses, orange spray roses, and peachy ranunculus that captures the warmth of a Sri Lankan sunset. Just because.',
  ARRAY['Coral Roses', 'Orange Spray Roses', 'Ranunculus', 'Gerberas'],
  'Just Because',
  ARRAY['/images/sample/coral-sunset-1.jpg'],
  1350,
  true
),
(
  'a1b2c3d4-0008-0000-0000-000000000008',
  'white-elegance',
  'White Elegance',
  'Pure white roses, gardenia blooms, and silver dusty miller arranged in a classic round bouquet. Sophisticated and understated.',
  ARRAY['White Roses', 'Gardenia', 'Dusty Miller', 'White Lisianthus'],
  'Anniversary',
  ARRAY['/images/sample/white-elegance-1.jpg', '/images/sample/white-elegance-2.jpg'],
  1650,
  true
);

-- ─── Product Sizes ───────────────────────────────────────────────────────────
INSERT INTO product_sizes (product_id, label, price, stock_qty, low_stock_threshold) VALUES
-- Pink Paradise
('a1b2c3d4-0001-0000-0000-000000000001', 'Small',  2200, 8, 3),
('a1b2c3d4-0001-0000-0000-000000000001', 'Medium', 3500, 5, 3),
('a1b2c3d4-0001-0000-0000-000000000001', 'Large',  5000, 3, 2),
-- Eternal Love
('a1b2c3d4-0002-0000-0000-000000000002', 'Small',  2800, 6, 3),
('a1b2c3d4-0002-0000-0000-000000000002', 'Medium', 4200, 4, 2),
('a1b2c3d4-0002-0000-0000-000000000002', 'Large',  6000, 2, 2),
-- Sunshine Bloom
('a1b2c3d4-0003-0000-0000-000000000003', 'Small',  1800, 10, 5),
('a1b2c3d4-0003-0000-0000-000000000003', 'Medium', 2800, 7,  3),
('a1b2c3d4-0003-0000-0000-000000000003', 'Large',  4000, 4,  2),
-- Lavender Dreams
('a1b2c3d4-0004-0000-0000-000000000004', 'Small',  2000, 7, 3),
('a1b2c3d4-0004-0000-0000-000000000004', 'Medium', 3200, 5, 2),
-- Gentle Healing
('a1b2c3d4-0005-0000-0000-000000000005', 'Small',  1900, 9, 4),
('a1b2c3d4-0005-0000-0000-000000000005', 'Medium', 3000, 6, 3),
-- Bridal Bliss
('a1b2c3d4-0006-0000-0000-000000000006', 'Standard', 8500, 5, 2),
('a1b2c3d4-0006-0000-0000-000000000006', 'Premium',  12000, 3, 1),
-- Coral Sunset
('a1b2c3d4-0007-0000-0000-000000000007', 'Small',  2400, 8, 3),
('a1b2c3d4-0007-0000-0000-000000000007', 'Medium', 3800, 5, 2),
('a1b2c3d4-0007-0000-0000-000000000007', 'Large',  5500, 2, 2),
-- White Elegance
('a1b2c3d4-0008-0000-0000-000000000008', 'Small',  2600, 6, 3),
('a1b2c3d4-0008-0000-0000-000000000008', 'Medium', 4000, 4, 2),
('a1b2c3d4-0008-0000-0000-000000000008', 'Large',  5800, 2, 1);

-- ─── Stock Items (Raw Materials) ─────────────────────────────────────────────
INSERT INTO stock_items (name, unit, quantity, cost_per_unit, supplier, low_stock_threshold) VALUES
('Red Roses',       'stems', 120, 45, 'Kandy Flower Supplier', 30),
('Pink Roses',      'stems', 200, 40, 'Kandy Flower Supplier', 40),
('White Roses',     'stems',  80, 42, 'Kandy Flower Supplier', 20),
('Coral Roses',     'stems',  60, 44, 'Kandy Flower Supplier', 15),
('Sunflowers',      'stems',  50, 55, 'Colombo Blooms',        10),
('White Lilies',    'stems',  40, 65, 'Colombo Blooms',        10),
('Lavender',        'bunches', 30, 90, 'Nuwara Eliya Farm',    8),
('Baby''s Breath',  'bunches', 60, 35, 'Kandy Flower Supplier', 15),
('Eucalyptus',      'stems', 100, 25, 'Colombo Blooms',        20),
('Peonies',         'stems',  35, 120, 'Import – Colombo',     8),
('Wrapping Paper',  'sheets', 500, 15, 'Colombo Packaging Co', 100),
('Kraft Paper',     'sheets', 300, 12, 'Colombo Packaging Co',  80),
('Satin Ribbon',    'meters', 150, 85, 'Fashion Accessories',   30),
('Gold Ribbon',     'meters',  80, 95, 'Fashion Accessories',   20),
('Cellophane Wrap', 'sheets', 200, 18, 'Colombo Packaging Co',  50);

-- ─── Sample Expenses ─────────────────────────────────────────────────────────
INSERT INTO expenses (date, category, amount, notes) VALUES
(CURRENT_DATE - 7,  'Flowers',    12500, 'Weekly flower purchase – Kandy supplier'),
(CURRENT_DATE - 7,  'Packaging',   3200, 'Wrapping paper and ribbons restock'),
(CURRENT_DATE - 14, 'Transport',   1500, 'Delivery runs – Colombo 7 area'),
(CURRENT_DATE - 14, 'Marketing',   2000, 'Instagram boosted post'),
(CURRENT_DATE - 30, 'Flowers',    15000, 'Monthly bulk order – Nuwara Eliya lavender + roses'),
(CURRENT_DATE - 30, 'Rent',       15000, 'Monthly studio rent');
