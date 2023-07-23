inp = str(input("Greeting: "))
inp = inp.split()
if inp[0].lower() == "hello" or inp[0].lower() == "hello,":
    print("$0")
else:
    if inp[0][0].lower() == "h":
        print("$20")
    else:
        print("$100")