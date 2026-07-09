import './globals.css';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'INO-VAP ZONE | Premium Stainless Steel Industrial Products',
  description: 'Leading supplier of stainless steel industrial products in Algeria.',
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body className="min-h-screen bg-white">{children}</body>
    </html>
  );
}
