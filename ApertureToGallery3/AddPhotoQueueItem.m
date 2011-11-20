//
//  AddPhotoQueueItem.m
//  Tutorial
//
//  Created by Scott Selberg on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddPhotoQueueItem.h"


@implementation AddPhotoQueueItem
@synthesize path;
@synthesize parameters;
@synthesize url;
@synthesize isPhoto;
@synthesize uploadAttempts;

- (id)init
{
    self = [super init];
    if (self) {
        self.uploadAttempts = [NSNumber numberWithInt:0];
    }
    
    return self;
}

- (id)initPhotoWithUrl:(NSString *)myUrl andPath:(NSString *)myPath andParameters:(NSMutableDictionary *)myParameters
{
    self = [super init];
    if (self) {
        [self loadIsPhoto:YES withUrl:myUrl andPath:myPath andParameters:myParameters];
    }
    return self;
}

- (id)initMovieWithUrl:(NSString *)myUrl andPath:(NSString *)myPath andParameters:(NSMutableDictionary *)myParameters
{
    self = [super init];
    if (self) {
        [self loadIsPhoto:NO withUrl:myUrl andPath:myPath andParameters:myParameters];
    }
    return self;
    
}

- (id)initWithUrl:(NSString *)myUrl andPath:(NSString *)myPath andParameters:(NSMutableDictionary *)myParameters
{
    self = [super init];
    if (self) {
        [self loadIsPhoto:YES withUrl:myUrl andPath:myPath andParameters:myParameters];
    }
    return self;
}

- (void)loadIsPhoto:(BOOL)myIsPhoto withUrl:(NSString *)myUrl andPath:(NSString *)myPath andParameters:(NSMutableDictionary *)myParameters
{
    self.isPhoto    = myIsPhoto;
    self.url        = myUrl;
    self.path       = myPath;
    self.parameters = myParameters;
}


@end
