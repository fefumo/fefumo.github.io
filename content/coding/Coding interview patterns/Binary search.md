#prog 
# Real world 
Transaction search in financial systems: binary search can be used to quickly fina a transaction or record by narrowing down the search range, as the data is typically stored in order. This makes it efficient to retrieve specific entries without searching through the entire database.
# When to use? 
# Code
Search for a value in a sorted data set

- How should the boudary variables left and right be initialized? 
- Should we use `left < right` or `left <= right` as the exit condition in our while-loop?
- How shoudl the boundary variab;es be updated? Should we choose `left = mid, left = mid +1, right = mid` or `right = mid - 1`? 

To begin any binary search implementation, do the following:
1. Define the search space.
	The search space encompasses all possible values that may include the value we’re searching for, For instance, when searching for a target in a sorted array, the search space should cover the entire array, as the target could be anywhere within it.
2. Define the behavior inside the loop for narrowing the search space.
	We can do one of these:
	- Narrow the search space toward the left (by moving the right pointer inward)
	- Narrow the search space toward the right (by moving the left pointer inward)
3. Chose an exit condition for the while-loop.
	Choices are primarily between `left < right` and `left <= right`. Both conditions are applicable in different situations.
	![[Pasted image 20260209135920.png]]
4. Return the correct value.
	The while-loop terminates once we’ve narrowed the search space down to a final value (assuming no value was returned during earlier iterations), pointed at by both left and right ( in case of `left < right` end condition ).


>[!tip] Interview Tip
>The best way to uncover unexpected errors is to test your code. In binary search, an infinite loop can be uncovered when testing a search space that contatins just two elements.