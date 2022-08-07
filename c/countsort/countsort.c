#include "tools.h"

#include <string.h>

__noinline 
void count_sort(int arr[], ssize_t size) {
    // Max element of the input array
    int max = find_max(arr, size);
    
    int *count_arr = malloc(sizeof(int) * (max + 1));
    int *output_arr = malloc(sizeof(int) * size);
    
    // Initialize both arrays with zeroes
    memset(count_arr, 0, sizeof(int) * (max + 1));
    memset(output_arr, 0, sizeof(int) * size);
    
    // Store the count of each element 
    fill_count_arr(arr, count_arr, max + 1);
    
    // Store cumulative sum of the elements of
    // the count array
    cumulative_sum(count_arr, max + 1);
    
    // Find the index of each element of the original 
    // array in the count array
    fill_output_arr(output_arr, arr, count_arr, size);
    
    // move output array into original
    memmove(arr, output_arr, sizeof(int) * size);
    
    free(count_arr);
    free(output_arr);
}

int main(void) {
	int arr[] = {4, 2, 2, 8, 3, 3, 1};
    
    count_sort(arr, 7);
    
	return 0;
}

