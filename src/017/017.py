#!/urs/bin/python
import math

nums = {1: 3, 2: 3, 3: 5, 4: 4, 5: 4, 6: 3, 7: 5, 8: 5, 9: 4, 10: 3, 11: 6, 
        12: 6, 13: 8, 14: 8, 15: 7, 16: 7, 17: 9, 18: 8, 19: 8, 20: 6, 0: 0}

nums.update({30: 6, 40: 6, 50: 5, 60: 5, 70: 7, 80: 6, 90: 6, 1000: 11})

sum = 0

for i in range(1,21):
    sum += nums[i] #Sum length of all numbers from 1-20

sum *= 10 #Multiply that by 10, cause there are 10 1-20s

for h in range(0,10):
    if h > 0:
        sum += nums[h]
        sum += 7
    for i in range(1,21):
        if h > 0:
            sum += nums[h]
            sum += 10
    for i in range(21, 100):
        sum += nums[h]
        sum += 7

        sum += nums[math.floor(i / 10) * 10] #Add the length of the tens place
        sum += nums[i % 10] #Add the length of the ones place
        if h > 0: #If the hundreds place is greater than 0
            sum += 3 #Add the length of "and"
        #print(h * 100 + i)

sum += nums[1000]

print(sum)
