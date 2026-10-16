-- ============================================================
-- DD Flora – Supabase Database Schema
-- Run this SQL in your Supabase project's SQL Editor
-- ============================================================

-- ─── PRODUCTS ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS products (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug        TEXT UNIQUE NOT NULL,
  name        TEXT NOT NULL,
  description TEXT,
  flowers     TEXT[],
  category    TEXT NOT NULL CHECK (category IN (
    'Birthday','Anniversary','Graduation','Love & Romance',
    'Get Well','Wedding','Just Because','Other'
  )),
  images      TEXT[] DEFAULT '{}',
  cost_price  NUMERIC(10,2),
  visible     BOOLEAN DEFAULT true,
  created_at  TIMESTAMPTZ DEFAULT now()
);

-- ─── PRODUCT SIZE VARIANTS ────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS product_sizes (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id          UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  label               TEXT NOT NULL,
  price               NUMERIC(10,2) NOT NULL,
  stock_qty           INTEGER DEFAULT 0,
  low_stock_threshold INTEGER DEFAULT 5
);

-- ─── ORDERS ──────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS orders (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_name   TEXT NOT NULL,
  customer_phone  TEXT,
  product_id      UUID REFERENCES products(id) ON DELETE SET NULL,
  product_size_id UUID REFERENCES product_sizes(id) ON DELETE SET NULL,
  quantity        INTEGER NOT NULL DEFAULT 1,
  selling_price   NUMERIC(10,2) NOT NULL,
  delivery_charge NUMERIC(10,2) DEFAULT 0,
  order_date      DATE NOT NULL DEFAULT CURRENT_DATE,
  delivery_date   DATE,
  status          TEXT NOT NULL DEFAULT 'Pending'
    CHECK (status IN ('Pending','Confirmed','Delivered','Cancelled')),
  payment_status  TEXT NOT NULL DEFAULT 'Unpaid'
    CHECK (payment_status IN ('Paid','Unpaid')),
  notes           TEXT,
  created_at      TIMESTAMPTZ DEFAULT now()
);

-- Auto-reduce stock when an order is marked as Delivered
CREATE OR REPLACE FUNCTION reduce_stock_on_delivery()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status = 'Delivered' AND OLD.status <> 'Delivered' THEN
    UPDATE product_sizes
    SET stock_qty = GREATEST(stock_qty - NEW.quantity, 0)
    WHERE id = NEW.product_size_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_reduce_stock ON orders;
CREATE TRIGGER trg_reduce_stock
  AFTER UPDATE ON orders
  FOR EACH ROW
  EXECUTE FUNCTION reduce_stock_on_delivery();

-- ─── STOCK ITEMS (Raw Materials) ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS stock_items (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name                TEXT NOT NULL,
  unit                TEXT NOT NULL,
  quantity            NUMERIC(10,2) DEFAULT 0,
  cost_per_unit       NUMERIC(10,2),
  supplier            TEXT,
  low_stock_threshold NUMERIC(10,2) DEFAULT 10,
  created_at          TIMESTAMPTZ DEFAULT now()
);

-- ─── STOCK MOVEMENTS (In / Out) ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS stock_movements (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stock_item_id UUID NOT NULL REFERENCES stock_items(id) ON DELETE CASCADE,
  type          TEXT NOT NULL CHECK (type IN ('IN','OUT')),
  quantity      NUMERIC(10,2) NOT NULL,
  notes         TEXT,
  created_at    TIMESTAMPTZ DEFAULT now()
);

-- Keep stock_items.quantity in sync with movements
CREATE OR REPLACE FUNCTION update_stock_quantity()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.type = 'IN' THEN
    UPDATE stock_items SET quantity = quantity + NEW.quantity WHERE id = NEW.stock_item_id;
  ELSE
    UPDATE stock_items SET quantity = GREATEST(quantity - NEW.quantity, 0) WHERE id = NEW.stock_item_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_update_stock ON stock_movements;
CREATE TRIGGER trg_update_stock
  AFTER INSERT ON stock_movements
  FOR EACH ROW
  EXECUTE FUNCTION update_stock_quantity();

-- ─── EXPENSES ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS expenses (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  date       DATE NOT NULL DEFAULT CURRENT_DATE,
  category   TEXT NOT NULL CHECK (category IN (
    'Flowers','Packaging','Transport','Rent','Marketing','Other'
  )),
  amount     NUMERIC(10,2) NOT NULL,
  notes      TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- ─── ROW LEVEL SECURITY ──────────────────────────────────────────────────────

-- Products: public can read visible ones; only authenticated can write
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can read visible products"
  ON products FOR SELECT
  USING (visible = true);

CREATE POLICY "Authenticated users can manage products"
  ON products FOR ALL
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

-- Product sizes: public can read; only authenticated can write
ALTER TABLE product_sizes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can read product sizes"
  ON product_sizes FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can manage product sizes"
  ON product_sizes FOR ALL
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

-- Orders: authenticated only
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated only – orders"
  ON orders FOR ALL
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

-- Stock items: authenticated only
ALTER TABLE stock_items ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated only – stock items"
  ON stock_items FOR ALL
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

-- Stock movements: authenticated only
ALTER TABLE stock_movements ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated only – stock movements"
  ON stock_movements FOR ALL
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

-- Expenses: authenticated only
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated only – expenses"
  ON expenses FOR ALL
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

-- ─── STORAGE BUCKET ──────────────────────────────────────────────────────────
-- Run this in the Supabase dashboard > Storage, or via API:
-- Create a bucket named "product-images" with public access enabled.
-- INSERT INTO storage.buckets (id, name, public) VALUES ('product-images', 'product-images', true);
