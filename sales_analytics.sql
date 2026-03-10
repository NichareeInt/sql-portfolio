-- ===================================
-- Sales Analytics Dashboard
-- By: Nicharee Intharamongkhon
-- Date: 2026-03-10
-- ===================================

-- 1. ยอดขายรวมทั้งหมด
SELECT SUM(o.quantity * p.price) AS ยอดขายทั้งหมด
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id;

-- 2. สินค้าขายดีที่สุด 3 อันดับแรก
SELECT p.name, SUM(o.quantity * p.price) AS ยอด
FROM products p
INNER JOIN orders o ON p.product_id = o.product_id
GROUP BY p.name
ORDER BY ยอด DESC
LIMIT 3;

-- 3. ลูกค้าที่ใช้เงินมากที่สุด
SELECT c.name, SUM(o.quantity * p.price) AS ยอด
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON o.product_id = p.product_id
GROUP BY c.name
ORDER BY ยอด DESC;

-- 4. ยอดขายแต่ละเดือน
SELECT TO_CHAR(order_date, 'YYYY-MM') AS เดือน,
    SUM(o.quantity * p.price) AS ยอด
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
GROUP BY TO_CHAR(order_date, 'YYYY-MM');

-- 5. ยอดขายแต่ละ category พร้อมเปอร์เซ็นต์
SELECT p.category,
    SUM(o.quantity * p.price) AS ยอด,
    ROUND(SUM(o.quantity * p.price) * 100.0 /
        (SELECT SUM(o2.quantity * p2.price)
         FROM orders o2
         INNER JOIN products p2 ON o2.product_id = p2.product_id), 2) AS เปอร์เซ็นต์
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY ยอด DESC;