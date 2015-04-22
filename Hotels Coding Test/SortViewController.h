//
//  SortViewController.h
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/21.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SortViewController;

@protocol SortViewControllerDelegate

- (void)sortViewControllerDidChangeSortSetting:(SortViewController*)sortViewController;

@end

@interface SortViewController : UIViewController <UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<SortViewControllerDelegate> delegate;

@end
