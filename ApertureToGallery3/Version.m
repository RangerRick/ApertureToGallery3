//
//  Version.m
//  ApertureToGallery3
//
//  Created by Scott Selberg on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Version.h"

@implementation Version
@synthesize iPhotoToGalleryVersion;
@synthesize RestfulGalleryVersion;
@synthesize AppleToGalleryVersion;
@synthesize ApertureToGalleryVersion;

- (id)init
{
    self = [super init];
    if (self) {
        self.iPhotoToGalleryVersion   = [NSNumber numberWithDouble:1.1];
        self.RestfulGalleryVersion    = [NSNumber numberWithDouble:1.0];
        self.AppleToGalleryVersion    = [NSNumber numberWithDouble:1.1];
        self.ApertureToGalleryVersion = [NSNumber numberWithDouble:1.1];
    }
    
    return self;
}


@end
