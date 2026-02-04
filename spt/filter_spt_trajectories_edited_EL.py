import pandas as pd
import os

# Written by Songtao Ye, adapted by Eleanor Liu
# December 18, 2025

# ===== USER SETTINGS =====
filePath = "/Users/eleanorliu/Downloads/jhu/research/tead1_rev/track_generation_and filtering_from_songtao/"
os.chdir(filePath)
# if using SLIMfast, compile txt file from tracking output into excel file
# first 4 columns: X, Y, Frame #, Trajectory #
INPUT_EXCEL = "260123_UOK342_H2B.xlsx"   # original file
DATA_SHEET = 4   # 0 = first sheet
CELL_NO = 5 # for naming
MIN_POINTS_PER_TRACK = 4
OUTPUT = f"260123_UOK342_H2B_{CELL_NO}_min{MIN_POINTS_PER_TRACK}points"
# =========================

def main():
    # Load data
    df = pd.read_excel(filePath+INPUT_EXCEL, sheet_name=DATA_SHEET)

    # Column D = 4th column (0-based index 3)
    # Give it a clean name for convenience
    track_col = df.columns[3]
    df["TrackID"] = df.iloc[:, 3]

    # Count how many points per track
    counts = df["TrackID"].value_counts()

    # Keep only tracks with >= MIN_POINTS_PER_TRACK points
    good_ids = counts[counts >= MIN_POINTS_PER_TRACK].index

    df_filtered = df[df["TrackID"].isin(good_ids)].copy()

    # (Optional) sort by TrackID and then by original row order
    df_filtered = df_filtered.sort_values(by=["TrackID"]).reset_index(drop=True)

    # Save to new Excel file
    df_filtered.to_excel(OUTPUT + ".xlsx", index=False)

    # Save to txt file
    df_filtered.to_csv(OUTPUT + ".txt", sep='\t', index=False, header=False)

    # Print a quick summary
    print(f"Total rows in original file : {len(df)}")
    print(f"Total unique tracks (col D) : {df['TrackID'].nunique()}")
    print(f"Tracks with ≥ {MIN_POINTS_PER_TRACK} points: {len(good_ids)}")
    print(f"Rows kept after filtering   : {len(df_filtered)}")
    print(f"Filtered table saved to     : {OUTPUT}")

    # (Optional) print first few counts for inspection
    print("\nExample of track lengths (first 10):")
    print(counts.head(10))

if __name__ == "__main__":
    main()
