import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

/**
 * Format a number as Sri Lankan Rupees
 * e.g. 3500 → "Rs 3,500"
 */
export function formatPrice(amount: number): string {
  return `Rs ${amount.toLocaleString("en-LK")}`;
}

/**
 * Format a date string to a friendly display
 * e.g. "2025-01-15" → "15 Jan 2025"
 */
export function formatDate(dateStr: string): string {
  return new Date(dateStr).toLocaleDateString("en-LK", {
    day: "numeric",
    month: "short",
    year: "numeric",
  });
}

/**
 * Slugify a product name
 * e.g. "Pink Dream Bouquet" → "pink-dream-bouquet"
 */
export function slugify(text: string): string {
  return text
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9\s-]/g, "")
    .replace(/\s+/g, "-")
    .replace(/-+/g, "-");
}

/**
 * Get the lowest price from a product's size variants
 */
export function getStartingPrice(
  sizes: { price: number }[] | undefined
): number {
  if (!sizes || sizes.length === 0) return 0;
  return Math.min(...sizes.map((s) => s.price));
}

/**
 * Check if any size variant is in stock
 */
export function isInStock(sizes: { stock_qty: number }[] | undefined): boolean {
  if (!sizes || sizes.length === 0) return false;
  return sizes.some((s) => s.stock_qty > 0);
}

/**
 * Truncate text to a maximum length
 */
export function truncate(text: string, maxLength: number): string {
  if (text.length <= maxLength) return text;
  return text.slice(0, maxLength - 3) + "...";
}

/**
 * Get initials from a name (for avatar fallbacks)
 */
export function getInitials(name: string): string {
  return name
    .split(" ")
    .map((n) => n[0])
    .join("")
    .toUpperCase()
    .slice(0, 2);
}

/**
 * Generate CSV content from an array of objects
 */
export function toCSV(data: Record<string, unknown>[], headers?: string[]): string {
  if (data.length === 0) return "";
  const keys = headers ?? Object.keys(data[0]);
  const rows = [
    keys.join(","),
    ...data.map((row) =>
      keys
        .map((k) => {
          const val = String(row[k] ?? "");
          return val.includes(",") ? `"${val}"` : val;
        })
        .join(",")
    ),
  ];
  return rows.join("\n");
}

/**
 * Download a string as a file
 */
export function downloadFile(content: string, filename: string, mimeType: string) {
  const blob = new Blob([content], { type: mimeType });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  a.click();
  URL.revokeObjectURL(url);
}
