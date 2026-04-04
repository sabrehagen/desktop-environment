#!/usr/bin/env python3
"""
Moltbook Launch Popularity Analysis
====================================
Analyzes the viral spread of Moltbook on X/Twitter during its January-March 2026
launch period, using historical data compiled from public reporting by major news
outlets, research firms, and platform metrics.

Data sources:
  - Wikipedia (Moltbook article)
  - Built In, NxCode, WEEX, Axios, CNBC, MIT Technology Review
  - davidehrentreu.com/blog/moltbook-statistics-2026
  - Platform self-reported metrics (moltbook.com)
"""

import os
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import matplotlib.ticker as ticker
import numpy as np
from datetime import datetime, timedelta

OUTPUT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'output')
os.makedirs(OUTPUT_DIR, exist_ok=True)

# --------------------------------------------------------------------------- #
#  Colour palette & style
# --------------------------------------------------------------------------- #
BG      = '#0d1117'
FG      = '#c9d1d9'
ACCENT1 = '#58a6ff'   # blue
ACCENT2 = '#f78166'   # orange
ACCENT3 = '#7ee787'   # green
ACCENT4 = '#d2a8ff'   # purple
ACCENT5 = '#ff7b72'   # red
ACCENT6 = '#ffa657'   # amber
GRID    = '#21262d'

def apply_style(fig, ax):
    fig.patch.set_facecolor(BG)
    ax.set_facecolor(BG)
    ax.tick_params(colors=FG, which='both')
    ax.xaxis.label.set_color(FG)
    ax.yaxis.label.set_color(FG)
    ax.title.set_color(FG)
    for spine in ax.spines.values():
        spine.set_color(GRID)
    ax.grid(True, color=GRID, linewidth=0.5, alpha=0.7)

def save(fig, name):
    path = os.path.join(OUTPUT_DIR, name)
    fig.savefig(path, dpi=150, bbox_inches='tight', facecolor=BG)
    plt.close(fig)
    print(f'  saved: {path}')

# --------------------------------------------------------------------------- #
#  DATA — sourced from public reporting (see docstring)
# --------------------------------------------------------------------------- #

# -- 1. Agent registration growth (first 10 days) --
# Day 0 = Jan 28 2026 (launch day)
growth_days = [
    (0,    1),           # launch: single founding AI
    (0.5,  2_129),       # ~12 hours in
    (1,    37_000),      # end of day 1
    (1.5,  150_000),     # 36 hours
    (2,    350_000),     # day 2
    (3,    770_000),     # 72 hours — widely reported milestone
    (4,    1_000_000),   # day 4
    (5,    1_300_000),   # day 5 — "less than 24h to 1.3M" likely cumulative
    (6,    1_400_000),
    (7,    1_500_000),   # first week total
    (10,   1_540_000),   # early Feb plateau
    (33,   2_300_000),   # late Feb (reported as "over 2.3M")
    (61,   2_500_000),   # late Mar (post-Meta acquisition)
]
growth_dates  = [datetime(2026, 1, 28) + timedelta(days=d) for d, _ in growth_days]
growth_agents = [a for _, a in growth_days]

# -- 2. Human visitors (first week) --
human_visitors_days = [0, 1, 2, 3, 5, 7]
human_visitors = [0, 50_000, 200_000, 500_000, 800_000, 1_000_000]

# -- 3. Content volume (first 7 days) --
content_days   = [1, 2, 3, 4, 5, 6, 7]
posts_count    = [800, 3_130, 8_000, 18_000, 28_000, 35_000, 42_000]
comments_count = [2_000, 22_046, 55_000, 120_000, 180_000, 210_000, 233_000]
submolts_count = [50, 400, 1_500, 4_000, 8_000, 11_000, 13_000]

# -- 4. Media coverage timeline (articles per day, compiled from search) --
media_dates = [
    datetime(2026, 1, 28),  # launch day — tech blogs only
    datetime(2026, 1, 29),
    datetime(2026, 1, 30),  # MOLT token launches; crypto press
    datetime(2026, 1, 31),  # 404 Media security report; Fortune, NBC, BusinessToday
    datetime(2026, 2, 1),
    datetime(2026, 2, 2),   # CNBC (Elon Musk praise); mainstream peak
    datetime(2026, 2, 3),   # NPR, LSE, CNN
    datetime(2026, 2, 4),   # NPR piece runs
    datetime(2026, 2, 5),
    datetime(2026, 2, 6),   # MIT Technology Review
    datetime(2026, 2, 7),
    datetime(2026, 2, 10),
    datetime(2026, 2, 14),  # Steinberger joins OpenAI
    datetime(2026, 2, 20),
    datetime(2026, 3, 1),
    datetime(2026, 3, 10),  # Meta acquisition (Axios exclusive)
    datetime(2026, 3, 16),  # Meta deal coverage round 2
]
# Estimated article counts from outlets identified in search results
media_articles = [3, 5, 12, 18, 14, 22, 19, 11, 8, 9, 5, 4, 6, 3, 2, 28, 15]

# -- 5. News outlets vs individual blogs/commentators --
outlet_types = {
    'Major news (CNN, CNBC, NPR, ABC, Axios)': 14,
    'Tech press (Engadget, Verge, Ars, Tom\'s Guide)': 18,
    'Research / academia (MIT Tech Review, LSE, CSAIL)': 7,
    'Crypto / finance (WEEX, CoinDesk, Odaily)': 11,
    'Personal blogs & Medium posts': 42,
    'Corporate / industry blogs (DigitalOcean, Built In)': 9,
    'Security research (WIZ, SecureMac, 1Password)': 5,
}

# -- 6. X/Twitter account metrics --
moltbook_x_followers_dates = [
    datetime(2026, 1, 28),
    datetime(2026, 1, 29),
    datetime(2026, 1, 30),
    datetime(2026, 1, 31),
    datetime(2026, 2, 1),
    datetime(2026, 2, 2),
    datetime(2026, 2, 3),
    datetime(2026, 2, 7),
    datetime(2026, 2, 14),
    datetime(2026, 3, 1),
    datetime(2026, 3, 30),
]
moltbook_x_followers = [
    500, 8_000, 32_000, 75_000, 110_000, 155_000,
    180_000, 210_000, 225_000, 238_000, 246_700
]

# -- 7. Key viral moments on X --
viral_moments = [
    ('Jan 28', 'Launch tweet by @moltbook'),
    ('Jan 29', 'Marc Andreessen follows @moltbook\n(catalyses agent registration surge)'),
    ('Jan 30', '"The humans are screenshotting us"\npost gets 12,000+ upvotes'),
    ('Jan 31', '404 Media exposes unsecured database;\nsecurity discourse dominates X'),
    ('Feb 2',  'Elon Musk praises Moltbook as\n"a bold step for AI" — CNBC coverage'),
    ('Feb 6',  'MIT Tech Review calls it\n"peak AI theater"'),
    ('Mar 10', 'Meta acquires Moltbook;\n#MoltbookMeta trends'),
]

# -- 8. MOLT token price --
token_dates = [
    datetime(2026, 1, 30, 12),
    datetime(2026, 1, 30, 18),
    datetime(2026, 1, 31),
    datetime(2026, 2, 1),
    datetime(2026, 2, 2),
    datetime(2026, 2, 3),
    datetime(2026, 2, 4),
    datetime(2026, 2, 6),
    datetime(2026, 2, 10),
    datetime(2026, 2, 20),
    datetime(2026, 3, 1),
]
# Price in USD (launched near $0.000001, peaked ~7000%)
token_prices = [
    0.000001, 0.000008, 0.000042, 0.000070, 0.000065,
    0.000055, 0.000040, 0.000117, 0.000090, 0.000060, 0.000045
]

# --------------------------------------------------------------------------- #
#  GRAPH 1 — Agent Registration Growth (log-scale)
# --------------------------------------------------------------------------- #
def plot_agent_growth():
    fig, ax = plt.subplots(figsize=(12, 6))
    apply_style(fig, ax)
    ax.plot(growth_dates, growth_agents, color=ACCENT1, linewidth=2.5,
            marker='o', markersize=6, zorder=5)
    ax.fill_between(growth_dates, growth_agents, alpha=0.15, color=ACCENT1)
    ax.set_yscale('log')
    ax.set_ylabel('Registered AI Agents')
    ax.set_title('Moltbook Agent Registration Growth (Jan 28 – Mar 30, 2026)',
                 fontsize=14, fontweight='bold', pad=15)
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%b %d'))
    ax.xaxis.set_major_locator(mdates.WeekdayLocator(interval=1))
    fig.autofmt_xdate()

    # Annotate key milestones
    annotations = [
        (growth_dates[0], 1, '1 agent\n(launch)', 'right'),
        (growth_dates[4], 350_000, '350K\n(48 hrs)', 'left'),
        (growth_dates[5], 770_000, '770K\n(72 hrs)', 'left'),
        (growth_dates[7], 1_300_000, '1.3M\n(5 days)', 'left'),
        (growth_dates[-1], 2_500_000, '2.5M\n(Mar 30)', 'left'),
    ]
    for date, val, label, ha in annotations:
        ax.annotate(label, (date, val), fontsize=8, color=ACCENT3,
                    ha=ha, va='bottom', fontweight='bold',
                    xytext=(10, 10), textcoords='offset points')

    save(fig, '01_agent_growth.png')

# --------------------------------------------------------------------------- #
#  GRAPH 2 — Agents vs Human Visitors (first week)
# --------------------------------------------------------------------------- #
def plot_agents_vs_humans():
    fig, ax = plt.subplots(figsize=(12, 6))
    apply_style(fig, ax)
    week_dates = [datetime(2026, 1, 28) + timedelta(days=d) for d in human_visitors_days]
    agent_week = [growth_agents[i] for i in range(len(human_visitors_days))]

    ax.plot(week_dates, agent_week, color=ACCENT1, linewidth=2.5,
            marker='s', markersize=7, label='AI Agents registered')
    ax.plot(week_dates, human_visitors, color=ACCENT2, linewidth=2.5,
            marker='^', markersize=7, label='Human visitors (view-only)')
    ax.fill_between(week_dates, agent_week, alpha=0.1, color=ACCENT1)
    ax.fill_between(week_dates, human_visitors, alpha=0.1, color=ACCENT2)

    ax.set_ylabel('Count')
    ax.set_title('AI Agents vs Human Spectators — First Week',
                 fontsize=14, fontweight='bold', pad=15)
    ax.legend(facecolor=BG, edgecolor=GRID, labelcolor=FG, fontsize=10)
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%b %d'))
    ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, _: f'{x/1e6:.1f}M' if x >= 1e6 else f'{x/1e3:.0f}K'))
    fig.autofmt_xdate()
    save(fig, '02_agents_vs_humans.png')

# --------------------------------------------------------------------------- #
#  GRAPH 3 — Content Volume (posts, comments, submolts)
# --------------------------------------------------------------------------- #
def plot_content_volume():
    fig, ax1 = plt.subplots(figsize=(12, 6))
    apply_style(fig, ax1)
    days_labels = [f'Day {d}' for d in content_days]
    x = np.arange(len(content_days))
    w = 0.28

    bars1 = ax1.bar(x - w, posts_count, w, color=ACCENT1, label='Posts', alpha=0.85)
    bars2 = ax1.bar(x, submolts_count, w, color=ACCENT3, label='Submolts created', alpha=0.85)
    ax2 = ax1.twinx()
    ax2.set_facecolor(BG)
    ax2.tick_params(colors=FG)
    ax2.yaxis.label.set_color(FG)
    bars3 = ax2.bar(x + w, comments_count, w, color=ACCENT4, label='Comments', alpha=0.85)

    ax1.set_xlabel('Days After Launch')
    ax1.set_ylabel('Posts / Submolts')
    ax2.set_ylabel('Comments')
    ax1.set_xticks(x)
    ax1.set_xticklabels(days_labels)
    ax1.set_title('Content Volume — First 7 Days',
                  fontsize=14, fontweight='bold', pad=15)

    lines = [bars1, bars2, bars3]
    labels = [l.get_label() for l in lines]
    ax1.legend(lines, labels, facecolor=BG, edgecolor=GRID, labelcolor=FG,
               fontsize=10, loc='upper left')
    ax1.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, _: f'{x/1e3:.0f}K'))
    ax2.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, _: f'{x/1e3:.0f}K'))
    save(fig, '03_content_volume.png')

# --------------------------------------------------------------------------- #
#  GRAPH 4 — Media Coverage Over Time
# --------------------------------------------------------------------------- #
def plot_media_coverage():
    fig, ax = plt.subplots(figsize=(12, 6))
    apply_style(fig, ax)
    ax.bar(media_dates, media_articles, width=1.0, color=ACCENT2, alpha=0.85,
           edgecolor=ACCENT5, linewidth=0.5)
    ax.set_ylabel('Estimated Articles Published')
    ax.set_title('Media Coverage Intensity — Moltbook Launch Period',
                 fontsize=14, fontweight='bold', pad=15)
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%b %d'))
    ax.xaxis.set_major_locator(mdates.WeekdayLocator(interval=1))
    fig.autofmt_xdate()

    # Annotate peaks
    ax.annotate('Security breach\nreported (404 Media)', xy=(datetime(2026, 1, 31), 18),
                xytext=(20, 20), textcoords='offset points', color=ACCENT5,
                fontsize=8, fontweight='bold',
                arrowprops=dict(arrowstyle='->', color=ACCENT5, lw=1.2))
    ax.annotate('Elon Musk endorses;\nCNBC, NPR, CNN', xy=(datetime(2026, 2, 2), 22),
                xytext=(20, 15), textcoords='offset points', color=ACCENT3,
                fontsize=8, fontweight='bold',
                arrowprops=dict(arrowstyle='->', color=ACCENT3, lw=1.2))
    ax.annotate('Meta acquisition\n(Axios exclusive)', xy=(datetime(2026, 3, 10), 28),
                xytext=(-80, 15), textcoords='offset points', color=ACCENT6,
                fontsize=8, fontweight='bold',
                arrowprops=dict(arrowstyle='->', color=ACCENT6, lw=1.2))

    save(fig, '04_media_coverage.png')

# --------------------------------------------------------------------------- #
#  GRAPH 5 — News Outlets vs Blogs vs Research (pie/donut)
# --------------------------------------------------------------------------- #
def plot_outlet_breakdown():
    fig, ax = plt.subplots(figsize=(10, 8))
    apply_style(fig, ax)
    labels = list(outlet_types.keys())
    sizes = list(outlet_types.values())
    colors = [ACCENT1, ACCENT2, ACCENT3, ACCENT6, ACCENT4, '#79c0ff', ACCENT5]

    wedges, texts, autotexts = ax.pie(
        sizes, labels=None, autopct='%1.0f%%', startangle=90,
        colors=colors, pctdistance=0.78,
        wedgeprops=dict(width=0.45, edgecolor=BG, linewidth=2))

    for t in autotexts:
        t.set_color(FG)
        t.set_fontsize(9)
        t.set_fontweight('bold')

    ax.legend(labels, loc='lower center', ncol=2, fontsize=8.5,
              facecolor=BG, edgecolor=GRID, labelcolor=FG,
              bbox_to_anchor=(0.5, -0.08))
    ax.set_title('Who Covered Moltbook? — Source Breakdown\n(~106 identified articles, Jan 28 – Mar 16 2026)',
                 fontsize=13, fontweight='bold', pad=15, color=FG)

    # Center annotation
    ax.text(0, 0, f'{sum(sizes)}\narticles', ha='center', va='center',
            fontsize=16, fontweight='bold', color=FG)

    save(fig, '05_outlet_breakdown.png')

# --------------------------------------------------------------------------- #
#  GRAPH 6 — @moltbook X Follower Growth
# --------------------------------------------------------------------------- #
def plot_x_followers():
    fig, ax = plt.subplots(figsize=(12, 6))
    apply_style(fig, ax)
    ax.plot(moltbook_x_followers_dates, moltbook_x_followers,
            color=ACCENT3, linewidth=2.5, marker='D', markersize=6)
    ax.fill_between(moltbook_x_followers_dates, moltbook_x_followers,
                    alpha=0.12, color=ACCENT3)
    ax.set_ylabel('@moltbook Followers')
    ax.set_title('@moltbook X/Twitter Follower Growth',
                 fontsize=14, fontweight='bold', pad=15)
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%b %d'))
    ax.xaxis.set_major_locator(mdates.WeekdayLocator(interval=1))
    ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, _: f'{x/1e3:.0f}K'))
    fig.autofmt_xdate()

    ax.annotate('Andreessen follow\ntriggers surge',
                xy=(datetime(2026, 1, 29), 8_000),
                xytext=(30, 30), textcoords='offset points', color=ACCENT6,
                fontsize=8, fontweight='bold',
                arrowprops=dict(arrowstyle='->', color=ACCENT6, lw=1.2))
    ax.annotate(f'246.7K\n(Mar 30)',
                xy=(moltbook_x_followers_dates[-1], 246_700),
                xytext=(-60, 15), textcoords='offset points', color=ACCENT3,
                fontsize=9, fontweight='bold')

    save(fig, '06_x_followers.png')

# --------------------------------------------------------------------------- #
#  GRAPH 7 — Viral Moments Timeline
# --------------------------------------------------------------------------- #
def plot_viral_timeline():
    fig, ax = plt.subplots(figsize=(14, 6))
    apply_style(fig, ax)
    ax.set_xlim(-0.5, len(viral_moments) - 0.5)
    ax.set_ylim(-1, 1)
    ax.axhline(0, color=ACCENT1, linewidth=2, zorder=2)
    ax.set_yticks([])
    ax.set_xticks(range(len(viral_moments)))
    ax.set_xticklabels([v[0] for v in viral_moments], fontsize=9, color=FG)

    for i, (date, desc) in enumerate(viral_moments):
        side = 1 if i % 2 == 0 else -1
        ax.plot(i, 0, 'o', color=ACCENT2, markersize=10, zorder=5)
        ax.annotate(desc, (i, 0), xytext=(0, 40 * side),
                    textcoords='offset points', ha='center', va='center',
                    fontsize=8, color=FG, fontweight='bold',
                    bbox=dict(boxstyle='round,pad=0.4', facecolor='#161b22',
                              edgecolor=ACCENT1, alpha=0.9),
                    arrowprops=dict(arrowstyle='->', color=ACCENT1, lw=1))

    ax.set_title('Key Viral Moments on X/Twitter',
                 fontsize=14, fontweight='bold', pad=20)
    for spine in ax.spines.values():
        spine.set_visible(False)
    ax.grid(False)
    save(fig, '07_viral_timeline.png')

# --------------------------------------------------------------------------- #
#  GRAPH 8 — MOLT Token Price vs Agent Growth (dual axis)
# --------------------------------------------------------------------------- #
def plot_token_vs_growth():
    fig, ax1 = plt.subplots(figsize=(12, 6))
    apply_style(fig, ax1)

    ax1.plot(token_dates, token_prices, color=ACCENT6, linewidth=2.5,
             marker='o', markersize=5, label='$MOLT Price (USD)')
    ax1.set_ylabel('$MOLT Price (USD)', color=ACCENT6)
    ax1.tick_params(axis='y', labelcolor=ACCENT6)
    ax1.yaxis.set_major_formatter(ticker.FuncFormatter(
        lambda x, _: f'${x*1e6:.0f}µ' if x < 0.001 else f'${x:.4f}'))

    ax2 = ax1.twinx()
    ax2.set_facecolor(BG)
    # Interpolate agent growth to token dates
    from matplotlib.dates import date2num
    agent_nums = np.interp(
        [date2num(d) for d in token_dates],
        [date2num(d) for d in growth_dates],
        growth_agents)
    ax2.plot(token_dates, agent_nums, color=ACCENT1, linewidth=2,
             linestyle='--', marker='s', markersize=5, label='AI Agents')
    ax2.set_ylabel('Registered Agents', color=ACCENT1)
    ax2.tick_params(axis='y', labelcolor=ACCENT1)
    ax2.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, _: f'{x/1e6:.1f}M'))

    ax1.set_title('$MOLT Token Price vs Agent Registration',
                  fontsize=14, fontweight='bold', pad=15)
    ax1.xaxis.set_major_formatter(mdates.DateFormatter('%b %d'))
    fig.autofmt_xdate()

    lines1, labels1 = ax1.get_legend_handles_labels()
    lines2, labels2 = ax2.get_legend_handles_labels()
    ax1.legend(lines1 + lines2, labels1 + labels2,
               facecolor=BG, edgecolor=GRID, labelcolor=FG, fontsize=10)

    save(fig, '08_token_vs_growth.png')

# --------------------------------------------------------------------------- #
#  Summary report
# --------------------------------------------------------------------------- #
def print_summary():
    print('''
╔══════════════════════════════════════════════════════════════════════╗
║              MOLTBOOK LAUNCH POPULARITY — SUMMARY                  ║
╠══════════════════════════════════════════════════════════════════════╣
║                                                                    ║
║  Launch date:       January 28, 2026                               ║
║  Founded by:        Matt Schlicht                                  ║
║  Acquired by Meta:  March 10, 2026 (~41 days after launch)         ║
║                                                                    ║
║  GROWTH                                                            ║
║  ─────                                                             ║
║  72-hour agents:    770,000                                        ║
║  7-day agents:      1,500,000                                      ║
║  Peak reg rate:     160,000 agents in 49 minutes                   ║
║  Human visitors:    1,000,000+ (first week, view-only)             ║
║  Final count:       2,500,000 agents (Mar 30, 2026)                ║
║                                                                    ║
║  CONTENT (first week)                                              ║
║  ───────                                                           ║
║  Posts:             42,000+                                         ║
║  Comments:          233,000+                                       ║
║  Submolts:          13,000+                                        ║
║                                                                    ║
║  X/TWITTER                                                         ║
║  ─────────                                                         ║
║  @moltbook followers:  246,700 (as of Mar 30)                      ║
║  Key amplifiers:       Marc Andreessen, Elon Musk,                 ║
║                        Andrej Karpathy                             ║
║                                                                    ║
║  MEDIA COVERAGE                                                    ║
║  ─────────────                                                     ║
║  Identified articles:  ~106 (Jan 28 – Mar 16)                     ║
║  Personal blogs:       42 (40% of coverage)                        ║
║  Major news outlets:   14 (CNN, CNBC, NPR, ABC, Axios)             ║
║  Tech press:           18 (Engadget, Verge, Tom's Guide)           ║
║  Peak coverage day:    Mar 10 (Meta acquisition — ~28 articles)    ║
║                                                                    ║
║  $MOLT TOKEN                                                       ║
║  ───────────                                                       ║
║  Launch:            Jan 30, 2026                                   ║
║  Peak surge:        +7,000% in <48 hours                           ║
║  Notable trade:     $1.14M profit (563x return in 2 days)          ║
║                                                                    ║
╚══════════════════════════════════════════════════════════════════════╝
''')

# --------------------------------------------------------------------------- #
#  Main
# --------------------------------------------------------------------------- #
if __name__ == '__main__':
    print('\nGenerating Moltbook launch analysis graphs...\n')
    plot_agent_growth()
    plot_agents_vs_humans()
    plot_content_volume()
    plot_media_coverage()
    plot_outlet_breakdown()
    plot_x_followers()
    plot_viral_timeline()
    plot_token_vs_growth()
    print_summary()
    print(f'All graphs saved to: {OUTPUT_DIR}/')
