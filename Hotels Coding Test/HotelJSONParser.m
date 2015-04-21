//
//  HotelJSONParser.m
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/21.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

#import "HotelJSONParser.h"

#define HOTEL_JSON_FILENAME @"hotels"
#define HOTEL_JSON_KEY @"hotels"

@implementation HotelJSONParser

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
