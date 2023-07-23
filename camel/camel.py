inp = input("Camel Case: ")
new = ""
for i in inp:
    if i == i.upper():
        new += "_"
        new += i.lower()
    else:
        new += i
print(new)