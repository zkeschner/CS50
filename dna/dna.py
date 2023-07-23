import csv
import sys


def main():
    dictionary = {

    }
    check = " "
    # TODO: Check for command-line usage
    if len(sys.argv) != 3:
        print("USAGE: python dna.py CSVfile txtfile")
        return 1
    # TODO: Read database file into a variable
    with open(sys.argv[1], "r") as f:
        reader = csv.DictReader(f)
        database = list(reader)

    # TODO: Read DNA sequence file into a variable
    with open(sys.argv[2], "r") as d:
        dnas = d.read()
    # print(len(reader.fieldnames))
    # TODO: Find longest match of each STR in DNA sequence
    for STR in database[0]:
        dictionary[STR] = longest_match(dnas, STR)
    # print(dictionary)
    # print(len(dictionary))
    # print(database)

    # TODO: Check database for matching profiles
    check_match = "No Match"
    match_count = 1
    for b in range(len(database)):
        for n in dictionary:
            if str(dictionary[n]) == database[b][n]:
                match_count += 1
        if match_count == len(dictionary):
            check_match = database[b]["name"]
            break
        else:
            match_count = 1
    print(check_match)
    return


def longest_match(sequence, subsequence):
    """Returns length of longest run of subsequence in sequence."""

    # Initialize variables
    longest_run = 0
    subsequence_length = len(subsequence)
    sequence_length = len(sequence)

    # Check each character in sequence for most consecutive runs of subsequence
    for i in range(sequence_length):

        # Initialize count of consecutive runs
        count = 0

        # Check for a subsequence match in a "substring" (a subset of characters) within sequence
        # If a match, move substring to next potential match in sequence
        # Continue moving substring and checking for matches until out of consecutive matches
        while True:

            # Adjust substring start and end
            start = i + count * subsequence_length
            end = start + subsequence_length

            # If there is a match in the substring
            if sequence[start:end] == subsequence:
                count += 1

            # If there is no match in the substring
            else:
                break

        # Update most consecutive matches found
        longest_run = max(longest_run, count)

    # After checking for runs at each character in seqeuence, return longest run found
    return longest_run


main()
