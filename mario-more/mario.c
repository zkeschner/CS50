#include <cs50.h>
#include <stdio.h>

int main(void)
{
    //Use nested for loops?
    int count = 0;
    int n;
    do
    {
        n = get_int("Height: ");
    }
    while (n < 1);
    while (count < 1)
    {
        if (0 <= n & n <= 8)
        {

            for (int i = 0 ; i < n; i++)
            {
                for (int y = 0; y < (n - i) - 1; y++)
                {
                    printf(" ");
                }
                for (int x = 0; x < i + 1; x++)
                {
                    printf("#");
                }
                printf("  ");
                for (int j = 0; j < i + 1; j++)
                {
                    printf("#");

                }
                printf("\n");
            }
            count += 1;
        }
    else {
        n = get_int("Height: ");
    }
    }
}