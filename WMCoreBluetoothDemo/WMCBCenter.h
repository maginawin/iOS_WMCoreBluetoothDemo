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

#pragma mark - My property and methods 

@property (nonatomic, strong) CBCentralManager* iCentralManager;
@property (nonatomic, strong) NSMutableArray* iPeripheralsArray;
@property (nonatomic, strong) NSMutableArray* iConnectedPeripheralsArray;
@property (nonatomic, strong) NSMutableArray* iCharacteristicsArray;

#pragma mark - Methods for U3D

// 查找蓝牙“IZOOCA BRIDGE” 搜索到后就自动连接
void connectBLEWithName();

// 获取整个游戏的 Object 对象
void initiOSInteraction(const char * unityGameObjectName);

@end
