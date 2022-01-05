# Python for finance

### Basic
```sql
npf.fv(rate=0.08, nper=5, pmt=0, pv=-1000) - "Future value" Calculate compund interest
npf.pv(rate=0.08, nper=5, pmt=0, fv=1000) - Present value
npf.pmt(rate=0.07/12, nper=5*12, pv=100000, fv=0)  - Monthly Loan Payments + interest
npf.irr(x) - Internal rate of return
```
