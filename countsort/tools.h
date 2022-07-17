#ifndef TOOLS_H_
#define TOOLS_H_

#include <stdio.h>
#include <stdlib.h>

// print int array with size
void pr_arr(int arr[], size_t size) {
    for (size_t i = 0; i < size; ++i)
        printf("%d ", arr[i]);
    putchar('\n');
}

// Max element of the input array
int find_max(int arr[], size_t size) {
    int max = arr[0];
    
    for (size_t i = 1; i < size; ++i) {
        if (arr[i] > max)
            max = arr[i];
    }
    
    return max;
}

// Count element in the array
// How many times it repeats
int count_of(int arr[], size_t size, int element) {
    int count = 0;
    
    for (size_t i = 0; i < size; ++i)
        if (arr[i] == element)
            ++count;
    
    return count;
}

// Calculate sum of array
int sum_of(int arr[], size_t count) {
    int sum = 0;

    for (size_t i = 0; i < count; ++i)
        sum += arr[i];
    
    return sum;
}

void fill_count_arr(int arr[], int count_arr[], size_t size) {
    for (size_t i = 0; i < size; ++i)
        count_arr[i] = count_of(arr, size, i);
}

void fill_output_arr(int out[], int arr[], int count_arr[], size_t size) {
   for (size_t i = 0; i < size; ++i)
       out[--count_arr[arr[i]]] = arr[i];
}

void cumulative_sum(int arr[], size_t size) {
    int sum = arr[0];
    
    for (size_t i = 1; i < size; ++i) {
        sum += arr[i]; arr[i] = sum;
    }
}

#endif // TOOLS_H_

