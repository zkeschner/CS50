inp = input("Thing: ")
new = ""

check = False
for i in inp:
    if check == False:
        if i == ".":
            check = True
    elif i.isalpha() == False and i != ".":
        pass
    else:
        if i == ".":
            new = ""
        else:
            new += i.lower()
if new == "jpg":
    print("image/jpeg")
elif new == "jpeg":
    print("image/jpeg")
elif new == "gif":
    print("image/gif")
elif new == "png":
    print("image/png")
elif new == "pdf":
    print("application/pdf")
elif new == "txt":
    print("text/plain")
elif new == "zip":
    print("application/zip")
else:
    print("application/octet-stream")

