count = 0
n = 0

while (n < 1) & (count < 1):
    try:
        height = int(input("Height: "))
    except:
        height = int(input("Height: "))
    if (0 < (height) <= 8):
        n += 1
        for i in range(height):
            for c in range((height - i) - 1):
                print(" ", end="")
            for v in range(i + 1):
                print("#", end="")
            print("  ", end="")
            for q in range(i + 1):
                print("#", end="")
            print("")
            n += 1
