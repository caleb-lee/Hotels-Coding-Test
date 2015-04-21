//
//  HotelManager.h
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/21.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

// This class manages the current list of hotels. It will read from the JSON to generate
//  a list and sort the list however the user specifies.

#import <Foundation/Foundation.h>
#import "Hotel.h"

typedef NS_ENUM(NSInteger, HotelManagerSortScheme) {
    HotelManagerSortSchemeTotalRateAscending,
    HotelManagerSortSchemeDistanceFromCurrentLocationAscending,
    HotelManagerSortSchemeStarRatingDescending
};

@interface HotelManager : NSObject

// this is a singleton class
+ (HotelManager*)sharedManager;

// gets number of hotels in manager
- (NSInteger)count;

// gets hotel at index (required: 0 <= index < count)
- (Hotel*)hotelAtIndex:(NSInteger)index;

// sorts the list of hotels by the user-given scheme
- (void)sortHotelsByScheme:(HotelManagerSortScheme)sortScheme;

// get the current sort scheme
@property (readonly) HotelManagerSortScheme currentSortScheme;

@end
