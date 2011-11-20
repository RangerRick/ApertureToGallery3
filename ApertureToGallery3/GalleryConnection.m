//
//  GalleryConnection.m
//  Tutorial
//
//  Created by Scott Selberg on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GalleryConnection.h"


@implementation GalleryConnection
@synthesize results;
@synthesize bVerbose;
@synthesize delegate;

- (GalleryConnection *)initWithRequest:(NSMutableURLRequest *)myRequest andDelegate:(id)myDelegate
{
    self = [super init];

    _request    = myRequest;
    _connection = [NSURLConnection alloc];
    _mutableData       = [[NSMutableData alloc] init];
    _isRunning    = false;
    _encoding   = NSUTF8StringEncoding;

    self.delegate   = myDelegate;
    self.results    = [[NSMutableDictionary alloc] initWithCapacity:10];
    self.bVerbose = false;
    
    return self;
}

- (void)dealloc
{
    
    _request = nil;
    _connection = nil;
    _mutableData = nil;

    if( _response ){  _response = nil;}
    if( _error    ){  _error    = nil;}
    
}

#pragma mark NSURLConnection
-(void) start {
    if( self.bVerbose ){ NSLog( @"Starting Gallery Connection..." ); }
    _isRunning = true;
    [_connection initWithRequest:_request delegate:self startImmediately:true];
}

-(void) cancel{
    if( _isRunning )
    {
        if( self.bVerbose ){NSLog( @"Canceling Gallery Connection..." );}
       [_connection cancel];
    }
}

#pragma mark NSURLConnection Delegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse
{
    if( self.bVerbose ){NSLog( @"Gallery Connection Did Received A Response" );}
    _response = aResponse;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)someData
{
    if( self.bVerbose ){NSLog( @"Gallery Connection Received Some Data" );}
    [_mutableData appendData:someData];    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)anError
{
    if( self.bVerbose ){NSLog( @"Gallery Connection Failed with Error" );}
    _error = anError;
    
    [self.results setValue:@"ERROR"   forKey:@"RESPONSE_TYPE"];
    [self.results setValue:_error forKey:@"ERROR"];    
    [self.results setValue:[NSNumber numberWithBool:YES] forKey:@"HAS_ERROR"];

    _isRunning = false;    
    [self.delegate got:self.results];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if( self.bVerbose ){NSLog( @"Gallery Connection Completed Successfully" );}
    
    self.results = nil;
    self.results = [self parseRequest:_mutableData];

    _isRunning = false;    
    [self.delegate got:self.results];
}

-(void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    [self.delegate updateTotalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite];
}

-(NSMutableDictionary*)parseRequest:(NSData *)myData
{
    // Get UTF8 String as a NSString from NSData response
    NSString *galleryResponseString = [[NSString alloc] initWithData:myData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *newResults = [NSMutableDictionary new];
    
    // Testing is received string is a json object. i.e. bounded by {}
    if( [galleryResponseString length] >= 1 )
    {
        //      char startChar = [galleryResponseString characterAtIndex:0];
        //      char endChar   = [galleryResponseString characterAtIndex:( [galleryResponseString length]-1)];
        //      if( startChar == '{' && endChar == '}' ) -> just saving a few bits of memory.  
        if( [galleryResponseString characterAtIndex:0] == '{' && [galleryResponseString characterAtIndex:( [galleryResponseString length]-1)] == '}' )
        {
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            
            [newResults addEntriesFromDictionary:[parser objectWithString:galleryResponseString error:nil]];             
            [newResults setValue:@"JSON" forKey:@"RESPONSE_TYPE"];
            
            
            parser = nil;
        }
        else if( [galleryResponseString characterAtIndex:0] == '[' && [galleryResponseString characterAtIndex:( [galleryResponseString length]-1)] == ']' )
        {
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            
            [newResults setValue:[parser objectWithString:galleryResponseString error:nil] forKey:@"RESULTS"];             
            [newResults setValue:@"JSON" forKey:@"RESPONSE_TYPE"];
            
            parser = nil;
        }
        else if( [galleryResponseString characterAtIndex:0] == '"' && [galleryResponseString characterAtIndex:( [galleryResponseString length]-1)] == '"' )
        {
            [newResults setValue:[galleryResponseString stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]] forKey:@"GALLERY_RESPONSE"];
            [newResults setValue:@"TEXT" forKey:@"RESPONSE_TYPE"];
            
        }   
        else
        {
            [newResults setValue:galleryResponseString forKey:@"GALLERY_RESPONSE"];
            [newResults setValue:@"TEXT" forKey:@"RESPONSE_TYPE"];
        }
    }
    else
    {
        [newResults setValue:galleryResponseString forKey:@"GALLERY_RESPONSE"];
        [newResults setValue:@"TEXT" forKey:@"RESPONSE_TYPE"];
        
    }
    
    [newResults setValue:_error forKey:@"ERROR"];  // connection errors rather than syntax errors
    if( [newResults objectForKey:@"errors"] != nil ){
        [newResults setValue:[NSNumber numberWithBool:YES] forKey:@"HAS_ERROR"];
    } else {
        [newResults setValue:[NSNumber numberWithBool:NO] forKey:@"HAS_ERROR"];

    }
     

    
    
    
    return newResults;
}


@end
