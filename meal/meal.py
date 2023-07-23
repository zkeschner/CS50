def main():
    time = input("What is the time: ")
    time = convert(time)
    if 7 <= time <= 8:
        print("breakfast time")
    elif 12 <= time <= 13:
        print("lunch time")
    elif 18 <= time <= 19:
        print("dinner time")

def convert(time):
    time.split()
    newtime = ""
    if len(time) == 5:
        if time[3] == 0 and time[4] == 0:
            pass
        else:
            newtime += time[3]
            newtime += time[4]
            newtime = int(newtime)
            newtime = newtime / 60

        finaltime = int(time[0] + time[1]) + newtime
        return finaltime
        return time[0] + time[1] + "." + str(newtime)[2]
    elif len(time) == 4:
        if time[2] == 0 and time[3] == 0:
            pass
        else:
            newtime += time[2]
            newtime += time[3]
            newtime = int(newtime)
            newtime = newtime / 60
        finaltime = int(time[0]) + newtime
        return finaltime



if __name__ == "__main__":
    main()