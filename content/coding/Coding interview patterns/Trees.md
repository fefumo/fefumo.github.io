#prog
# Real world
File systems: In many operating systems, the file system is organized as a hierarchial tree structure. The root directory is the root of the tree, and every file or folder in the system is a node. Folders can have subfolders or files as child nodes, and this structure allows for efficient organization, naviagaion, and retrieval of files. When you browse through folders on a computer, you’re essentially navigating a tree structure.
# Code
```python
class TreeNode:
	def __init__(self, val):
		self.val = val
		self.left = None
		self.right = None
```
### DFS (Depth-first search)
```python
def dfs(node: TreeNode):
	if node is None:
		return
	process(node)
	dfs(node.left)
	dfs(node.right)
```

traversals:

| preorder                           | inorder                            | postorder                          |
| ---------------------------------- | ---------------------------------- | ---------------------------------- |
| process<br>dfs(left)<br>fgs(right) | dfs(left)<br>process<br>dfs(right) | dfs(left)<br>dfs(right)<br>process |
- Preorder traversal is used when we need to process the root node of each subtree before its children
- Inorder traversal is used when we want ot process the nodes of a tree from left to right
- Postorder traversal is important when each node’s subtrees must be processed before their root

### BFS (Breadth-first search)
BFS processes the nodes at the present level before moving on to nodes at the next depth level.
```python
def bfs(root: TreeNode):
	is root is None:
		return
	queue = deque([root])
	while queue:
		node = queue.popleft()
		process(node)
		if node.left:
			queue.append(node.left)
		if node.right:
			queue.append(node.right)
```
- typically use queue.
its commonly used to find the shortest path to a specific destination in a tree, or to process the tree level by leve. When it’s important to know the specific level of each node during traversal, we use a variant of BFS called level-order traversal.