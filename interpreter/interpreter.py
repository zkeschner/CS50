inp = input("Expression: ")
inp = inp.split()
x = float(inp[0])
y = inp[1]
z = float(inp[2])
if y == "*":
     print(float(x * z))
elif y == "/":
    print(float(x / z))
elif y == "+":
    print(float(x + z))
elif y == "-":
    print(float(x - z))
