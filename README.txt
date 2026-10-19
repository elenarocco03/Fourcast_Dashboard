FOURCAST - Yield curve analytics (MATLAB dashboard)
===================================================

What it does
------------
Opens a dashboard with the U.S. Treasury yield curve, downloaded from FRED
every time it starts:
  - Today    latest curve (1M ... 20Y), key numbers (10Y, 2s10s, 3m10y, 20Y),
             buttons to show/hide maturities, values on mouse hover,
             optional reference line.
  - History  animated curve over a period of your choice (default 2000 - today),
             monthly / weekly / daily steps, play / pause, speed, timeline.

Requirements
------------
  - MATLAB R2023a or later (no toolboxes needed)
  - Internet connection
  - A free FRED API key (personal: each user needs their own)

Setup (once)
------------
1. Get your key: https://fredaccount.stlouisfed.org/apikeys
   (create a free account, then "Request API Key"; it is 32 characters).
2. Unzip this folder anywhere and open it in MATLAB as the Current Folder.
3. In the Command Window type (with your own key):
       setup_fred_key('paste_your_key_here')
   The key is saved in the file .fred_api_key in your home folder,
   never inside the code.

Run
---
In the Command Window, from this folder:
       dashboard
The first run downloads the whole history since 1962 (about 10 seconds) and
saves it in the subfolder data/. Later runs only download the last few weeks.

Files
-----
  dashboard.m           the dashboard (layout, charts, animation)
  fred_yield_curve.m    downloads the Treasury yields from the FRED API
  fred_yield_history.m  keeps the saved history in data/ up to date
  setup_fred_key.m      saves your FRED API key (run once)

Notes
-----
  - Data: Board of Governors of the Federal Reserve System (H.15), via FRED.
    Yields are constant-maturity par yields, not zero-coupon yields.
  - The 15Y is not published by the Treasury: it is interpolated between
    10Y and 20Y. The 20Y is missing between 1987 and 1993.
  - "Today" is the latest day published on FRED (usually 1-2 business days ago).
  - If you get "Initiating another web service request while one is currently
    in progress is not supported": restart MATLAB and run dashboard once.
  - This product uses the FRED(R) API but is not endorsed or certified by the
    Federal Reserve Bank of St. Louis.
