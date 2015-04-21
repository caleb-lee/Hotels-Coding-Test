//
//  ListViewController.m
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/21.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

#import "ListViewController.h"
#import "HotelManager.h"

@interface ListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // refresh table data whenever the view appears
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[HotelManager sharedManager] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HotelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Hotel *hotel = [[HotelManager sharedManager] hotelAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - $%f", hotel.name, hotel.totalRate];
    
    return cell;
}

@end
