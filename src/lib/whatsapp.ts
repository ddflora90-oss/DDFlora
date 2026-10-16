import { SITE_CONFIG } from "@/lib/config";

export interface WhatsAppOrderParams {
  productName: string;
  size?: string;
  price: number;
  productUrl?: string;
}

/**
 * Builds a WhatsApp wa.me URL with a pre-filled order message.
 * The message template matches the owner's requested format.
 */
export function buildWhatsAppOrderURL({
  productName,
  size,
  price,
  productUrl,
}: WhatsAppOrderParams): string {
  const sizeStr = size ? ` – ${size}` : "";
  const linkStr = productUrl ? ` Product link: ${productUrl}.` : "";
  const message =
    `Hi DD Flora! I'd like to order: ${productName}${sizeStr} – Rs ${price.toLocaleString("en-LK")}.${linkStr} Delivery date: ___ . Delivery address: ___ .`;

  return `https://wa.me/${SITE_CONFIG.whatsappNumber}?text=${encodeURIComponent(message)}`;
}

/**
 * General WhatsApp chat link (no pre-filled text).
 */
export function buildWhatsAppChatURL(): string {
  return `https://wa.me/${SITE_CONFIG.whatsappNumber}`;
}

/**
 * WhatsApp link for general enquiries.
 */
export function buildWhatsAppEnquiryURL(message?: string): string {
  const text = message ?? `Hi DD Flora! I'd like to enquire about your flowers and bouquets.`;
  return `https://wa.me/${SITE_CONFIG.whatsappNumber}?text=${encodeURIComponent(text)}`;
}
