//
//  WMMainViewController.m
//  WMCoreBluetoothDemo
//
//  Created by maginawin on 15/3/12.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import "WMMainViewController.h"

@interface WMMainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mPeripheralsTV;

@property (nonatomic) CBPeripheral* mPeripheral;

@end

@implementation WMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WMCB_DID_DISCOVER_PERIPHERAL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidDiscoverPeripheral:) name:WMCB_DID_DISCOVER_PERIPHERAL object:nil];
    _mPeripheralsTV.delegate = self;
    _mPeripheralsTV.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[WMCBCenter sharedWMCBCenter] disconnectPeripheral:_mPeripheral];
    [[WMCBCenter sharedWMCBCenter] rescanPeripheralsWithRepeat:YES];
    [_mPeripheralsTV performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void)handleDidDiscoverPeripheral:(NSNotification*)notify {
    [_mPeripheralsTV performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WMServicesTableViewController* servicesVC = segue.destinationViewController;
    servicesVC.mPeripheral = _mPeripheral;
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [WMCBCenter sharedWMCBCenter].mPeripherals.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"idCell0" forIndexPath:indexPath];
    cell.textLabel.text = [(CBPeripheral*)[WMCBCenter sharedWMCBCenter].mPeripherals[indexPath.row] name];
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _mPeripheral = (CBPeripheral*)[WMCBCenter sharedWMCBCenter].mPeripherals[indexPath.row];
    [[WMCBCenter sharedWMCBCenter] connectPeripheral:_mPeripheral];
    [self performSegueWithIdentifier:@"idToServices" sender:self];
}

@end
