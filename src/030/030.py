#!/usr/bin/env python3
answer = -1 # Needed because 1^5 isnt a sum

#only go up to 3 for reasons
for a in range(0,3): #Ever put a loop
    for b in range(0,10): #in a loop
        for c in range(0,10): #in a loop
            for d in range(0,10): #in a loop
                for e in range(0,10): #in a loop
                    for f in range(0,10): #in a loop
                            num = f + e * pow(10,1) + d * pow(10,2) + c * pow(10,3) + b * pow(10,4) + a * pow(10,5)
                            power = pow(a,5) + pow(b,5) + pow(c,5) + pow(d,5) + pow(e,5) + pow(f,5)
                            if num == power:
                                answer += num

print(answer, end='')
