#include <stdio.h>
#include <stdlib.h>

#include "swap.h"

static void heapify(int arr[], int size, int index) {
    int left = (2 * index) + 1;
    int right = left + 1;
    int largest = index;
    
    if (left < size && arr[left] > arr[largest]) {
        largest = left;
    }

    if (right < size && arr[right] > arr[largest]) {
        largest = right;
    }
    
    if (largest != index) {
        swap(arr[index], arr[largest]);
        heapify(arr, index, largest);
    }
}

static void build_heap(int *arr, int size) {
    for (int i = (size / 2) - 1; i >= 0; --i) {
        heapify(arr, size, i);
    }
}

static void heap_sort(int *arr, int size) {
    build_heap(arr, size);
    
    for (int i = size - 1; i >= 0; --i) {
        swap(arr[0], arr[i]);
        heapify(arr, i, 0);
    }
}

int main(void) {
    int var[] = {1, 12, 9, 5, 6, 10};
    
    int a = 6;
    int b = 2;
    
    for (int i = 0; i < 6; ++i) {
        printf("%d ", var[i]);
    }
    putchar('\n');

    heap_sort(var, 6);
    
    for (int i = 0; i < 6; ++i) {
        printf("%d ", var[i]);
    }
    putchar('\n');
    
    exit(EXIT_SUCCESS);
}
