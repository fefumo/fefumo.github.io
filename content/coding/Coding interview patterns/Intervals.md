#prog
# Real world
Scheduling systems: Intervals are widely used in scheduling systems. For instance, in a conference room booking system, each booking is represented as an interval. The interval representation is used if the system requires functionality, such as determining the maximum number of overlapping booking to ensure sufficitent room availability. By analyzing these intervals, the system cna efficiently allocate resources and prevent double bookings.
# When to use?
# Code
- We usually sort the intervals by their start point, so they can be traversed in chronological ordder. When to or more intervals have the same start point, we might also need to consider each interval’s end points during sorting.
```python
class Interval:
	def __init__(self, start, end):
		self.start = start
		self.end = end
```

>[!tip] Tip: Visualize intervals to uncover logic and edge cases.
>Managing intervals and handling edge cases is much easier when visualizing example inputs.
>Drawing examples also helps your interviewer follow along wrth your reasoning and understand your thought process.
