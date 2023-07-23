#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int num1 = 0;
    int num2 = 0;
    long number = get_long("Enter credit card number: ");
    int count = 1;
    int num3 = 0;
    int card = 0;
    long ten = 10;
    while ((card == 0) && ((number / ten) > 0))
    {
        if ((number / ten == 34) || (number / ten == 37))
        {
            card = 1;
        }
        else if ((number / ten == 51) || (number / ten == 52) || (number / ten == 53) || (number / ten == 54) || (number / ten == 55))
        {
            card = 2;
        }
        else if (number / ten == 4)
        {
            card = 3;
        }
        else
        {
            ten = ten * 10;
        }
    }
    while (number > 0)
    {
        if (count == 1)
        {
            num1 += number % 10;
            number = number / 10;
            count -= 1;
        }
        else
        {
            if (((number % 10) * 2) > 9)
            {
                int num5 = ((number % 10) * 2) - 9;
                num2 = num5 + num2;
                number = number / 10;
                count += 1;
            }
            else
            {
                num2 += (number % 10) * 2;
                number = number / 10;
                //num2 += (number % 10) * 2;
                //number = number / 10;
                count += 1;
            }
        }
    }
    num3 = num1 + num2;
    if ((num3 % 10 == 0) && (card == 1) && (ten > 100000000000))
    {
        printf("AMEX\n");
    }
    else if ((num3 % 10 == 0) && (card == 2) && (ten > 100000000000))
    {
        printf("MASTERCARD\n");
    }
    else if ((num3 % 10 == 0) && (card == 3) && (ten > 100000000000))
    {
        printf("VISA\n");
    }
    else
    {
        printf("INVALID\n");
    }

}