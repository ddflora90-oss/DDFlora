/**
 * DD Flora – Global Site Configuration
 *
 * This is the single file to change for:
 *  - WhatsApp number
 *  - Social media links
 *  - Contact details
 *  - Business name / tagline
 */

export const SITE_CONFIG = {
  // ─── WhatsApp ─────────────────────────────────────────────────────────────
  // Format: country code + number, NO "+" sign, NO spaces
  // Example: Sri Lanka (+94) → "94771234567"
  whatsappNumber: "94771234567",

  // ─── Business Info ────────────────────────────────────────────────────────
  businessName: "DD Flora",
  tagline: "Flowers Crafted with Love",
  description:
    "Sri Lanka's most elegant floral design studio. Handcrafted bouquets for every occasion — birthdays, anniversaries, weddings, and more.",
  email: "ddflora.lk@gmail.com",
  phone: "+94 77 123 4567",
  address: "Colombo, Sri Lanka",
  location: "Colombo, Sri Lanka",

  // ─── Social Media ─────────────────────────────────────────────────────────
  instagram: "https://instagram.com/ddflora.lk",
  facebook: "https://facebook.com/ddflora.lk",

  // ─── Delivery Info ────────────────────────────────────────────────────────
  deliveryAreas: ["Colombo", "Gampaha", "Kalutara"],
  deliveryCharge: 350, // LKR default
  freeDeliveryAbove: 5000, // LKR order value for free delivery
  orderCutoffTime: "12:00 PM",

  // ─── Site URL (update when deployed) ────────────────────────────────────
  siteUrl: process.env.NEXT_PUBLIC_SITE_URL || "https://ddflora.lk",
} as const;
