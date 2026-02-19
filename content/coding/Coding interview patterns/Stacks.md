#prog 
# Real World
Function call management in OS. When a function is called, the program pushes the function’s state (including its parameters, local variables and the return address) onto the call stack. As function call other functions, their states are also pushed onto the stack. When a function completes, its state is popped off the stack, and the program returns to the calling fuinction. This stack-based approach ensures that functions return control in the correct order, managing nested or recursive function calls efficiently.

# When to use?
- Hadnling nested structues: Stacks are a good option for parsing or validating nested structures such as nested parenthesese in a string. They allow us to process the inneremost nested structures fist due to the LIFO principle.
- Reverse order: When elements are added (pushed) onto a stack and then removed (popped), they come out in the reverse order of how they were added. This property is useful for reversing sequences.
- Substitute for recursion: Recursive algorithms use the recursive call stack calls. Ultimately, this recursive call stack is itself a stack. As such, we can often implement recursive functions iteratively using the stack data structure.
- Monotonic stacks. These special-puprose stacks maintain elements in a consistent, increasing or decreasing sorted order. Before adding a new element to the stack, any elements that break this order are removed from the top of the stack ,ensuring the stack remains sorted.
# Code
push pop goes brr