//
//  HotelManager.m
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/21.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

#import "HotelManager.h"

@interface HotelManager ()

@property (strong) NSMutableArray *hotels;
@property HotelManagerSortScheme currentSortScheme;

@end

@implementation HotelManager

#define HOTEL_JSON_FILENAME @"hotels"
#define HOTEL_JSON_KEY @"hotels"

// this is a singleton class
+ (HotelManager*)sharedManager {
    static HotelManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

// gets number of hotels in manager
- (NSInteger)count {
    return [_hotels count];
}

// gets hotel at index (required: 0 <= index < count)
- (Hotel*)hotelAtIndex:(NSInteger)index {
    if (index < 0 || index >= [self count])
        [NSException raise:@"Out of Bounds Exception" format:@"hotelAtIndex: index %ld is out of bounds.", index];
    
    return (Hotel*)[_hotels objectAtIndex:index];
}

// sorts the list of hotels by the user-given scheme
- (void)sortHotelsByScheme:(HotelManagerSortScheme)sortScheme {
    // check the current sort scheme; if it's the same as the user-given sort scheme, don't bother! we already have a sorted array
    if (sortScheme == _currentSortScheme)
        return;
    
    // make first sort descriptor with the user-given sort scheme
    NSSortDescriptor *variableSortDescriptor;
    switch (sortScheme) {
        case HotelManagerSortSchemeTotalRateAscending:
            variableSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"totalRate" ascending:YES];
            break;
        case HotelManagerSortSchemeDistanceFromCurrentLocationAscending:
            variableSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
            break;
        case HotelManagerSortSchemeStarRatingDescending:
            variableSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"starRating" ascending:NO];
    }
    
    // make second sort descriptor the hotel name
    NSSortDescriptor *hotelNameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    // make a sorted array using sort descriptors
    NSArray *sortDescriptors = @[variableSortDescriptor, hotelNameSortDescriptor];
    NSArray *sortedArray = [_hotels sortedArrayUsingDescriptors:sortDescriptors];
    
    // set the class's array as the sorted array
    _hotels = [[NSMutableArray alloc] initWithArray:sortedArray];
    
    // set the current sort scheme
    _currentSortScheme = sortScheme;
}

// when this class gets initialized, we want to generate the list of hotels
- (id)init {
    if (self = [super init]) {
        [self generateHotelArray];
    }
    
    return self;
}

// initializes the hotels array from json
- (void)generateHotelArray {
    // alloc/init array
    _hotels = [[NSMutableArray alloc] init];
    
    // get array of hotel dictionaries
    NSArray *hotelDictionaries = [self readJSONHotels];
    
    // fill hotels array with hotel objects created from the dictionary array
    for (NSDictionary *hotelDictionary in hotelDictionaries) {
        Hotel *hotel = [[Hotel alloc] initWithDictionary:hotelDictionary];
        [_hotels addObject:hotel];
    }
    
    // sorts array by lowest to highest total rate
    _currentSortScheme = HotelManagerSortSchemeDistanceFromCurrentLocationAscending; // set the current sort scheme to something other than what we want
                                                                                        // so that the hotels get resorted for sure
    [self sortHotelsByScheme:HotelManagerSortSchemeTotalRateAscending];
}

// parses JSON file, generates an array of dictionaries containing hotel data
- (NSArray*)readJSONHotels {
    NSData *jsonFileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:HOTEL_JSON_FILENAME ofType:@"json"]];
    NSError *error;
    NSDictionary *jsonParsedData = [NSJSONSerialization JSONObjectWithData:jsonFileData options:kNilOptions error:&error];
    NSArray *results = [jsonParsedData valueForKey:HOTEL_JSON_KEY];
    
    if (error)
        NSLog(@"%@", error);
    
    return results;
}

@end
