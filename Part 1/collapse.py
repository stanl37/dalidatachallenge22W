# Stanley Gao
# 3/3/22
# quick script to collapse WIID data
# input: dataset with multiple observations for each country, some values missing from some years
# output: dataset with one observatio for each country, where each value is the most up to date
# for example, USA GDP data may be from 2017, while population data from 2015, etc. collapsed into one row


import csv

rows = []
with open("wiid.csv", 'r') as file:
    csvreader = csv.reader(file)
    header = next(csvreader)
    for row in csvreader:
        rows.append(row)


### variables to isolate
# identifiers: country, year
# vars: gini_reported, mean, median, exchangerate, currency, mean_usd, median_usd, gdp_ppp_pc_usd2011, population

dict = {}
# {'country', 'year', 'gini_reported', 'mean', 'median', 'exchangerate', 'currency', 'mean_usd', 'median_usd', 'gdp_ppp_pc_usd2011', 'population'}
# {row[1], row[4], row[5], row[39], row[40], row[43], row[41], row[44], row[45], row[46], row[47]}
for row in rows:
  dict[row[1]] = {}
for row in rows:
  dict[row[1]][int(row[4])] = [row[5], row[39], row[40], row[43], row[41], row[44], row[45], row[46], row[47]]

collapsed = {}
for country in dict:
  years = [int(key) for key in dict[country]]
  years.sort(reverse=True)
  print(years)
  final = [''] * 9
  for year in years:
    data = dict[country][year]
    for i in range(9):
      datum = data[i]
      if final[i] == '':
        final[i] = datum
  # print("pre:", dict[c3][years[0]])
  # print("fin:", final)
  collapsed[country] = final

# convert back to CSV
new_header = ['country', 'gini_reported', 'mean', 'median', 'exchangerate', 'currency', 'mean_usd', 'median_usd', 'gdp_ppp_pc_usd2011', 'population']
with open('collapsed.csv', 'w', newline="") as file:
  csvwriter = csv.writer(file)
  csvwriter.writerow(new_header)
  for country in collapsed:
    data = collapsed[country]
    data.insert(0, country)
    csvwriter.writerow(data)
  