# 🧪 Nolo-Shop dbt Project

This dbt project models and transforms sales data for a no- and low-alcohol beverage shop, with a focus on both online and offline channels. It is designed to support sales analysis, identify seasonal and geographical trends, and surface product-level insights.

---

## 📌 Business Goals

- Track and compare online vs. offline sales trends
- Identify top-selling products and store locations
- Analyze average basket value across channels
- Enrich sales data with historical weather to explore seasonal impacts

---

## 🧱 Project Structure

The project follows a modular dbt architecture with clear layer separation:

```
models/
├── staging/         # Raw source cleanup and standardization
├── intermediate/    # Unified, joined logic across sources
├── marts/           # Dimensional models and analytical facts
└── schema.yml       # Model documentation and tests
```

---

## 🧬 Data Sources

| Source       | Type     | Description                                    |
| ------------ | -------- | ---------------------------------------------- |
| ERP          | CSV      | Customer data                                  |
| CRM          | CSV      | Product data                                   |
| POS          | CSV      | In-store orders and order items                |
| OnlineOrders | CSV      | Online orders and items                        |
| Weather\*    | External | Historical weather (joined by date + location) |

\*to be added

---

## 🧩 Key Models

### `fct_orders`

Fact table combining online and offline orders, with standardized structure and channel indicator.

### `fct_order_items`

Product-level fact table with quantity and unit price, linked to `fct_orders`.

### `dim_products`, `dim_customers`, `dim_stores`, `dim_date`

Dimension tables to have one source of truth for dimensions.

---

## 🧪 Testing & Documentation

- **Column-level testing**: `not_null`, `unique`, `relationships`
- **dbt Docs**: model descriptions and metadata maintained in `schema.yml`
- (Docs are not hosted due to environment constraints but can be generated via `dbt docs generate`)
