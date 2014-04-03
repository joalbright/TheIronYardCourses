//
//  main.m
//  Analyze
//
//  Created by Jo Albright on 4/1/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

FILE *fr;

#define BUZZ_SIZE 1024


int main()
{
    char buff[BUZZ_SIZE];
    
    fr = fopen ("essays-first-series.txt", "r");
    
    fgets(buff, BUZZ_SIZE, fr);
    printf("String read: %s\n", buff);
    
//    while( != NULL)
//    {
//        /* get a line, up to 80 chars from fr.  done if NULL */
//        sscanf (line, "%ld", &elapsed_seconds);
//        /* convert the string to a long int */
//        printf ("%ld\n", elapsed_seconds);
//    }
    fclose(fr);
}

array findWords()
{
    
}
