#prog
# Real World
Financial analysis: calculating cumulative earnings or expenses over time.

For instance, consider a company’s daily revenue over a month. A prefix sum array can be used to quickly calculate the total revenue for any given period within that month. By precomputing the prefix sums, the company can instantly determine the revenue from day 5 to day 20 without havng to sum each day’s revenue individually. This is especially useful for generating financial reports, where quick calculations over various periods are necessary to analyze trends.
# When to use?
Prefix sums are commonly used to efficiently determine the sum of sybarrays.
# Code
idk…
```python
def compute_prefix_sums(nums):
	prefix_sum = [nums[0]]
	for i in range(1, len(nums)):
		prefix_sum.append(prefix_sum[-1] + nums[i])
```