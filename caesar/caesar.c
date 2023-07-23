#include <cs50.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
bool check_num(string arg);
int main(int argc, string argv[])
{
    string arg = argv[1];
    if ((argc == 2) && (check_num(arg) == 0))
    {
        string text = get_string("plaintetxt:  ");
        int i = 0;
        for (i = 0; i < strlen(text); i++)
        {
            if (((atoi(arg) + text[i]) >= 65 && (atoi(arg) + text[i]) <= 90) || ((atoi(arg) + text[i] >= 97) && (atoi(arg) + text[i] <= 122)))
            {
                text[i] = text[i] + atoi(arg);
            }
            else if (atoi(arg) > 26)
            {
                if ((((atoi(arg) % 26) + text[i]) >= 65 && ((atoi(arg) % 26) + text[i]) <= 90) || (((atoi(arg) % 26) + text[i] >= 97) &&
                        ((atoi(arg) % 26) + text[i] <= 122)))
                {
                    text[i] = text[i] + (atoi(arg) % 26);
                }
                else
                {
                    text[i] = text[i] - (26 - atoi(arg) % 26);
                }
            }
            else if ((((text[i] + atoi(arg)) > 90) && ((text[i] + atoi(arg)) < 97)) || ((text[i] + atoi(arg)) > 122))
            {
                text[i] = text[i] - (26 - atoi(arg));
            }
            else
            {
                text[i] = text[i];
            }
        }
        printf("ciphertext: %s\n", text);
    }
    else
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }
}
bool check_num(string arg)
{
    int i = 0;
    int num = 0;
    for (i = 0; i < strlen(arg); i++)
    {
        if (isdigit(arg[i]) != 0)
        {
            num = 0;
        }
        else
        {
            num = 1;
            return 1;
        }
    }
    if (num == 0)
    {
        return 0;
    }
    else
    {
        return 1;
    }
}