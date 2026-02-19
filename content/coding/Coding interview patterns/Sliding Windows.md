#prog 
# Real world
Buffering in video streaming: the player downloads chunks of the video data and stores them in a buffer. A sliding window controls which part of the video is buffered, with the window ‘sliding’ forward as the video plays. The sliding window ensures the video player can adapt to varying network conditions by dynamically adjusting the buffer size and position, leading to a smoother streaming experience for the viewer

# When to use? 
Scenarios where algorithms might otherwise rely on using two nested loops to search through all possible subcomponents to find an answer, resulting in an $O(n^2)$ time complexity, or worse. When using a sliding window, the subcomponent(s) we’re looking for can usually be found in $O(n)$ time, in comparison.
- “Expand” the window — to advance the right pointer
- “Shrink” the window — to advance the left pointer
- “Slide” the window — to advance both the left and right pointers
# Code
```python
def some func(s: str):
	while right < len(s):
		# check if the conditions are met for the task
		# do smth with left pointer (possibly)
		# move the right pointer
```