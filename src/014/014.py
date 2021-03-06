#!/usr/bin/env python

d = {1: 1} #Create a dictionary to hold each starting term and the length of its chain
           # Start with 1 having a length of 1
def collatz(x):
    if x in d: #Check if a chain for x has already been created
        return d[x] #If so, return the length of that chain
    
    nextTerm = x #Otherwise, calculate the next term
    if x % 2 == 0:
        nextTerm /= 2
    else:
        nextTerm = 3*x + 1
    #Add one for the current term, then find the length of the chain
    #starting with the next term
    length = 1 + collatz(nextTerm)
    d[x] = length #Create a new key in the dictionary with x and its length
    return d[x] #Return x's length

maxLength = 0
ans = 0
for i in range(500001,1000000,2):
    length = collatz(i)
    if length > maxLength:
        ans = i
        maxLength = length


print(ans)
