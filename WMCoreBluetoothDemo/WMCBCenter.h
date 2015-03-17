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

@property (nonatomic, strong) CBCentralManager* mCentralManager;
@property (nonatomic, strong) NSMutableArray* mPeripherals;
@property (nonatomic, strong) NSMutableArray* iConnectedPeripheralsArray;
@property (nonatomic, strong) NSMutableArray* iCharacteristicsArray;

+ (instancetype)sharedWMCBCenter;
- (void)scanPeripheralsWithRepeat:(BOOL)repeat;
- (void)rescanPeripheralsWithRepeat:(BOOL)repeat;
- (void)stopScanPeripherals;
- (void)connectPeripheral:(CBPeripheral*)peripheral;
- (void)disconnectPeripheral:(CBPeripheral*)peripheral;
- (void)writeValue:(NSString*)value toPeripheral:(CBPeripheral*)peripheral byCharacteristic:(CBCharacteristic*)characteristic withResponse:(BOOL)response;
- (void)readCharacteristic:(CBCharacteristic*)characteristic fromPeripheral:(CBPeripheral*)peripheral repeat:(BOOL)repeat everySeconds:(NSInteger)interval;

#pragma mark - Methods for U3D

// 查找蓝牙“IZOOCA BRIDGE” 搜索到后就自动连接
void connectBLEWithName();

// 获取整个游戏的 Object 对象
void initiOSInteraction(const char * unityGameObjectName);

@end
