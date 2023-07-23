#include <stdio.h>
#include <cs50.h>




int main(void)
{
    //Asks what someone's name is, then says hello using that name
    string name = get_string("What is your name?: ");
    printf("hello, %s\n", name);
}