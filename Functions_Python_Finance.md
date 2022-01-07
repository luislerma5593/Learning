# Python for finance

- https://algotrading101.com/learn/yfinance-guide/
- https://pypi.org/project/yfinance/

## Basic
```sql
npf.fv(rate=0.08, nper=5, pmt=0, pv=-1000) - "Future value" Calculate compund interest
npf.pv(rate=0.08, nper=5, pmt=0, fv=1000) - Present value
npf.pmt(rate=0.07/12, nper=5*12, pv=100000, fv=0)  - Monthly Loan Payments + interest
npf.irr(x) - Internal rate of return
```

## Financial functions
```py
---------------- Accesing Data ----------------

data = yf.Ticker("TSLA") - Get financial informatio from TSLA
data.info - Get info from company
data.info.keys() - Get keys
data.info["returnOnEquity"] - Get a value

data.dividends - Show dividends
data.splits - Show splits
data.balance_sheet - Show balance sheet
data.cashflow - Show cashflow
data.earnings - Show earnings
data.major_holders - Major Holders
data.recommendations - Get recommedations by investment banks (Index is "Date" column)

# 1d, 5d, 1mo, 3mo, 6mo, 1y, 2y, 5y, 10y, ytd, max.
data.history(period='x', start "x", end="x") - Get stock data for a period of time (Empty returns 1 month)
yf.download("ticker1 ticker2 ...", start='x') - Get data from multiple tickers

# ---------------- Analyzing Data ----------------

s1 = series.pct_change() - Calculates the percentage change
(x + 1).cumprod() - Calculates the accumulated product
series.pct_change().corr() - To see the correlation between different stocks

# Sharpe
ret = (x * weights).sum(axis = 1)
annual_std = np.std(ret) * np.sqrt(252)
sharpe = (np.mean(ret) / np.std(ret))  *  np.sqrt(252)

```

## Web Scraping
```py
from urllib import request
import ssl

url="https://en.wikipedia.org/wiki/List_of_S%26P_500_companies"
context = ssl._create_unverified_context()
response = request.urlopen(url, context=context)
html = response.read()

import pandas as pd
data = pd.read_html(html)
```

## Web Scraping with request header

A request header is used in an HTTP request to provide information about the request context, so that the server can tailor the response. We provided data for a standard web browser.

```py
import pandas as pd
import requests

url_link = 'https://finance.yahoo.com/quote/TSLA/profile'
r = requests.get(url_link,headers ={'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'})

data = pd.read_html(r.text)
print(data[0]) 