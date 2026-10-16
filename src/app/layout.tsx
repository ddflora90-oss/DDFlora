import type { Metadata } from "next";
import { Cormorant_Garamond, Lato } from "next/font/google";
import "./globals.css";
import { SITE_CONFIG } from "@/lib/config";
import FloatingWhatsApp from "@/components/storefront/FloatingWhatsApp";

const cormorant = Cormorant_Garamond({
  subsets: ["latin"],
  weight: ["300", "400", "500", "600", "700"],
  style: ["normal", "italic"],
  variable: "--font-cormorant",
  display: "swap",
});

const lato = Lato({
  subsets: ["latin"],
  weight: ["300", "400", "700", "900"],
  variable: "--font-lato",
  display: "swap",
});

export const metadata: Metadata = {
  title: {
    default: `${SITE_CONFIG.businessName} – ${SITE_CONFIG.tagline}`,
    template: `%s | ${SITE_CONFIG.businessName}`,
  },
  description: SITE_CONFIG.description,
  keywords: [
    "flower bouquet Sri Lanka",
    "flower delivery Colombo",
    "wedding flowers Sri Lanka",
    "birthday bouquet",
    "DD Flora",
    "floral design Sri Lanka",
  ],
  authors: [{ name: "DD Flora" }],
  metadataBase: new URL(SITE_CONFIG.siteUrl),
  openGraph: {
    title: `${SITE_CONFIG.businessName} – ${SITE_CONFIG.tagline}`,
    description: SITE_CONFIG.description,
    url: SITE_CONFIG.siteUrl,
    siteName: SITE_CONFIG.businessName,
    locale: "en_LK",
    type: "website",
    images: [
      {
        url: "/og-image.jpg",
        width: 1200,
        height: 630,
        alt: "DD Flora – Flower & Floral Design",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: `${SITE_CONFIG.businessName} – ${SITE_CONFIG.tagline}`,
    description: SITE_CONFIG.description,
    images: ["/og-image.jpg"],
  },
  icons: {
    icon: "/favicon.ico",
    apple: "/apple-touch-icon.png",
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`${cormorant.variable} ${lato.variable}`}>
      <body className="bg-cream font-lato text-brown antialiased">
        {children}
        <FloatingWhatsApp />
      </body>
    </html>
  );
}
