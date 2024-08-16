//
//  Math384.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 9/2/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#include <stdlib.h>

#ifndef TEORWorldMapTest_Math384_h
#define TEORWorldMapTest_Math384_h

int i = 0;
printf(@"%x\n", &i); //will print hex address of int i.

//Arrays
int *a;
a = (int *)malloc(3 * 4); //mallocs 3 registers of 4 bytes for ints
a[0] = 8;
a[1] = 16;
a[2] = 3;

//complex number data type
typedef struct _cplex {
    float real;
    float imag;
} cplex;

typedef int boolean;
/*
complex cof(float r, float i) {
    complex c;
    c.real = r;
    c.imag = i;
    return c;
}

complex csum(complex a, complex b) {
    complex c;
    c.real = a.real + b.real;
    c.imag = a.imag + b.imag;
    return c;
}*/

complex *cof(float r, float i) {
    cplex *c = (cplex *)malloc(sizeof(cplex));
    c->real = r;
    i->imag = r;
    return c;
}

complex *csum(complex *a, complex *b) {
    complex *c = cof(a->real + b->real, a->imag + b->imag);
    return c;
}

//open hashing/bucket or chain hashing and closed hashing we want to rehash (double size of array) when array is half-full. 

#endif
