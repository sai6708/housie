import random
import pandas as pd

def housieticket():
    i = 1
    j = 10
    count = 0
    count1 = 0
    count2 = 0

    rowcount5 = [0, 0, 0]
    one_digit_cols = []
    two_digit_cols = []
    ticketarr = [[0 for va in range(9)] for val in range(3)]
    ticketarr_final = [[0 for va in range(9)] for val in range(3)]
    temprow = 0

    while count1 < 15:
        k = random.randint(1, 2)
        if k == 1:
            count += 1
            if count > 3:
                k = 2
        if k == 2:
            count2 += 1
            if count2 > 6:
                k = 1
        r = random.sample(range(i, j), k)
        r.sort()
        count1 += len(r)

        ticketarr[temprow][(int(j/10)-1)] = r[0]

        if k == 2:
            ticketarr[temprow+1][(int(j/10)-1)] = r[1]
            two_digit_cols.append(int(j/10)-1)
        else:
            one_digit_cols.append(int(j/10)-1)

        i = j
        j = j + 10
        if i == 90:
            if j == 100:
                break
            else:
                continue

    def sortticket():
        for i in two_digit_cols:
            randrowlist = [elem for elem in [0, 1] if rowcount5[elem] < 5]
            if randrowlist:  # Ensure the list is not empty
                temprow = random.sample(randrowlist, 1)[0] if len(randrowlist) > 1 else randrowlist[0]
                if temprow == 1 and rowcount5[temprow] == 4:
                    temprow = 0
                ticketarr_final[temprow][i] = ticketarr[0][i]
                rowcount5[temprow] += 1

                if temprow == 1:
                    if rowcount5[2] == 5:
                        rowcount5[temprow] -= 1
                        ticketarr_final[0][i] = ticketarr_final[1][i]
                        rowcount5[0] += 1
                        ticketarr_final[1][i] = ticketarr[1][i]
                        rowcount5[1] += 1
                    else:
                        ticketarr_final[2][i] = ticketarr[1][i]
                        rowcount5[2] += 1
                else:
                    randrowlist = [elem for elem in [1, 2] if rowcount5[elem] < 5]
                    if randrowlist:  # Ensure the list is not empty
                        temprow = random.sample(randrowlist, 1)[0] if len(randrowlist) > 1 else randrowlist[0]
                        ticketarr_final[temprow][i] = ticketarr[1][i]
                        rowcount5[temprow] += 1

        for j in one_digit_cols:
            randrowlist = [elem for elem in [0, 1, 2] if rowcount5[elem] < 5]
            if randrowlist:  # Ensure the list is not empty
                temprow = random.sample(randrowlist, 1)[0] if len(randrowlist) > 1 else randrowlist[0]
                ticketarr_final[temprow][j] = ticketarr[0][j]
                rowcount5[temprow] += 1

        #print(pd.DataFrame(ticketarr_final))
        print(ticketarr_final)
        print("\n")

    sortticket()

for a in range(100):
    print("Ticket number: " + str(a))
    housieticket()
