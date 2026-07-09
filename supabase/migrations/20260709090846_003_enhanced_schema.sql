-- Add new columns to products table
ALTER TABLE products ADD COLUMN IF NOT EXISTS brand text DEFAULT 'INO-VAP ZONE';
ALTER TABLE products ADD COLUMN IF NOT EXISTS connection_type text;
ALTER TABLE products ADD COLUMN IF NOT EXISTS standard text;
ALTER TABLE products ADD COLUMN IF NOT EXISTS applications text[] DEFAULT '{}';
ALTER TABLE products ADD COLUMN IF NOT EXISTS dimensions jsonb DEFAULT '{}';
ALTER TABLE products ADD COLUMN IF NOT EXISTS weight_kg decimal(10,3);
ALTER TABLE products ADD COLUMN IF NOT EXISTS pressure_rating text;
ALTER TABLE products ADD COLUMN IF NOT EXISTS temperature_range text;
ALTER TABLE products ADD COLUMN IF NOT EXISTS surface_finish text;
ALTER TABLE products ADD COLUMN IF NOT EXISTS is_accessory boolean DEFAULT false;
ALTER TABLE products ADD COLUMN IF NOT EXISTS parent_product_id uuid REFERENCES products(id) ON DELETE SET NULL;
ALTER TABLE products ADD COLUMN IF NOT EXISTS downloads_count integer DEFAULT 0;
ALTER TABLE products ADD COLUMN IF NOT EXISTS gallery_images text[] DEFAULT '{}';

-- Create downloads table
CREATE TABLE IF NOT EXISTS downloads (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  type text NOT NULL CHECK (type IN ('datasheet', 'certificate', 'cad', 'manual', 'other')),
  title text NOT NULL,
  file_url text,
  filename text,
  file_size_kb integer,
  downloads_count integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create favorites table (session-based for guests)
CREATE TABLE IF NOT EXISTS favorites (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id text NOT NULL,
  product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  created_at timestamptz DEFAULT now(),
  UNIQUE(session_id, product_id)
);

-- Create recently viewed table
CREATE TABLE IF NOT EXISTS recently_viewed (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id text NOT NULL,
  product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  viewed_at timestamptz DEFAULT now(),
  UNIQUE(session_id, product_id)
);

-- Create indexes for new columns
CREATE INDEX IF NOT EXISTS idx_products_brand ON products(brand);
CREATE INDEX IF NOT EXISTS idx_products_connection_type ON products(connection_type);
CREATE INDEX IF NOT EXISTS idx_products_standard ON products(standard);
CREATE INDEX IF NOT EXISTS idx_products_is_accessory ON products(is_accessory);
CREATE INDEX IF NOT EXISTS idx_products_parent_product_id ON products(parent_product_id);
CREATE INDEX IF NOT EXISTS idx_downloads_product_id ON downloads(product_id);
CREATE INDEX IF NOT EXISTS idx_favorites_session_id ON favorites(session_id);
CREATE INDEX IF NOT EXISTS idx_recently_viewed_session_id ON recently_viewed(session_id);

-- Enable RLS on new tables
ALTER TABLE downloads ENABLE ROW LEVEL SECURITY;
ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE recently_viewed ENABLE ROW LEVEL SECURITY;

-- Downloads: public read
DROP POLICY IF EXISTS "public_read_downloads" ON downloads;
CREATE POLICY "public_read_downloads" ON downloads FOR SELECT
  TO anon, authenticated USING (true);

-- Favorites: public read/write (session-based)
DROP POLICY IF EXISTS "public_all_favorites" ON favorites;
CREATE POLICY "public_all_favorites" ON favorites FOR ALL
  TO anon, authenticated USING (true) WITH CHECK (true);

-- Recently viewed: public read/write
DROP POLICY IF EXISTS "public_all_recently_viewed" ON recently_viewed;
CREATE POLICY "public_all_recently_viewed" ON recently_viewed FOR ALL
  TO anon, authenticated USING (true) WITH CHECK (true);