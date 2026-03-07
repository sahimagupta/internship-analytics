# 📊 Internship Application Analytics Dashboard

### 🔗 [📊 View Live Dashboard](https://sahimagupta.github.io/internship-analytics/)

[![R](https://img.shields.io/badge/R-4.5+-blue.svg)](https://www.r-project.org/)
[![Quarto](https://img.shields.io/badge/Quarto-1.3+-green.svg)](https://quarto.org/)

---

## 📖 The Story Behind This Project

India's **Ministry of Women & Child Development (WCD)** runs an internship programme designed to provide hands on policy experience to young women across the country. Every cycle, hundreds of women students, scholars, teachers, and social activists apply for a chance to work within the Ministry and contribute to India's social welfare agenda.

This project analyzes **478 female internship applications** from the Feb-Mar intake cycle, spanning **28 Indian states** and **6 geographic zones**. The goal is to understand **who these women are** where they come from, what they study, how they perform academically, and what support they need.

The findings reveal fascinating patterns about **women's participation in government programmes**, the **rural-urban divide**, and the **educational landscape** of India's aspiring policy professionals.

---
📌 Research Question


Who are the women applying for the Ministry of Women & Child Development internship programme, and what patterns exist in their participation?

## 🔍 Key Findings

### 🗺️ Geographic Concentration
- **Uttar Pradesh dominates** with 116 applications (24.3%) nearly 1 in 4 applicants comes from UP
- **Central Zone** leads with 37.2% of all applications, followed by Eastern (19.7%) and Northern (14.6%)
- The **North-Eastern states** are significantly underrepresented with only 17 applications (3.6%)
- Top 5 states (UP, Maharashtra, Haryana, MP, Bihar) account for **60% of all applications**

### 🏘️ Rural Participation
- **47.7% applicants are from rural areas** a remarkably strong rural turnout
- This challenges the assumption that government internships attract only urban candidates
- Rural participation varies significantly by zone **Eastern zone has the highest rural percentage**

### 🎓 Education Profile
- Nearly equal split: **47.6% Graduates** and **49.7% Post-Graduates**
- Most popular qualifications: **B.A., LLB/Law, M.A., B.Com., B.Sc.**
- Law students show particularly strong interest, suggesting the programme appeals to policy-minded women
- Average academic score is **66.5%**, with significant variation across zones

### 🏠 Hostel Requirement
- **79.5% applicants need hostel facilities** a critical infrastructure insight
- This indicates most applicants would relocate for the internship
- Rural applicants are more likely to need hostel accommodation
- This finding has direct policy implications for programme planning

### 👩 Applicant Demographics
- Average age: **24.5 years** (range: 19-49)
- **85.6% are students**, with small but significant participation from scholars (4%), social activists (2.9%), and teachers (1.3%)
- The age distribution peaks at 22-24, suggesting most applicants are in their final years of study or recently graduated

---

## 📊 Dashboard Pages

### Page 1: Overview
The landing page presents the big picture total applications, state-wise distribution, zone breakdown, age histogram, and the rural-urban split across zones. Interactive Plotly charts allow you to hover over any data point for details.

### Page 2: Education
Deep dive into the educational background  degree type distribution (Graduate vs Post-Graduate), top 12 qualifications, academic performance histogram, and box plots comparing scores across zones.

### Page 3: Regional Analysis
Zone-wise metrics table with color-coded bars, hostel requirement breakdown by zone, and a detailed state level table with filters and export options (CSV/Excel).

### Page 4: Data Explorer
The full cleaned dataset in a searchable, sortable, and exportable DataTable. Filter by any column name, state, zone, qualification, performance band and export the filtered results.

---

## 📁 Project Structure

```
internship-analytics/
├── dashboard.qmd              # Interactive Quarto dashboard (4 pages)
├── scripts/
│   └── 01-data-cleaning.R     # Data cleaning & transformation (250+ lines)
│                                 - Column renaming & standardization
│                                 - Age group creation
│                                 - CGPA to percentage conversion
│                                 - Qualification name normalization
│                                 - Performance band categorization
│                                 - State & zone summary aggregation
├── data/
│   ├── raw/                   # Original application data (478 records)
│   └── cleaned/               # Processed datasets
│       ├── applications_clean.csv      # Full cleaned dataset
│       ├── state_summary.csv           # 28 states aggregated
│       ├── zone_summary.csv            # 6 zones aggregated
│       └── qualification_distribution.csv
├── docs/                      # Rendered dashboard (GitHub Pages)
│   └── index.html
└── README.md
```

---

## 🛠️ Technologies & Methods

| Tool | Purpose |
|------|---------|
| **R 4.5+** | Data cleaning, analysis, visualization |
| **tidyverse** | Data wrangling (dplyr, tidyr, stringr, forcats) |
| **Plotly** | Interactive charts (bar, pie, histogram, box plots) |
| **DT (DataTables)** | Searchable/filterable/exportable tables |
| **Quarto** | Reproducible dashboard framework |
| **GitHub Pages** | Live deployment |

### Data Cleaning Highlights
- **Qualification normalization**: 200+ raw qualification strings mapped to 15 standardized categories using regex pattern matching
- **Score standardization**: Mixed CGPA (scale of 10) and percentage values unified CGPA automatically converted to approximate percentage
- **Performance banding**: Continuous scores categorized into Distinction, First Class, Second Class, Pass, and Below Average
- **Geographic enrichment**: State-to-zone mapping, rural/urban classification

---

## 📊 Data Source

Internship application records from the **Ministry of Women & Child Development (WCD)**, Government of India. The dataset covers the Feb-Mar intake cycle and includes applications exclusively from **female candidates** across India.

**Dataset characteristics:**
- **478 applications** from 28 states/UTs
- **34 variables** including demographics, education, work experience, and hostel requirements
- Source: WCD internship portal (wcd.intern.nic.in)

---

## 💡 Insights for Policy

1. **Expand outreach in North-Eastern states** only 3.6% representation despite significant population
2. **Hostel infrastructure is critical** 4 out of 5 applicants need accommodation
3. **Rural women are participating** nearly half the applicants are from rural areas, suggesting strong demand
4. **Law and social science students dominate** the programme naturally attracts policy-interested candidates
5. **Age diversity exists** while most are 22-24, applicants range from 19 to 49, including working professionals

---

## 👩‍💻 Author

**Sahima Gupta**  
📧 gupta.sahima@gmail.com

---

## 📝 License

This project is for academic and portfolio purposes. Data sourced from Government of India's open data platforms.
