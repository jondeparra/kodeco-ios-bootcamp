#  Module 10 Homework

## Assignment

### Part 1 - Short-answer questions

a) True or False: The function URLSession.dataTask(with:completionHandler:) is synchronous.

False

b) The sleep function is synchronous and it blocks its ____________.

Thread

c) True or False: The new data(from:) async method from URLSession returns both data and a URL response object.

False

d)The code within a task closure runs sequentially, but the task itself runs on a ____________ thread.

Background

e) True or False: In the new concurrency model, you usually don't need to capture self or other variables in async functions.

True

f) When defining an asynchronous function that can throw errors, the ____________ keyword always comes before the throws keyword.

async

g) True or False: If you wrap code within a Task, it will always run on the main thread.

False

h) In SwiftUI, to resolve the issue of calling an asynchronous method in a nonconcurrent context, one can replace onAppear with ____________.

The task method

i) True or Flase: In SwiftUI, view modifiers like onAppear inherently run code asynchronously.

False

j) The ____________ keyword indicates a function contains a suspension point.

await

k) True or False: You can design your own custom asynchronous sequences in Swift.

True

l) Computed properties can be marked with both ____________ and throws.

async

m) The AsyncSequence protocol requires defining the element type and providing an ____________.  

iterator

n) Task cancellation in Swift is ____________ in nature.

cooperative

o) True or False: To detect if a task has been canceled, you can refer to the isCanceled attribute of the task.

True

p) By using async let, variables are initialized ____________.

concurrently

q) An async let constant acts like a ____________ that either a value or an error will become available.

promise
