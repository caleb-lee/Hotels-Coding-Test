//
//  Hotel.m
//  Hotels Coding Test
//
//  Created by Caleb Lee on 2015/04/21.
//  Copyright (c) 2015年 Caleb Lee. All rights reserved.
//

#import "Hotel.h"

@interface Hotel ()

// basic info
@property (readwrite) NSInteger masterID;
@property (strong, readwrite) NSString *key;
@property (strong, readwrite) NSString *name;
@property (strong, readwrite) NSString *thumbnailURL;
@property (strong) UIImage *thumbnail;

// location
@property (strong, readwrite) NSString *streetAddress;
@property (readwrite) double latitude;
@property (readwrite) double longitude;
@property (readwrite) double distance;
@property (strong, readwrite) NSString *direction;

// ratings
@property (readwrite) NSInteger starRating;
@property (readwrite) double reviewScore;

// prices
@property (readwrite) double nightlyRate;
@property (readwrite) double promotedNightlyRate;
@property (readwrite) double totalRate;
@property (readwrite) double promotedTotalRate;

// image load NSOperationQueue
@property (strong) NSOperationQueue *imageLoadQueue;

@end

@implementation Hotel

// inits a hotel object using an NSDictionary containing the hotel
//  information generated from the JSON
- (id)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [self init]) {
        // fill in hotel info from the dictionary
        
        // basic info
        self.masterID = ((NSNumber*)[dictionary objectForKey:@"master_id"]).integerValue;
        self.key = (NSString*)[dictionary objectForKey:@"key"];
        self.name = (NSString*)[dictionary objectForKey:@"name"];
        self.thumbnailURL = (NSString*)[dictionary objectForKey:@"thumbnail"];
        
        // location
        self.streetAddress = (NSString*)[dictionary objectForKey:@"street_address"];
        self.latitude = ((NSNumber*)[dictionary objectForKey:@"latitude"]).doubleValue;
        self.longitude = ((NSNumber*)[dictionary objectForKey:@"longitude"]).doubleValue;
        self.distance = ((NSNumber*)[dictionary objectForKey:@"distance"]).doubleValue;
        self.direction = (NSString*)[dictionary objectForKey:@"direction"];
        
        // ratings
        self.starRating = ((NSNumber*)[dictionary objectForKey:@"star_rating"]).integerValue;
        self.reviewScore = ((NSNumber*)[dictionary objectForKey:@"review_score"]).doubleValue;
        
        // prices
        self.nightlyRate = ((NSNumber*)[dictionary objectForKey:@"nightly_rate"]).doubleValue;
        self.promotedNightlyRate = ((NSNumber*)[dictionary objectForKey:@"promoted_nightly_rate"]).doubleValue;
        self.totalRate = ((NSNumber*)[dictionary objectForKey:@"total_rate"]).doubleValue;
        self.promotedTotalRate = ((NSNumber*)[dictionary objectForKey:@"promoted_total_rate"]).doubleValue;
    }
    
    return self;
}

- (void)loadThumbnail:(void (^)(UIImage *thumbnail))completion {
    // if completion isn't defined, our work is for nothing, so return
    if (completion == nil)
        return;
    
    // if we already have a thumbnail, don't load it again
    if (self.thumbnail != nil) {
        completion(self.thumbnail);
    } else {
        // load the thumbnail here
        
        // make the queue
        if (self.imageLoadQueue == nil)
            self.imageLoadQueue = [[NSOperationQueue alloc] init];
        
        // load image on separate queue
        [self.imageLoadQueue addOperationWithBlock:^{
            // make URL
            NSURL *thumbnailURL = [NSURL URLWithString:self.thumbnailURL];
            
            // get data from URL
            NSData *imageData = [NSData dataWithContentsOfURL:thumbnailURL];
            
            // make image from image data
            UIImage *thumbnail = [UIImage imageWithData:imageData];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.thumbnail = thumbnail;
                completion(self.thumbnail);
            }];
        }];
    }
}

@end
