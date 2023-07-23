total = 0
amount_due = 50
while total < 50:
    print(f"Amount Due: {amount_due} ")
    inp = int(input("Insert Coin: "))
    if inp == 5:
        total += inp
        amount_due -= inp
    elif inp == 10:
        total += inp
        amount_due -= inp
    elif inp == 25:
        total += inp
        amount_due -= inp
    else:
        pass


change = total - 50

print(f"Change owed: {change}")


