# Social Media Marketing Campaign Analysis

A complete analysis of a 6-month social media campaign across **Instagram, Twitter, and Facebook** — done in **two tools** to demonstrate a full data analyst skill set.

---

## Project Overview

| Detail | Info |
|---|---|
| **Dataset** | Simulated campaign data (2,000 posts) |
| **Timeframe** | 6 months |
| **Platforms** | Instagram, Twitter, Facebook |
| **Tools** | Python (Pandas, Matplotlib, Seaborn) · SQL (SQLite / PostgreSQL) |

---

## Key Questions Answered

1. Which platform drives the most reach and engagement?
2. What content type (Video, Image, Carousel, Story, Text) performs best?
3. What is the best time and day to post?
4. Is there a relationship between reach and engagement rate?
5. Which platform + content type combo converts best?

---

## Key Findings

- **Instagram** achieves the highest average reach per post
- **Video content** has the highest engagement rate (~12% avg) across all platforms
- **Carousel posts** outperform single images by ~30% on Instagram
- Best time to post: **6 PM – 8 PM**, especially on **weekends**
- **Text-only posts** consistently underperform — below 5% engagement rate
- Higher reach does **not** guarantee higher engagement rate

---

## Project Structure

```
social-media-analysis/
│
├── social_media_analysis.ipynb   # Python EDA — charts & visualizations
├── social_media_analysis.sql     # SQL analysis — same questions, pure queries
├── social_media_data.csv         # Generated dataset (created on notebook run)
├── plots/                        # Saved chart images from Python notebook
│   ├── 01_distributions.png
│   ├── 02_monthly_trend.png
│   ├── 03_platform_comparison.png
│   ├── 04_content_type.png
│   ├── 05_heatmap_platform_content.png
│   ├── 06_best_time.png
│   ├── 07_engagement_deep_dive.png
│   └── 08_correlation_matrix.png
└── README.md
```

---

## Python Analysis — How to Run

1. **Clone the repo**
   ```bash
   git clone https://github.com/yourusername/social-media-analysis.git
   cd social-media-analysis
   ```

2. **Install dependencies**
   ```bash
   pip install pandas numpy matplotlib seaborn jupyter
   ```

3. **Create plots folder & launch Jupyter**
   ```bash
   mkdir plots
   jupyter notebook social_media_analysis.ipynb
   ```

4. **Run all cells** — dataset is generated automatically, no external data needed!

---

## SQL Analysis — How to Run

### Option A — SQLite (simplest, no setup needed)
```bash
sqlite3 social_media.db
.mode csv
.import social_media_data.csv social_media
.read social_media_analysis.sql
```

### Option B — PostgreSQL
```sql
\copy social_media FROM 'social_media_data.csv' CSV HEADER;
```
Then run the `.sql` file in pgAdmin or psql.

### Option C — Online (no install)
Upload `social_media_data.csv` to [sqliteonline.com](https://sqliteonline.com) or [DB Fiddle](https://www.db-fiddle.com) and paste queries directly.

---

## Skills Demonstrated

**Python**
- Data simulation & feature engineering with NumPy & Pandas
- Exploratory Data Analysis (EDA)
- Data visualization (bar, line, scatter, heatmap, boxplot, pie)

**SQL**
- Aggregations, GROUP BY, ORDER BY
- Window functions (RANK, LAG for month-over-month trends)
- CASE statements for custom time bucketing
- Subqueries & correlated subqueries
- Business-focused query writing

---

## Contact

Lia Saiyan

[LinkedIn](https://www.linkedin.com/in/lia-saiyan/) · [Email](liasaiyan@gmai.com) 
