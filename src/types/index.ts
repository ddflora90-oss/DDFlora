/**
 * DD Flora – Shared TypeScript Types
 */

// ─── Products ──────────────────────────────────────────────────────────────

export type Occasion =
  | "Birthday"
  | "Anniversary"
  | "Graduation"
  | "Love & Romance"
  | "Get Well"
  | "Wedding"
  | "Just Because"
  | "Other";

export interface ProductSize {
  id: string;
  product_id: string;
  label: "Small" | "Medium" | "Large" | string;
  price: number;
  stock_qty: number;
  low_stock_threshold: number;
}

export interface Product {
  id: string;
  slug: string;
  name: string;
  description: string | null;
  flowers: string[] | null;
  category: Occasion;
  images: string[];
  cost_price: number | null;
  visible: boolean;
  created_at: string;
  product_sizes?: ProductSize[];
}

// ─── Orders ────────────────────────────────────────────────────────────────

export type OrderStatus = "Pending" | "Confirmed" | "Delivered" | "Cancelled";
export type PaymentStatus = "Paid" | "Unpaid";

export interface Order {
  id: string;
  customer_name: string;
  customer_phone: string | null;
  product_id: string | null;
  product_size_id: string | null;
  quantity: number;
  selling_price: number;
  delivery_charge: number;
  order_date: string;
  delivery_date: string | null;
  status: OrderStatus;
  payment_status: PaymentStatus;
  notes: string | null;
  created_at: string;
  products?: Pick<Product, "id" | "name" | "slug" | "images">;
  product_sizes?: Pick<ProductSize, "id" | "label" | "price">;
}

// ─── Stock ─────────────────────────────────────────────────────────────────

export interface StockItem {
  id: string;
  name: string;
  unit: string;
  quantity: number;
  cost_per_unit: number | null;
  supplier: string | null;
  low_stock_threshold: number;
  created_at: string;
}

export type StockMovementType = "IN" | "OUT";

export interface StockMovement {
  id: string;
  stock_item_id: string;
  type: StockMovementType;
  quantity: number;
  notes: string | null;
  created_at: string;
  stock_items?: Pick<StockItem, "id" | "name" | "unit">;
}

// ─── Expenses ──────────────────────────────────────────────────────────────

export type ExpenseCategory =
  | "Flowers"
  | "Packaging"
  | "Transport"
  | "Rent"
  | "Marketing"
  | "Other";

export interface Expense {
  id: string;
  date: string;
  category: ExpenseCategory;
  amount: number;
  notes: string | null;
  created_at: string;
}

// ─── Dashboard / Reports ───────────────────────────────────────────────────

export interface MonthlySummary {
  month: string; // "2025-01"
  income: number;
  expenses: number;
  profit: number;
  order_count: number;
}

export interface DashboardStats {
  todayIncome: number;
  monthIncome: number;
  monthExpenses: number;
  monthProfit: number;
  todayOrders: number;
  monthOrders: number;
  lowStockItems: StockItem[];
  monthlySummaries: MonthlySummary[];
}

// ─── Filters ───────────────────────────────────────────────────────────────

export interface ProductFilters {
  category?: Occasion | "All";
  minPrice?: number;
  maxPrice?: number;
  search?: string;
  sort?: "newest" | "price_asc" | "price_desc";
}
