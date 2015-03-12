//
//  WMCharTableViewController.h
//  WMCoreBluetoothDemo
//
//  Created by maginawin on 15/3/12.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMCBCenter.h"

@interface WMCharTableViewController : UITableViewController

@property (nonatomic, strong) CBService* mService;
@property (nonatomic, strong) CBPeripheral* mPeripheral;

@end
