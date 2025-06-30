CREATE OR REPLACE TABLE `rakamin-kf-analytics-463418.kimia_farma.kf_salesperformance_analysis` AS
WITH kf_ft_laba AS (
  SELECT * ,
    CASE
      WHEN price <= 50000 THEN 0.10
      WHEN price > 50000 AND price <= 100000 THEN 0.15
      WHEN price > 100000 AND price <= 300000 THEN 0.20
      WHEN price > 300000 AND price <= 500000 THEN 0.25
      ELSE 0.30
    END AS persentase_gross_laba,
    (price - (price * discount_percentage / 100)) As nett_sales
  FROM `rakamin-kf-analytics-463418.kimia_farma.kf_final_transaction`)
SELECT
    ft.transaction_id,
    ft.date,
    kc.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    ft.customer_name,
    p.product_id,
    p.product_name,
    ft.price AS actual_price,
    ft.discount_percentage,
    ft.persentase_gross_laba,
    ft.nett_sales,
    ft.nett_sales * ft.persentase_gross_laba AS nett_profit,
    ft.rating AS rating_transaksi
FROM kf_ft_laba AS ft
  JOIN `rakamin-kf-analytics-463418.kimia_farma.kf_kantor_cabang` AS kc
    ON ft.branch_id = kc.branch_id
  JOIN `rakamin-kf-analytics-463418.kimia_farma.kf_product` AS p
    ON ft.product_id = p.product_id
ORDER BY ft.date ASC;
