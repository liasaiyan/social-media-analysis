# Social Media Marketing Campaign Analysis

A complete exploratory data analysis (EDA) of a 6-month social media campaign across **Instagram, Twitter, and Facebook** — uncovering what content works, when to post, and which platform delivers the best ROI.

---

##  Project Overview

| Detail | Info |
|---|---|
| **Dataset** | Simulated campaign data (2,000 posts) |
| **Timeframe** | 6 months |
| **Platforms** | Instagram, Twitter, Facebook |
| **Tools** | Python, Pandas, NumPy, Matplotlib, Seaborn |
| **Deliverable** | Jupyter Notebook + visualizations |

---

##  Key Questions Answered

1. Which platform drives the most reach and engagement?
2. What content type (Video, Image, Carousel, Story, Text) performs best?
3. What is the best time and day to post?
4. Is there a relationship between reach and engagement rate?
5. Which platform converts best?

---

##  Key Findings

- **Instagram** achieves the highest average reach per post
- **Video content** has the highest engagement rate (~12% avg) across all platforms
- **Carousel posts** outperform single images by ~30% on Instagram
- Best time to post: **6 PM – 8 PM**, especially on **weekends**
- **Text-only posts** consistently underperform — below 5% engagement rate
- Higher reach does **not** guarantee higher engagement rate

---

##  Project Structure

```
social-media-analysis/
│
├── social_media_analysis.ipynb   # Main analysis notebook
├── social_media_data.csv         # Generated dataset (created on run)
├── plots/                        # Saved chart images
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

##  How to Run

1. **Clone the repo**
   ```bash
   git clone https://github.com/yourusername/social-media-analysis.git
   cd social-media-analysis
   ```

2. **Install dependencies**
   ```bash
   pip install pandas numpy matplotlib seaborn jupyter
   ```

3. **Create the plots folder**
   ```bash
   mkdir plots
   ```

4. **Launch Jupyter**
   ```bash
   jupyter notebook social_media_analysis.ipynb
   ```

5. **Run all cells** — the dataset is generated automatically (no external data needed!)

---

##  Skills Demonstrated

- Data generation & simulation with NumPy
- Data cleaning & feature engineering with Pandas
- Exploratory Data Analysis (EDA)
- Data visualization with Matplotlib & Seaborn
- Business insight communication
- Markdown documentation

---

##  Contact

Lia Saiyan
[LinkedIn](https://www.linkedin.com/in/lia-saiyan/) · [Email](liasaiyan@gmail.com) 
