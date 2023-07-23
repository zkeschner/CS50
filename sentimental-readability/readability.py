text = input("Text: ")


def count_letters(text):
    letters = 0
    for words in text:
        for let in words:
            if let.isalpha() == True:
                letters += 1
    return letters


def count_sentances(text):
    sentances = 0
    for sent in text:
        for let in sent:
            if let == "." or let == "?" or let == "!":
                sentances += 1
    return sentances


def count_words(text):
    words = 1
    for word in text:
        for let in word:
            if let == " ":
                words += 1
    return words
    

letters = count_letters(text)
sentances = count_sentances(text)
words = count_words(text)
print(letters)
print(sentances)
print(words)


index = (0.0588 * (letters / words * 100) - 0.296 * (sentances / words * 100) - 15.8)
index = round(index)
if index < 1:
    print("Before Grade 1")
elif index > 16:
    print("Grade 16+")
else:
    print("Grade " + str(index))