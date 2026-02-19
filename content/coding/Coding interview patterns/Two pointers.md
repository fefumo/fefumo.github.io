#prog
The easiest one
# Real world
Used in garbage collectors. in memory compaction — which is a key part of garbage collection, the goal is to free up contiguous memory space by eliminating gaps left by deallocated (aka dead) objects. A ‘scan’ pointer traverses the heap to identify live objects, while a ‘free’ pointer keeps track of the next available space to  where live objects should be relocated. As the ‘scan’ pointer moves, it skips over dead objects and shifts live objects to the position indicated by the ‘free’ pointer, compacting the memory by grouping all live objects together and freeing up contiguous blocks of memory.

# When to use?
A two pointer algorithm usually requires a linear data structure, such as an array or linked list. Otherwise, an indication that a problem can be solved using the two-pointer algorithm, is when the input follows a predictable dynamic, such as a sorted array.

Predictable dynamics can take many forms. Take, for instance, a palindroming string. Its symmetrical pattern allows us to logically move two pointers toward the center.

Another potential indicator that a problem can be solved using two pointers is if the problem asks for a pair of values or a result that can be generated from two values.
# Code
Structure:
```python
# left,right pointers
while left < right: 
	do_smth()
```
