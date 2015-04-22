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
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)doneButtonAction:(id)sender;

@property (nonatomic) HotelManagerSortScheme originalSortScheme;
@property (nonatomic) HotelManagerSortScheme currentSortScheme;
@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set original sort scheme and current sort scheme
    self.originalSortScheme = [[HotelManager sharedManager] currentSortScheme];
    self.currentSortScheme = self.originalSortScheme;
}

- (IBAction)doneButtonAction:(id)sender {
    // resort, call delegate, dismiss
    if (self.originalSortScheme != self.currentSortScheme) {
        [[HotelManager sharedManager] sortHotelsByScheme:self.currentSortScheme];
        [self.delegate sortViewControllerDidChangeSortSetting:self];
    }
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
            if ([[HotelManager sharedManager] currentSortScheme] == HotelManagerSortSchemeTotalRateAscending)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            cell.textLabel.text = @"Sort by total rate";
            break;
        case 1:
            if ([[HotelManager sharedManager] currentSortScheme] == HotelManagerSortSchemeDistanceFromCurrentLocationAscending)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            cell.textLabel.text = @"Sort by distance from here";
            break;
        case 2:
            if ([[HotelManager sharedManager] currentSortScheme] == HotelManagerSortSchemeStarRatingDescending)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            cell.textLabel.text = @"Sort by star rating";
            break;
        default:
            cell.textLabel.text = @"";
            break;
    }
    
    return cell;
}

#pragma Mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // uncheck the currently checked cell
    switch ([[HotelManager sharedManager] currentSortScheme]) {
        case HotelManagerSortSchemeTotalRateAscending:
            [self uncheckCellAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            break;
        case HotelManagerSortSchemeDistanceFromCurrentLocationAscending:
            [self uncheckCellAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            break;
        case HotelManagerSortSchemeStarRatingDescending:
            [self uncheckCellAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            break;
    }
    
    // check the new cell, resort the hotels
    switch (indexPath.row) {
        case 0:
            [self setCurrentSortScheme:HotelManagerSortSchemeTotalRateAscending];
            [self checkCellAtIndexPath:indexPath];
            break;
        case 1:
            [self setCurrentSortScheme:HotelManagerSortSchemeDistanceFromCurrentLocationAscending];
            [self checkCellAtIndexPath:indexPath];
            break;
        case 2:
            [self setCurrentSortScheme:HotelManagerSortSchemeStarRatingDescending];
            [self checkCellAtIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    // deselect row
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)uncheckCellAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
}

- (void)checkCellAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
}

#pragma Mark - UINavigationBarDelegate
// this makes the UINavigationBar extend to the top of the screen and account for the extra space
//  taken up by the status bar
- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
}
@end
