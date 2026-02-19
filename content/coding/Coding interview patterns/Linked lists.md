#prog 
# Real world
Music playlist: music player application often use linked lists to implement playlists, particularly doubly linked lists, where each song node links to the next previous songs. This structure enables efficient addition, removal and reordering of songs because only the pointers between nodes need to be updated, rather than moving the song data in memory.
# When to use?
Singly linked lists can be used to store a collection of data. One of their main benefits lies in their dynamic sizing capability, since they can grow or shrink in size flexibly, unlike arrays which are fixed in size. Additionally, singly linked lists excel in scenarios requiring frequent insertions and deletions, as these operations can be performed more efficiently than in arrays, which need to shift elements to perform insertion or deletion.

# Code
```python
class ListNode:
    def __init__(self, val, next):
        self.val = val
        self.next = next

class DoublyLinkedListNode:
    def __init__(self, key, val):
        self.key = key
        self.val = val
        self.prev = self
        self.next = self
```

> [!tip] Interview Tip
> Visualize Pointer manipulations
> Often, it can be tricky to figure out exactly what to do when dealing with linked list manipulation. Drawing pointers as arrows between nodes can be quite helpful. By observing how these arrows should be reoriented to represent changes in the linked list’s structure, we can deduce the necessary pointer manipulation logic. This approach also helps identify which nodes we need references to when making these changes.
