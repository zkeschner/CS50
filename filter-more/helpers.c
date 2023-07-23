#include "helpers.h"
#include <math.h>
#include <cs50.h>

// Convert image to grayscale
int square(int num)
{
    int sqr = num * num;
    return sqr;
}
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    int i = 0;
    for (i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            float blue = image[i][j].rgbtBlue;
            float red = image[i][j].rgbtRed;
            float green = image[i][j].rgbtGreen;
            int all = round((blue + red + green) / 3.0);
            //Set everything equal to the average of the values
            image[i][j].rgbtRed = all;
            image[i][j].rgbtBlue = all;
            image[i][j].rgbtGreen = all;
        }
    }

    //Find out whether the average of the values is above half or below
    //if below, set all values equal to lowest value
    //if above, set all values equal to highest value
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    int i = 0;
    RGBTRIPLE temp[height][width];
    for (i = 0; i < height; i++)
    {
        int current = 0;
        for (int j = width - 1; j >= 0; j--)
        {
            temp[i][current] = image[i][j];
            current += 1;
            //The last pixel (j, since it starts at the max width - 1 to account for indexing) is put into the first position (show by current), and so on until there are no more pixels

        }
    }
    for (i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j] = temp[i][j];
            // Transcribe the new image into the "old" image
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    int i = 0;
    RGBTRIPLE temp[height][width];
    for (i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int row[] = {i + 1, i, i - 1};
            int col[] = {j + 1, j, j - 1};
            float Totr = 0;
            float Totb = 0;
            float Totg = 0;
            int count = 0;
            for (int rows = 0; rows < 3; rows++)
            {
                for (int cols = 0; cols < 3; cols++)
                {
                    int currentr = row[rows];
                    int currentc = col[cols];

                    if ((currentr >= 0 && currentr < height) && (currentc >= 0 && currentc < width))
                    {
                        RGBTRIPLE test = image[currentr][currentc];
                        Totr += test.rgbtRed;
                        Totb += test.rgbtBlue;
                        Totg += test.rgbtGreen;
                        count += 1;
                    }


                }
            }
            temp[i][j].rgbtRed = round(Totr / count);
            //Count is to divide by the total cells to find the average, but it cant be 9 because if it is on the border it will not always be 9
            temp[i][j].rgbtBlue = round(Totb / count);
            temp[i][j].rgbtGreen = round(Totg / count);

            //count += (image[i][j+1] + image[i][j-1] + image[i+1][j] + image[i-1][j] + image[i+1][j+1] + image[i+1][j-1] + image[i-1][j+1] + image[i-1][j-1]);
        }
    }
    for (int q = 0; q < height; q++)
    {
        for (int w = 0; w < width; w++)
        {
            image[q][w] = temp[q][w];
            // Transcribe the new image into the "old" image
        }
    }
    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE temp[height][width];
    int x[3][3] = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};
    int y[3][3] = {{-1, -2, -1}, {0, 0, 0}, {1, 2, 1}};
    int i = 0;
    for (i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int row[] = {i + 1, i, i - 1};
            int col[] = {j + 1, j, j - 1};
            float xred = 0;
            float xblue = 0;
            float xgreen = 0;
            float yred = 0;
            float yblue = 0;
            float ygreen = 0;
            for (int r = 0; r < 3; r++)
            {
                for (int c = 0; c < 3; c++)
                {
                    int currentr = row[r];
                    int currentc = col[c];
                    RGBTRIPLE test = image[currentr][currentc];
                    if ((currentr >= 0 && currentr < height) && (currentc >= 0 && currentc < width))
                    {
                        xred += (test.rgbtRed * x[r][c]);
                        xblue += (test.rgbtBlue * x[r][c]);
                        xgreen += (test.rgbtGreen * x[r][c]);
                        yred += (test.rgbtRed * y[r][c]);
                        yblue += (test.rgbtBlue * y[r][c]);
                        ygreen += (test.rgbtGreen * y[r][c]);
                    }
                }
            }
            int rfinal = round(sqrt(((square(xred)) + (square(yred)))));
            if (rfinal > 255)
            {
                rfinal = 255;
            }
            int bfinal = round(sqrt(((square(xblue)) + (square(yblue)))));
            if (bfinal > 255)
            {
                bfinal = 255;
            }
            int gfinal = round(sqrt(((square(xgreen)) + (square(ygreen)))));
            if (gfinal > 255)
            {
                gfinal = 255;
            }
            temp[i][j].rgbtRed = rfinal;
            temp[i][j].rgbtGreen = gfinal;
            temp[i][j].rgbtBlue = bfinal;
        }
    }
    for (int q = 0; q < height; q++)
    {
        for (int w = 0; w < width; w++)
        {
            image[q][w] = temp[q][w];
            // Transcribe the new image into the "old" image
        }
    }
    return;
}
