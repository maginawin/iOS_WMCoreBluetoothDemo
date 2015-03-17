//
//  WMCBCenter.m
//  WMCoreBluetoothDemo
//
//  Created by wangwendong on 15/3/11.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import "WMCBCenter.h"

@interface WMCBCenter()

@property (nonatomic) BOOL mIsScanningPeripherals;

@property (nonatomic) NSMutableArray* mCharacteristics;

@property (nonatomic) NSInteger mCTag;
@property (nonatomic) BOOL c0;
@property (nonatomic) BOOL c1;
@property (nonatomic) BOOL c2;
@property (nonatomic) BOOL c3;

@end

@implementation WMCBCenter
const char* gameObjectName;

+ (instancetype)sharedWMCBCenter {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        sharedInstance = [[self alloc] initWithDelegate];
    });
    return sharedInstance;
}

- (instancetype)initWithDelegate {
    self = [super init];
    if (self) {
        _mCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
        _mPeripherals = [[NSMutableArray alloc] init];
        _mCharacteristics = [[NSMutableArray alloc] init];
        _mIsScanningPeripherals = NO;
        _mCTag = 0;
        _c0 = _c1 = _c2 = _c3 = NO;
    }
    return self;
}

#pragma mark - CB Central Manager Delegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStatePoweredOff: {

            break;
        }
        case CBCentralManagerStatePoweredOn: {

            break;
        }
            
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    if (![_mPeripherals containsObject:peripheral]) {
        [_mPeripherals addObject:peripheral];
        [[NSNotificationCenter defaultCenter] postNotificationName:WMCB_DID_DISCOVER_PERIPHERAL object:peripheral];
    }
    if ([peripheral.name isEqualToString:@"IZOOCA BRIDGE"]) {
        NSLog(@"找到 IZOOCA BRIDGE, 停止查找设备, 准备连接 IZOOCA...");
        [self stopScanPeripherals];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self connectPeripheral:peripheral];
        });
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
        peripheral.delegate = self;
        [peripheral discoverServices:nil];
    if ([peripheral.name isEqualToString:@"IZOOCA BRIDGE"]) {
        NSLog(@"已经连接上 IZOOCA BRIDGE, 准备查找 Characteristics...");
    }
        [[NSNotificationCenter defaultCenter] postNotificationName:WMCB_DID_CONNECT_PERIPHERAL object:peripheral];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    [[NSNotificationCenter defaultCenter] postNotificationName:WMCB_DID_DISCONNECT_PERIPHERAL object:peripheral];
}

#pragma mark - CB Peripheral Delegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for (CBService* service in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:service];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:WMCB_DID_DISCOVER_SERVICES object:peripheral.services];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"C35232EA-5E47-486D-A1E8-9502EA284F90"]]) {
        for (CBCharacteristic* c in service.characteristics) {
            if ([c.UUID isEqual:[CBUUID UUIDWithString:@"6E16485F-E936-4665-BF03-D339275831F2"]]) {
                [_mCharacteristics addObject:c];
            }
        }
        if (_mCharacteristics.count == 4) {
            NSLog(@"Characteristics 已经找到, 准备监听 (Read value)");
            [self repeatReadCharacteristicsFromPeripheral:peripheral];
        } else {
            [self disconnectPeripheral:peripheral];
            [self rescanPeripheralsWithRepeat:YES];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:WMCB_DID_DISCOVER_CHARACTERISTICS object:service.characteristics];
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSString* valueString = [WMCBCenter hexadecimalString:characteristic.value];
    if ([valueString containsString:@"58794F59"]) {
        
    } else if ([valueString containsString:@"798C647C"]) {
        
    } else if ([valueString isEqualToString:@""] || valueString == nil) {
    
    }
    
    switch (_mCTag) {
        case 0: {
            
            break;
        }
        case 1: {
            break;
        }
        case 2: {
            break;
        }
        case 3: {
            break;
        }

            
        default:
            break;
    }
    _mCTag += 1;
    if (_mCTag > 3) {
        _mCTag = 0;
    }
//    NSLog(@"c : %@", [NSString stringWithFormat:@"%@", characteristic.value]);
    [[NSNotificationCenter defaultCenter] postNotificationName:WMCB_DID_UPDATE_VALUE object:characteristic];
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {

}

// iOS 5.0 and later but before iOS 8.0
- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error {

}

// iOS 8.0 and later
- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error {

}

#pragma mark - Handle CB Central And Peripheral

- (void)scanPeripheralsWithRepeat:(BOOL)repeat {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        if (_mCentralManager.state == CBCentralManagerStatePoweredOn) {
            if (!_mIsScanningPeripherals) {
                _mIsScanningPeripherals = YES;
                NSDictionary* scanOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
                [_mCentralManager scanForPeripheralsWithServices:nil options:scanOptions];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (_mIsScanningPeripherals) {
                        [_mCentralManager stopScan];
                        _mIsScanningPeripherals = NO;
                        if (repeat) {
                            [self scanPeripheralsWithRepeat:YES];
                        }
                    }
                });
            } else {
                [_mCentralManager stopScan];
                _mIsScanningPeripherals = NO;
                [self scanPeripheralsWithRepeat:repeat];
            }
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:WMCB_SCAN_POWEREDOFF object:nil];
        }
    });
}

- (void)rescanPeripheralsWithRepeat:(BOOL)repeat {
    [self stopScanPeripherals];
    _mPeripherals = nil;
    _mPeripherals = [[NSMutableArray alloc] init];
    _mCharacteristics = nil;
    _mCharacteristics = [[NSMutableArray alloc] init];
    _c0 = _c1 = _c2 = _c3 = NO;
    [self scanPeripheralsWithRepeat:repeat];
}

- (void)stopScanPeripherals {
    [_mCentralManager stopScan];
    _mIsScanningPeripherals = NO;
}

- (void)connectPeripheral:(CBPeripheral*)peripheral {
    if (peripheral) {
        [_mCentralManager connectPeripheral:peripheral options:nil];
    }
}

- (void)disconnectPeripheral:(CBPeripheral*)peripheral {
    if (peripheral && peripheral.state == CBPeripheralStateConnected) {
        [_mCentralManager cancelPeripheralConnection:peripheral];
    }
}

- (void)writeValue:(NSString*)value toPeripheral:(CBPeripheral*)peripheral byCharacteristic:(CBCharacteristic*)characteristic withResponse:(BOOL)response {
    if (value && peripheral && peripheral.state == CBPeripheralStateConnected) {
        if (response) {
            [peripheral writeValue:nil forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
        } else {
            [peripheral writeValue:nil forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
        }
    }
}

- (void)readCharacteristic:(CBCharacteristic*)characteristic fromPeripheral:(CBPeripheral*)peripheral repeat:(BOOL)repeat everySeconds:(NSInteger)interval {
    if (characteristic && peripheral && peripheral.state == CBPeripheralStateConnected) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
            [peripheral readValueForCharacteristic:characteristic];
            if (repeat) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self readCharacteristic:characteristic fromPeripheral:peripheral repeat:repeat everySeconds:interval];
                });
            }
        });
    }
}

- (void)repeatReadCharacteristicsFromPeripheral:(CBPeripheral*)peripheral {
    if (_mCharacteristics.count > 0 && peripheral.state == CBPeripheralStateConnected) {
        for (int i = 0; i < _mCharacteristics.count; i++) {
            [peripheral readValueForCharacteristic:_mCharacteristics[i]];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self repeatReadCharacteristicsFromPeripheral:peripheral];
        });
    }
}

- (void)readCharacteristic:(CBCharacteristic*)characteristic fromPeripheral:(CBPeripheral*)peripheral {
    [peripheral readValueForCharacteristic:characteristic];
}

#pragma mark - Methods for U3D

void connectBLEWithName() {
    [[WMCBCenter sharedWMCBCenter] rescanPeripheralsWithRepeat:YES];
}

void initiOSInteraction(const char * unityGameObjectName) {
    gameObjectName = unityGameObjectName;
}

#pragma mark - Methods for CB

+ (NSString*)hexadecimalString:(NSData *)data{
    NSString* result;
    const unsigned char* dataBuffer = (const unsigned char*)[data bytes];
    if(!dataBuffer){
        return nil;
    }
    NSUInteger dataLength = [data length];
    NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for(int i = 0; i < dataLength; i++){
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    result = [NSString stringWithString:hexString];
    return result;
}

@end
