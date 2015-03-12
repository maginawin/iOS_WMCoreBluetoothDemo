//
//  WMCharTableViewController.m
//  WMCoreBluetoothDemo
//
//  Created by maginawin on 15/3/12.
//  Copyright (c) 2015年 WM. All rights reserved.
//

#import "WMCharTableViewController.h"

@interface WMCharTableViewController ()

@end

@implementation WMCharTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WMCB_DID_UPDATE_VALUE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidUpdateValue:) name:WMCB_DID_UPDATE_VALUE object:nil];
}

- (void)handleDidUpdateValue:(NSNotification*)notify {
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    [self readRepeat:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self readRepeat:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mService.characteristics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCell0" forIndexPath:indexPath];
    CBCharacteristic* c = _mService.characteristics[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", c.value];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [c UUID]];
    
    return cell;
}


- (void)readRepeat:(BOOL)repeat {
    for (int i = 0; i < _mService.characteristics.count; i++) {
        CBCharacteristic* c = _mService.characteristics[i];
        [[WMCBCenter sharedWMCBCenter] readCharacteristic:c fromPeripheral:_mPeripheral repeat:repeat everySeconds:2];
    }
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
