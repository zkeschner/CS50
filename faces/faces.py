def convert(str):
    new = ""
    check = False
    for i in str:
        if check == False:
            if i == ":":
                check = True
            else:
                new += i
        else:
            if i == "(":
                new += '\U0001F641'
                check = False
            elif i == ")":
                new += '\U0001F642'
                check = False
    return new

def main():
    words = input("Words: ")

    print(convert(words))

main()