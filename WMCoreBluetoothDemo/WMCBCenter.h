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

+ (instancetype)sharedWMCBCenter;

@property (nonatomic, strong) CBCentralManager* mCentralManager;
@property (nonatomic, strong) NSMutableArray* mPeripherals;
//@property (nonatomic, strong) NSMutableArray* mConnectPeripherals;
//@property (nonatomic, strong) NSMutableArray* mCharacteristics;
//@property (nonatomic, strong) NSMutableArray* mConnectCharacteristics;

- (void)scanPeripheralsWithRepeat:(BOOL)repeat;
- (void)rescanPeripheralsWithRepeat:(BOOL)repeat;
- (void)stopScanPeripherals;
- (void)connectPeripheral:(CBPeripheral*)peripheral;
- (void)disconnectPeripheral:(CBPeripheral*)peripheral;
- (void)writeValue:(NSString*)value toPeripheral:(CBPeripheral*)peripheral byCharacteristic:(CBCharacteristic*)characteristic withResponse:(BOOL)response;
- (void)readCharacteristic:(CBCharacteristic*)characteristic fromPeripheral:(CBPeripheral*)peripheral repeat:(BOOL)repeat everySeconds:(NSInteger)interval;

@end
