//
//  GalleryInfo.h
//  Tutorial
//
//  Created by Scott Selberg on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GalleryInfo : NSObject {
    NSString *name;
    NSString *url;
    NSString *key;
    NSString *username;
}

- (id)initWithName:(NSString*)myName andUrl:(NSString*)myUrl andUsername:(NSString*)myUsername andKey:(NSString*)myKey;

@property(strong) NSString *name;
@property(strong) NSString *url;
@property(strong) NSString *key;
@property(strong) NSString *username;

@end
