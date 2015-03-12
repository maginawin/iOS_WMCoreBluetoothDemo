//
//  WMServicesTableViewController.m
//  WMCoreBluetoothDemo
//
//  Created by maginawin on 15/3/12.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import "WMServicesTableViewController.h"


@interface WMServicesTableViewController ()

@property (nonatomic, strong) CBService* mService;

@end

@implementation WMServicesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WMCB_DID_DISCOVER_SERVICES object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WMCB_DID_DISCONNECT_PERIPHERAL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidDiscoverServices:) name:WMCB_DID_DISCOVER_SERVICES object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidDiscoverServices:) name:WMCB_DID_DISCONNECT_PERIPHERAL object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WMCharTableViewController* theSegue = segue.destinationViewController;
    theSegue.mService = _mService;
    theSegue.mPeripheral = _mPeripheral;
}

- (void)handleDidDiscoverServices:(NSNotification*)notify {
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mPeripheral.services.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCell0" forIndexPath:indexPath];
    if (_mPeripheral.services.count > 0) {
        NSString* uuidString = [NSString stringWithFormat:@"%@", [_mPeripheral.services[indexPath.row] UUID]];
        cell.textLabel.text = uuidString;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _mService = _mPeripheral.services[indexPath.row];
    [self performSegueWithIdentifier:@"idToCharacteristic" sender:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
