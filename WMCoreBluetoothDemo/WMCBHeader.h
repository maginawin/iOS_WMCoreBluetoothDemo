//
//  WMCBHeader.h
//  WMCoreBluetoothDemo
//
//  Created by wangwendong on 15/3/11.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#ifndef WMCoreBluetoothDemo_WMCBHeader_h
#define WMCoreBluetoothDemo_WMCBHeader_h

#import <CoreBluetooth/CoreBluetooth.h>

#define WMCB_STATE_POWEREDOFF @"WMCBStatePoweredOff"
#define WMCB_STATE_POWEREDON @"WMCBStatePoweredOn"

#define WMCB_SCAN_POWEREDOFF @"WMCBScanPoweredOff"
#define WMCB_DID_CONNECT_PERIPHERAL @"WMCBDidConnectPeripheral"
#define WMCB_DID_DISCONNECT_PERIPHERAL @"WMCBDidDisconnectPeripheral"
#define WMCB_DID_DISCOVER_PERIPHERAL @"WMCBDidDiscoverPeripheral"
#define WMCB_DID_DISCOVER_SERVICES @"WMCBDidDiscoverServices"
#define WMCB_DID_DISCOVER_CHARACTERISTICS @"WMCBDidDiscoverCharacteristics"
#define WMCB_DID_UPDATE_VALUE @"WMCBDidUpdateValue"
#define WMCB_DID_WRITE_VALUE @"WMCBDidWriteValue"
#define WMCB_DID_READ_RSSI @"WMCBDidReadRSSI"

#endif
