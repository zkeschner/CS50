try:
    card = input("Card Number: ")
except:
    card = input("Card Number: ")
mult = 0
oth = 0
if (len(card) % 2 == 0):
    for number in range(0, len(card) - 1, 2):
        if ((int(card[number]) * 2) > 9):
            mult += (int(card[number]) * 2) - 9
            # print(mult)
        else:
            mult += int(card[number]) * 2
            # print(mult)
    for num in range(1, len(card), 2):
        oth += int(card[num])
else:
    for i in range(1, len(card) - 1, 2):
        if ((int(card[i]) * 2) > 9):
            mult += (int(card[i]) * 2) - 9
            # print(mult)
        else:
            mult += int(card[i]) * 2
            # print(mult)
    for b in range(0, len(card), 2):
        oth += int(card[b])
# print(oth)
# print(mult)
sum1 = oth + mult
# print(sum1)

if (sum1 % 10 == 0):
    if (card[0] == "3" and (card[1] == "7" or card[1] == "4")):
        print("AMEX")
    elif (card[0] == "5" and (card[1] == "1" or card[1] == "2" or card[1] == "3" or card[1] == "4" or card[1] == "5")):
        print("MASTERCARD")
    elif (card[0] == "4"):
        print("VISA")
    else:
        print("INVALID")
else:
    print("INVALID")
