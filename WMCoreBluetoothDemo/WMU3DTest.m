//
//  WMU3DTest.m
//  WMCoreBluetoothDemo
//
//  Created by maginawin on 15/3/12.
//  Copyright (c) 2015年 WM. All rights reserved.
//


#import "WMU3DTest.h"
#import <objc/runtime.h>

@implementation WMU3DTest
static int a;

- (id)init {
    self = [super init];
    if (self) {
        a = 100;
    }
    return self;
}

void testU3D() {
    NSLog(@"%d from OC", a);
    printf("%d from C", a);
}

- (void)test {
    
}

@end
