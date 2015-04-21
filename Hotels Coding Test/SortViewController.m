//
//  SortViewController.m
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/21.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

#import "SortViewController.h"
#import "HotelManager.h"

@interface SortViewController ()
- (IBAction)doneButtonAction:(id)sender;

@end

@implementation SortViewController

- (IBAction)doneButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma Mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Sort by price";
            break;
        case 1:
            cell.textLabel.text = @"Sort by distance from here";
            break;
        case 2:
            cell.textLabel.text = @"Sort by star rating";
            break;
        default:
            cell.textLabel.text = @"";
            break;
    }
    
    return cell;
}

#pragma Mark - UINavigationBarDelegate
// this makes the UINavigationBar extend to the top of the screen and account for the extra space
//  taken up by the status bar
- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
}
@end
