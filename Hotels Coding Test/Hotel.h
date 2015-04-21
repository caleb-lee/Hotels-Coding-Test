//
//  Hotel.h
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/21.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hotel : NSObject

// basic info
@property (readonly) NSInteger masterID;
@property (strong, readonly) NSString *key;
@property (strong, readonly) NSString *name;
@property (strong, readonly) NSString *thumbnailURL;

// location
@property (strong, readonly) NSString *streetAddress;
@property (readonly) double latitude;
@property (readonly) double longitude;
@property (readonly) double distance;
@property (strong, readonly) NSString *direction;

// ratings
@property (readonly) NSInteger starRating;
@property (readonly) double reviewScore;

// prices
@property (readonly) double nightlyRate;
@property (readonly) double promotedNightlyRate;
@property (readonly) double totalRate;
@property (readonly) double promotedTotalRate;

// inits a hotel object using an NSDictionary containing the hotel
//  information generated from the JSON
- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
