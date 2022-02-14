# DAX Functions

- Know your audience
- Evoke an emotional response
- Less is more
- Reduce cognitive load
- Tracking focal points
- Accesibility
- Ready for production
- Paginated reports

## DAX
```sql
CALCULATE(Aggregation, filter_1, filter_2, ...) 
SUMX (table, expresion) - Sum the result of an operation done to every row
SUBSTITUTE(column,Old_text,New_text) - Substitute a string
RELATED(Table[Column]) - Add a column from another table
```

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

![image](https://user-images.githubusercontent.com/78183885/153962359-9adc0f3e-cb54-4d49-89fe-60cfd5bfd43b.png)

