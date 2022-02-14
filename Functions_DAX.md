# DAX Functions

- Know your audience
- Evoke an emotional response
- Less is more
- Reduce cognitive load
- Tracking focal points
- Accesibility
- Ready for production
- Paginated reports

## Tables

### Fact tables
- Measurements from business process
- Keys to establish relations with other dim tables
- Long and narrow

### Dimensional tables
- Provide context
- Who, what, when, where, why?
- Short and wide
- Few rows but lots of columns

## Basic
```sql
CALCULATE(Aggregation, filter_1, filter_2, ...) 
SUMX (table, expresion) - Sum the result of an operation done to every row
SUBSTITUTE(column,Old_text,New_text) - Substitute a string
RELATED(Table[Column]) - Add a column from another table
```
