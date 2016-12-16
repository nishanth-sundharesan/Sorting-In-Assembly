*------------------------------------------------------------------------
* Title         : Bubble Sort
* Written by    : Nishanth Sundharesan
* Date Created  : 10-September-2016
* Description   : Sorts the data present in 'DataToSort' using bubble sort
*                 algorithm and puts the sorted data into 'SortedData'.
*                 The data to be sorted is in words(2 bytes).
*-------------------------------------------------------------------------

START   ORG     $1000

        move.l  #(SortedData-DataToSort)/2,d0   ;Compute the length of the raw data and store it into the data register.
                                                ;We are dividing the length by 2 as the size of each data is 2 bytes or words
        move.l  d0,d2
           
        lea      DataToSort,a0                  ;Load the address of the raw data into address register a0
        lea      SortedData,a1                  ;Load the address of the 'SortedData' into address register a1
        
        *We will first move all the data present in 'DataToSort' to the 'SortedData' and then sort the
        *data within the 'SortedData'
MOVEARRAY: 
        move.w  (a0)+,(a1)+                     ;Move the data from 'DataToSort' to 'SortedData'
        subi.l  #1,d0                           ;Decrement the loop counter which is the length of the raw data
        bne     MOVEARRAY                       ;If the loop counter is != 0, then goto the label MOVEARRAY

        move.l  #1,d1                           ;Initializing the main loop counter. We are starting with 1 and not 0 as the loop only needs to execute n-1 times.
MAINLOOP:
        move.l  d2,d0                           ;Initializing the sub loop counter.
        sub.l   d1,d0                           ;Subtracting the sub loop counter with the main loop counter.
                                                ;So the sub loop counter executes (n-1) for the first loop and (n-2) for the second loop and (n-3) for the third and so on...
           
        lea     SortedData,a0                   ;Load the address of 'SortedData' into the address register
        move.l  a0,a1                           ;Copy the address of 'SortedData' and increment the pointer to the next data
        add.l   #2,a1
SUBLOOP:
        cmpm.w  (a0)+,(a1)+                     ;Compare contiguous memory locations and increment the pointer. The syntax needs to increment both address registers if we are comparing 2 memory locations.
        bge     NOSWAP                          ;If the LHS data is greater than the RHS data, then swap them
           
        *Swapping of the memory locations
        *We will index the memory locations with -2(go back and swap) as we have already incremented the pointers.
        move.w  -2(a0),d3
        move.w  -2(a1),-2(a0)
        move.w  d3,-2(a1) 
                                   
NOSWAP: 
        subi.l  #1,d0                           ;Subtract 1 from the inner loop counter
        bne     SUBLOOP                         ;If the inner loop counter is not zero, then loop back to the inner loop
                                
        addi.l  #1,d1                           ;Increment 1 to the outer loop counter
        cmp     d1,d2                           ;Compare the outer loop counter with the length of the raw data
        bne     MAINLOOP                        ;If both are equal, then exit the loop or else loop back
                                      
        STOP #$2000
        
DataToSort      INCBIN "TestData.dat"
SortedData      ds.w  (SortedData-DataToSort)/2
        END     START














*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
