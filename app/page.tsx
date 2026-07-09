import { createClient } from '@/lib/supabase/server';

export default async function HomePage() {
  const supabase = await createClient();
  const { data: categories } = await supabase.from('categories').select('*').order('display_order');
  const { data: products } = await supabase.from('products').select('*, categories(*)').limit(8);

  return (
    <div className="min-h-screen">
      {/* Hero */}
      <section className="bg-gradient-to-br from-slate-900 to-slate-700 text-white py-24">
        <div className="container mx-auto px-4">
          <h1 className="text-5xl font-bold mb-4">INO-VAP ZONE</h1>
          <p className="text-xl text-slate-300">Premium Stainless Steel Industrial Products</p>
        </div>
      </section>

      {/* Categories */}
      <section className="py-16 bg-slate-50">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl font-bold mb-8 text-slate-900">Product Categories</h2>
          <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 gap-4">
            {categories?.map((cat: any) => (
              <a
                key={cat.id}
                href={`/products/${cat.slug}`}
                className="p-4 bg-white rounded-lg border border-slate-200 hover:shadow-lg transition-shadow"
              >
                <h3 className="font-semibold text-slate-900">{cat.name}</h3>
              </a>
            ))}
          </div>
        </div>
      </section>

      {/* Featured Products */}
      <section className="py-16">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl font-bold mb-8 text-slate-900">Featured Products</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            {products?.map((product: any) => (
              <div key={product.id} className="border border-slate-200 rounded-lg p-4 hover:shadow-lg transition-shadow">
                <div className="aspect-square bg-slate-100 rounded mb-4 flex items-center justify-center">
                  {product.image_url ? (
                    <img src={product.image_url} alt={product.name} className="w-full h-full object-cover rounded" />
                  ) : (
                    <span className="text-slate-400">No Image</span>
                  )}
                </div>
                <span className="text-xs text-slate-500 uppercase">{product.categories?.name}</span>
                <h3 className="font-semibold text-slate-900">{product.name}</h3>
                <p className="text-sm text-slate-600 mt-1">SKU: {product.sku}</p>
              </div>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
}
