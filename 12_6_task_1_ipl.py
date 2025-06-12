import pandas as pd

df = pd.read_csv("12_6_matches.csv")

# 1. Total matches
print("Total matches:", len(df))

# 2. Total seasons
print("Total seasons:", df['season'].nunique())

# 3. Team with maximum win by runs
max_runs = df.loc[df['win_by_runs'].idxmax()]
print("Max win by runs:", max_runs['winner'])

# 4. Team with maximum win by wickets
max_wickets = df.loc[df['win_by_wickets'].idxmax()]
print("Max win by wickets:", max_wickets['winner'])

# 5. Closest win by runs (excluding 0)
min_runs_row = df[df['win_by_runs'] > 0]
min_runs = min_runs_row.loc[min_runs_row['win_by_runs'].idxmin()]
print("Closest win by runs:", min_runs['winner'])

# 6. Minimum wicket win (excluding 0)
min_wickets_row = df[df['win_by_wickets'] > 0]
min_wickets = min_wickets_row.loc[min_wickets_row['win_by_wickets'].idxmin()]
print("Minimum wicket win:", min_wickets['winner'])

# 7. Season with most number of matches
most_matches_season = df['season'].value_counts().idxmax()
print("Season with most matches:", most_matches_season)

# 8. Most successful team
most_successful = df['winner'].value_counts().idxmax()
print("Most successful team:", most_successful)
