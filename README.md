# 📊 Internship Application Analytics Dashboard

### 🔗 [📊 View Live Dashboard](https://sahimagupta.github.io/internship-analytics/)

An interactive R dashboard analyzing **478 female internship applications** submitted to the Ministry of Women & Child Development (WCD) internship programme, covering **28 Indian states** across **6 zones**.

## 🔍 Key Findings

- **Uttar Pradesh dominates** with 116 applications (24.3%), followed by Maharashtra, Haryana, and Madhya Pradesh
- **Central Zone** leads with 37.2% of all applications
- **47.7% applicants are from rural areas** — highlighting strong rural participation in government internship programmes
- **79.5% applicants need hostel facilities** — indicating most applicants are from outside the internship location
- Average age of applicants is **24.5 years**, with most (85%) being current students
- Nearly equal split between **Graduates (47.6%)** and **Post-Graduates (49.7%)**

## 🖥️ Dashboard Pages

| Page | Description |
|------|-------------|
| **Overview** | Key metrics, state-wise bar chart, zone distribution, age histogram, rural-urban split |
| **Education** | Degree types, top qualifications, academic performance distribution, scores by zone |
| **Regional** | Zone-wise metrics table, hostel requirements, detailed state-level data with export |
| **Data Explorer** | Full searchable/filterable dataset with CSV/Excel export |

## 📁 Project Structure

```
internship-analytics/
├── dashboard.qmd              # Interactive Quarto dashboard (4 pages)
├── scripts/
│   └── 01-data-cleaning.R     # Data cleaning & transformation (250+ lines)
├── data/
│   ├── raw/                   # Original application data
│   └── cleaned/               # Processed datasets
│       ├── applications_clean.csv
│       ├── state_summary.csv
│       ├── zone_summary.csv
│       └── qualification_distribution.csv
├── index.html                 # Rendered dashboard (GitHub Pages)
└── README.md
```

## 🛠️ Technologies

- **R** with tidyverse, plotly, DT, scales
- **Quarto** for reproducible dashboard
- **Plotly** for interactive charts
- **DataTables** for searchable/exportable data tables
- **GitHub Pages** for deployment

## 📊 Data Source

Internship application records from the **Ministry of Women & Child Development (WCD)** internship programme, covering Feb-Mar intake. Applications are exclusively from female candidates across India.

## 👩‍💻 Author

**Sahima Gupta**
📧 gupta.sahima@gmail.com

## 📝 License

This project is for academic and portfolio purposes.
