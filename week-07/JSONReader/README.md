#  Module 7 Homework

## Assignment

### Part 1 - Short-answer questions

a) The ____________ ____________ class allows you to interact with the file system and its contents.

FileManager

b) Apps on iOS are ____________ from each other.

Sandboxed

c) True or False:

FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] will give the document directories for all Apps the user has on their device.

False. It will give the document directory for the current app only.

d) The ____________ folder is a good place to put re-usable code when using Playgrounds.

Sources.

e) What URL property allows you to view the URL’s path?

`path` allows you to add a file name to a directory.

f) Name at least three Swift Data Types you have used up to this point in the bootcamp.

String, Int, Bool

g) How can you find the number of bytes a Data Type uses?

You can use `MemoryLayout<Type>.size`.

h) Using Playgrounds, how can you tell that the Data.write operation succeeded?

Check for errors in a do/ try/ catch block, or the absence of an error when using `try?`

i) You can mostly treat Data objects like ____________ of bytes.

Arrays.

j) The write and read methods of Data require a ____________.

URL

k) What JavaScript calls an object is the same concept as a heterogenous ____________ in Swift with ____________ for keys.

Dictionary, String types

l) How do you resolve the error: Use of unresolved identifier ‘Bundle’?

Make sure you're importing the Foundation library.

m) Give an example of Snake Case.

days_until_summer

n) A struct that will be used in the reading and writing of data must conform to the ____________ Protocol

Codable

o) Show the line of code used to access the user’s document directory for the running app.

`FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first`

p) Files added to the project that will be used by the app can be found in the ____________ ____________ when the app is running.

The Bundle.main URL

### Part 2 - Programming assignment

See homework7 branch.

### Part 3 - Above and Beyond

See homework7 branch.
