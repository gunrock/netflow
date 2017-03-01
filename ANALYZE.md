# How to efficiently analyze flow data?
There are some interesting approaches used to study the flow data; Top N and Baseline, Pattern Matching, etc. Regardless of the approach we take, it requires us to extract useful records from the huge amount of flow records that are available to us.

Our approach is to create a table like structure that stores the IP addresses and the `id` that they link to. These ids are also stored in a Matrix Market file format to easily construct a graph (in data formats: csr, csc, or coo) using [gunrock](https://github.com/gunrock/gunrock).

##Top N and Baseline

> A baseline is a model describing what 'normal' network activity is according to some historical traffic pattern; all traffic that falls outside the scope of this established traffic pattern will be flagged as anomalous.

> Trend and baseline analysis reports, commonly referred to as Top N and Baseline Analysis, is the most common and basic method of doing flow-based analysis. With this approach, attention is paid to flow records which have some "special high volume" characteristics, especially the value of those flow fields that deviate significantly from an established historical baseline.

Once the `.table` and `.mtx` files are created, Top N analysis is trivial to implement. If a single IP address reflects high volume sessions it can be marked as a compromised host (or under attack). Similarly, when conducting Top N and data analysis, we simply need to look at the `.table` file hosts producing abnormally high amounts of data. All these statistics are kept count in the table structure, and the problem boils down to simply sorting the data and extracting the top N results.

##Pattern Matching

> Pattern matching is another method we can use to identify abnormal network activities when doing flow-based analysis. With this method, the flow records will be searched and those hosts associated with flow fields that seem "suspicious" based on our criteria will be flagged.

Once again, looking at the `.table` file, specific functional ports can be extracted (some of the common ones are 1434 for SQL Slammer worm or 12345 for Netbus Trojan). Similarly IP addresses can be compared and matched after sorting the `.table` file and comparing them to the Internet Assigned Numbers Authority (IANA) database.
