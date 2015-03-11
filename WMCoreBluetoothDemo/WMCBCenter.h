//
//  WMCBCenter.h
//  WMCoreBluetoothDemo
//
//  Created by wangwendong on 15/3/11.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMCBHeader.h"

@interface WMCBCenter : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager* iCentralManager;
@property (nonatomic, strong) NSMutableArray* iPeripheralsArray;
@property (nonatomic, strong) NSMutableArray* iConnectedPeripheralsArray;
@property (nonatomic, strong) NSMutableArray* iCharacteristicsArray;

@end
