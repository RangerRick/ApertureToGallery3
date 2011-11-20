//
//  AddPhotoQueueItem.h
//  Tutorial
//
//  Created by Scott Selberg on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AddPhotoQueueItem : NSObject {
    NSString            *path;
    NSString            *url;
    NSNumber            *uploadAttempts;
    NSMutableDictionary *parameters;
    BOOL                isPhoto;
    
}

@property (strong) NSString            *path;
@property (strong) NSString            *url;
@property (strong) NSMutableDictionary *parameters;
@property (strong) NSNumber            *uploadAttempts;
@property          BOOL                isPhoto;


- (void)loadIsPhoto:(BOOL)myIsPhoto withUrl:(NSString *)myUrl andPath:(NSString *)myPath andParameters:(NSMutableDictionary *)myParameters;
- (id)initWithUrl:(NSString *)myUrl andPath:(NSString *)myPath andParameters:(NSMutableDictionary *)myParameters;
- (id)initPhotoWithUrl:(NSString *)myUrl andPath:(NSString *)myPath andParameters:(NSMutableDictionary *)myParameters;
- (id)initMovieWithUrl:(NSString *)myUrl andPath:(NSString *)myPath andParameters:(NSMutableDictionary *)myParameters;

@end
