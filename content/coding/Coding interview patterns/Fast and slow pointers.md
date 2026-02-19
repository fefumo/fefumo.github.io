#prog 
# Real world
Detecting cycles in symlinks: symlinks are shortcuts that point to files or directories in a file system. A real-world example of using the fast and slow pointer technique is detecting cycles in symlinks.

In this process, the slow pointer follows each symlink one step at a time, while the fast pointer moves two steps at a time. If the fast pointer catches up to the slow pointer, it indicates a loop in the symlinks, which can cause infinite loops or errors when accessing files.
# When to use? 
Fast and slow pointers are particularly beneficial in data structures like linked lists, where index-based access isn’t available. They allow us to gather crucial information about the data structure’s elements through the relative positions of the two pointers, rather than with indexing. This will become clearer as we explore some common use cases in this chapter.
# Code
```python
def func(head: ListNode):
	slow = fast = head
	while fast and fas.next:
		slow = slow.next
		fast = fast.next.next
		# some logic to end the loop
```