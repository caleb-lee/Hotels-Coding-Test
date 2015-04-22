//
//  ListViewController.m
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/21.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

#import "ListViewController.h"
#import "HotelManager.h"
#import "HotelTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

#define LIST_TO_SORT_SEGUE_IDENTIFIER @"ListToSortSegue"

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // configure table
    self.tableView.estimatedRowHeight = 110.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)sortViewControllerDidChangeSortSetting:(SortViewController *)sortViewController {
    // refresh table data whenever data gets resorted
    [self.tableView reloadData];
    
    // scroll table to top
    [self.tableView scrollRectToVisible:CGRectMake(0.0, 0.0, 10.0, 10.0) animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:LIST_TO_SORT_SEGUE_IDENTIFIER]) {
        SortViewController *dest = segue.destinationViewController;
        dest.delegate = self;
    }
}

#pragma Mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[HotelManager sharedManager] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HotelCell";
    HotelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell.thumbnailLoadIndicator startAnimating];
    
    // get the hotel
    Hotel *hotel = [[HotelManager sharedManager] hotelAtIndex:indexPath.row];
    
    // set the thumbnail asyncrhonously
    [cell.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:hotel.thumbnailURL]
        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [cell.thumbnailLoadIndicator stopAnimating];
    }];
    
    // set all the other information
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", hotel.name];
    cell.priceLabel.text = [NSString stringWithFormat:@"$%.2f", hotel.totalRate];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.2f mi away", hotel.distance];
    cell.starsLabel.text = hotel.starRating == 1 ? @"1 star" : [NSString stringWithFormat:@"%ld stars", (long)hotel.starRating];
    
    return cell;
}

@end
