# Protap Clothes – সেটআপ ও হস্তান্তর নির্দেশিকা

এই ফোল্ডারে ৪টা ফাইল আছে: `index.html` (পুরো সাইট), `hero.mp4` (হোমপেজের ভিডিও), `supabase-setup.sql` (database), এই README।
**তিনটা ফাইল (index.html, hero.mp4) একই ফোল্ডারে থাকতে হবে।**

## ধাপ ১: Database বানান (Supabase, বিনামূল্যে)
1. https://supabase.com এ **দোকান মালিকের নিজের email** দিয়ে account খুলুন → **New project** (নাম: protap, একটা শক্ত database password দিন, region: Singapore)।
2. বাঁ পাশে **SQL Editor → New query**। `supabase-setup.sql` ফাইল খুলে সব লেখা কপি করে বসান।
   **আগে ফাইলের ভেতরে `insert into admins` লাইনের email বদলে মালিকের email দিন।** তারপর **Run** চাপুন।
3. **Project Settings → API** তে গিয়ে **Project URL** আর **anon public key** কপি করুন।
4. `index.html` টেক্সট এডিটরে (Notepad ঠিক আছে) খুলুন। একদম উপরে `SETTINGS` অংশে `PASTE_SUPABASE_URL` আর `PASTE_SUPABASE_ANON_KEY` এর জায়গায় ওই দুটো বসান (' ' এর ভেতরে)।
   একই জায়গায় নিজের **bKash/Nagad নম্বর** (`PAYNUM`), ঠিকানা (`ADDR`), email (`SHOP_EMAIL`) বদলে নিন।
   ডেলিভারি ফি বদলাতে চাইলে `SHIP` আর SQL ফাইলের `+ 100` একসাথে বদলাতে হবে।

## ধাপ ২: Login ঠিক করুন
Supabase → **Authentication → URL Configuration**: **Site URL** এ আপনার সাইটের ঠিকানা (ধাপ ৩ এর পর পাবেন) বসান।
(সহজ করতে চাইলে **Authentication → Providers → Email** এ "Confirm email" বন্ধ করতে পারেন, তাহলে customer সাইন আপ করেই ঢুকতে পারবে।)

## ধাপ ৩: সাইট অনলাইনে দিন (Netlify, বিনামূল্যে)
1. https://app.netlify.com/drop এ যান (মালিকের email দিয়ে account খুলুন)।
2. পুরো ফোল্ডারটা (index.html আর hero.mp4 সহ) টেনে ছেড়ে দিন। কিছুক্ষণে একটা ঠিকানা পাবেন।
3. নিজের নামে domain কিনে (যেমন protapclothes.com) Netlify তে **Domain settings** থেকে যুক্ত করুন।
4. সেই ঠিকানা ধাপ ২ এর Site URL এ বসান।

## দৈনন্দিন ব্যবহার (মালিক)
1. সাইটে মালিকের email দিয়ে **Create account** করে ঢুকুন → উপরের মেনুতে **Admin** দেখা যাবে।
2. **Add product**: নাম, দাম, বর্ণনা, রং (hex code, যেমন `#e9e2d0,#17171a`), ছবি ও ভিডিও দিয়ে যত ইচ্ছা product যোগ করুন। সাথে সাথে Collection এ দেখা যাবে।
3. **Orders**: সব order, ঠিকানা, ফোন, TrxID দেখুন এবং অবস্থা বদলান (Pending → Confirmed → Shipped → Delivered)। bKash/Nagad এ টাকা এসেছে কিনা নিজের app এ মিলিয়ে তারপর Paid করুন।
4. **Messages**: customer এর পাঠানো message এখানে দেখুন।

## ক্রেতাকে হস্তান্তর (সবচেয়ে জরুরি)
- Supabase, Netlify আর domain, তিনটা account **ক্রেতার নিজের email এ** খুলতে হবে। (আপনার account এ খুললে পরে মালিকানা বদলাতে হবে: Supabase/Netlify তে Settings থেকে Transfer/Add owner করা যায়।)
- ক্রেতা ধাপ ১ এর SQL এ নিজের email বসাবে। পুরনো মালিকের email যেন `admins` টেবিলে না থাকে।
- ক্রেতাকে এই ফোল্ডার আর এই README দিন।

## জেনে রাখুন
- anon key সবাই দেখতে পায়, এটা স্বাভাবিক। অন্য কেউ যাতে ডেটা বদলাতে না পারে সেটা SQL এর নিয়ম (Row Level Security) ঠিক রাখে। **service_role key কখনো index.html এ বসাবেন না।**
- Order এর মোট দাম server নিজে হিসাব করে, তাই customer দাম বদলাতে পারবে না।
- bKash/Nagad এ এখন নিজে টাকা মিলিয়ে নিতে হয়। স্বয়ংক্রিয় payment (SSLCommerz) আলাদা কাজ, merchant account লাগে।
- Order বা message এলে email notification এখনো নেই। Admin এ ঢুকে দেখতে হয়।
- 3D মডেল কোডে বানানো সাধারণ T-shirt। আসল product এর ছবি-ভিডিও আলাদা বোতামে (Photo/Video) দেখা যায়।
- এই সাইট আমি আসল Supabase এর সাথে চালিয়ে পরীক্ষা করিনি। ধাপগুলো শেষ করে একটা test product আর test order দিয়ে নিশ্চিত হয়ে নিন।

---

## নতুন সুবিধা (আপডেট ১)

- **Home, Collection, Product, Cart, Contact, Policy পেজ login ছাড়াই দেখা যায়।** Checkout, Orders আর Admin-এ ঢুকতে login লাগে। Message পাঠাতেও login লাগে।
- **Admin → Edit:** product এর নাম, দাম, বর্ণনা, রং, ছবি (প্রতি রঙে একাধিক, ✕ চেপে মোছা যায়), ভিডিও বদলানো আর "Visible in shop" বন্ধ করে লুকিয়ে রাখা যায়।
- **নতুন order এলে** Admin মেনুতে সংখ্যা দেখায়, আর ব্রাউজারের ট্যাবের নামে (২) এর মতো লেখা আসে। Email notification নেই।
- **Delivery & returns** আর **Privacy policy** পেজ, প্রতিটা পেজের নিচে footer।
- Google এর জন্য সাইটের বর্ণনা (meta description) যোগ হয়েছে।

### একবার করুন: `update-1.sql` চালান
Supabase → SQL Editor-এ `update-1.sql` এর লেখা Run করুন। এতে লুকানো product সাধারণ মানুষ API দিয়েও দেখতে পাবে না।

### নিজের তথ্য বসান (`index.html` এর উপরে SETTINGS অংশ)
`PHONE` (ফোন নম্বর), `DELIVERY_TIME` (ডেলিভারির সময়), `RETURN_DAYS` (ফেরতের দিন), `SHIP` (ডেলিভারি ফি, SQL ফাইলের `+ 100` এর সাথে মিলিয়ে)।
**Policy পেজের লেখা আমি সাধারণ নিয়মে লিখেছি। আপনার আসল নিয়মের সাথে না মিললে বদলে নিন, কারণ গ্রাহককে যা বলবেন সেটাই মানতে হবে।**

### Google-এ সাইট আনা
1. search.google.com/search-console এ সাইটের ঠিকানা দিন, যাচাই করুন, তারপর **URL Inspection → Request indexing** চাপুন।
2. এই সাইটের ভেতরের পেজগুলোর ঠিকানা `#` চিহ্ন দিয়ে হয়, তাই Google মূলত হোমপেজটাই আলাদা করে চেনে। প্রতিটা product আলাদা করে Google-এ আনতে চাইলে সাইটের পেজ-কাঠামো বদলাতে হবে, সেটা আলাদা কাজ।
3. Facebook পেজ আর Google Business Profile খুলে সাইটের লিংক দিন।

---

## অর্ডার ব্যবস্থার আপডেট (আপডেট ২)

**Customer-এর জন্য**
- Checkout-এ ৬৪ জেলার তালিকা, জেলা অনুযায়ী ডেলিভারি ফি (ডিফল্ট: বরিশালে ৬০, বাকি সব জায়গায় ১০০), ফোন নম্বর ও ঠিকানা যাচাই, অর্ডারের নোট, আর পরের বার নিজে থেকে ভরে যাওয়া ঠিকানা।
- bKash/Nagad বেছে নিলে টাকা পাঠানোর নম্বর আর পরিমাণ দেখায়, তারপর TrxID দিতে হয়।
- Cart-এ + / − দিয়ে পরিমাণ বদলানো যায়।
- অর্ডার করার পর "এরপর কী হবে" লেখা পেজ। **My orders**-এ অবস্থার ধাপ (Pending, Confirmed, Shipped, Delivered) দেখা যায়, আর Pending থাকা অবস্থায় নিজে অর্ডার বাতিল করা যায়।

**মালিকের জন্য (Admin)**
- অবস্থা অনুযায়ী ফিল্টার, নাম/ফোন/অর্ডার নম্বর দিয়ে খোঁজা, কতগুলো Pending আর Delivered বিক্রি কত।
- প্রতিটা অর্ডারে এক ক্লিকে Call আর WhatsApp, গ্রাহকের নোট।

**সার্ভারের নিরাপত্তা:** মোট দাম আর ডেলিভারি ফি database নিজে হিসাব করে, মুছে ফেলা বা লুকানো product দিয়ে অর্ডার হয় না, আর পরিমাণ ১–২০ এর বাইরে গেলে অর্ডার নেয় না।

### আপনাকে যা করতে হবে
1. Supabase → SQL Editor-এ **`update-2.sql`** এর লেখা Run করুন (`update-1.sql` আগে না চালালে সেটাও)।
2. `index.html` এর উপরের SETTINGS-এ **`BKASH`** আর **`NAGAD`** এ আপনার আসল নম্বর বসান। **নম্বর না বসালে ওই পদ্ধতি customer-কে দেখানো হয় না, শুধু Cash on Delivery থাকে।**
3. ডেলিভারি ফি বদলাতে চাইলে `index.html`-এর `SHIP`, `SHIP_LOCAL`, `LOCAL_DISTRICT` আর `update-2.sql`-এর সংখ্যা একসাথে বদলান।

### এখনো নেই
Stock (মজুদ) গোনা, স্বয়ংক্রিয় payment, অর্ডার এলে email/SMS, courier (Pathao, Steadfast) সংযোগ।

---

## bKash/Nagad নম্বর Admin থেকে বদলানো (আপডেট ৩)

1. Supabase → SQL Editor-এ **`update-3.sql`** এর লেখা একবার Run করুন।
2. সাইটে Admin পেজের একদম উপরে **Payment and contact numbers** অংশে bKash নম্বর, Nagad নম্বর আর দোকানের ফোন বসিয়ে **Save numbers** চাপুন। যখন খুশি বদলাতে পারবেন, কোড ছুঁতে হবে না।
3. কোনো নম্বর ফাঁকা রাখলে সেই পদ্ধতি customer-কে দেখানো হয় না।
4. `update-3.sql` চালানোর পর থেকে সাইট এই নম্বরগুলো database থেকে নেয়। `index.html`-এ বসানো `BKASH`, `NAGAD`, `PHONE` তখন আর কাজ করে না, তাই আগে সেখানে নম্বর বসিয়ে থাকলে Admin-এ আবার একবার বসিয়ে নিন।
