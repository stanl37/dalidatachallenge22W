## DALI Data Team Data Challenge
Stanley Gao '24, March 2022

### Part 1: Describe the WIID dataset given with four visualizations and four short paragraphs.



![GINI Coefficient Map made in STATA](https://i.imgur.com/CagRm3Q.png) 
*Figure 1*: A world map (Mercator projection) of reported Gini coefficients by country (as %). Each country has the most up to date reported Gini coefficient provided in the WIID dataset: The latest country data varies from country to country, but ranges from 1977 to 2017. The Gini coefficient measures income or wealth equality within a nation ([source](https://en.wikipedia.org/wiki/Gini_coefficient)). A coefficient of zero represents perfect equality – where everyone has the same income, while a coefficient of one (here, represented as 100 since we are using %) expresses maximal inequality – for an incredibly large number of people, if only one person has all the income, the Gini coefficient will be very near one. I used STATA module `spmap` to create this visualization.

![GDP PPP PC (2011 USD) made in STATA](https://i.imgur.com/dG5mZ42.png)
*Figure 2*: A world map (Mercator projection) of Gross Domestic Product converted to international dollars (here, standardized as the U.S. Dollar in 2011) using Purchasing Power Parity rates, then divided by total population to achieve Per Capita figures. Each country has the most up to date GDP PPP PC 2011USD value provided in the WIID dataset: The latest country data varies from country to country, but ranges from 1977 to 2017. GDP PPP PC measures, roughly, economic productivity and standards of living between countries ([source](https://www.investopedia.com/updates/purchasing-power-parity-ppp/)). While GDP is not a perfect measure of economic productivity for a variety of reasons, we can observe certain connections to our previous visualization on Gini coefficients. For example, the wealthy United States has large income inequality, but equally/similarly wealthy western Europe has drastically lower income inequality. Potential reasons for this difference may include differences in policy (taxation, etc.). I used STATA module `spmap` to create this visualization.

![Mean and Median Incomes (USD) made in STATA](https://i.imgur.com/ORJ7hZt.png)
*Figure 3*: World maps (Mercator projection) of mean and median incomes scaled to US Dollars. Each country has the most up to date values provided in the WIID dataset, ranging from 1977 to 2017. From this visualization, we can see that Western countries – the United States, Canada, Australia, Western Europe, etc. have the highest mean and median incomes globally. We can connect this to our GDP PPP PC visualization, as we see many similarities. GDP measures economic productivity in a quantitative way; similarly, incomes can serve as another measure of "productivity" (not considering the faults of such a measurement system). I used STATA module `spmap` to create this visualization.

![STATA Regression of GDP PPP PC on OECD Status](https://i.imgur.com/6ZITaiu.png)
*Figure 4*: A graph of Gross Domestic Product scaled using Purchasing power Parity rates, Per Capita on Organization for Economic Co-operation and Development Membership. Put simply, this is a visualization of a linear regression done to see if being a member of the OECD intergovernmental economic organization is associated with increased GDP PPP PC. The result of our t-test on the slope coefficient here generates a t-value of 87.86, and a p-value of <0.001, indicating strong statistical significance. This means there is a strong correlation between OECD membership and an increased GDP PP Per Capita. However, it must be made clear that this does not imply causality. Richer countries may be in the OECD more often due to the nature of international organizations. NATO, for example, is comprised of the West's biggest nations for a reason. We should be very careful looking at this with causality. I used STATA regressions (`reg`) and graphing (`twoway`) to create this visualization.
The regression is below.
![Regression](https://i.imgur.com/GBfucf9.png)

### Part 2: Free-Form Model Training
