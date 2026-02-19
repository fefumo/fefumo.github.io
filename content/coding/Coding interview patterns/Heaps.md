#prog
# Real world
Managing tasks in OS: Operating systems often use a priority queue to manage the execution of tasks, and a heap is commonly used to implement this priority queue efficitently.

For example, when multiple processes are running on a computer, each process might be assigned a priority level. The operating system needs to schedule the processes so that higher-priority tasks are executed before lower-priority ones. A heap is ideal for this because it allows the system to quickly access the highest-priority task and efficiently re-arrange the priorities as new tasks are added or existing tasks are completed.
# When to use?
Sorting, Finding Values in Sorted order
![[Pasted image 20260210125010.png]]
# Code
- Insert $O(\log(n))$ — adds an element to the heap, ensuring the binary tree remains correctly ordered.
- Deletion $O(\log(n))$ — Removes the leemtn at the top of th ehap, then restructures the heap to replace the top element
- Peek $O(1)$ — Retreives the top element of the heap without removing it
- Heapify $O(n)$ — tranforms an unsorted list of values into a heap
![[Pasted image 20260210132018.png]]
References
[Time complexity analysis of the heapify operation](https://www.prepbytes.com/blog/heap/time-complexity-of-building-a-heap/)
[Breakdown of heap operations ](https://en.wikipedia.org/wiki/Binary_heap)


>[!important] heapq library
>In python, we have to import heapq lib in order to get the desired functions. It’s min-heap based by default, so in order to create custom separation, redefine `__lt__` dunder method in a custom class. If no custom behavior needed and min heap is good, then tuples are the way to go:
>```python
>h = []
>heappush(h, (5, 'write code'))
>heappush(h, (7, 'release product'))
>heappush(h, (1, 'write spec'))
>heappush(h, (3, 'create tests'))
>heappop(h) # gives (1, 'write spec')
>```

