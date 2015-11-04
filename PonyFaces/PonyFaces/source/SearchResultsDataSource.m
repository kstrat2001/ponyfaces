//
//  SearchResultsDataSource.m
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import "SearchResultsDataSource.h"

@interface SearchResultsDataSource()
{
    NSArray* _searchResults;
}

@property (nonatomic, strong) NSArray* searchResults;

@end

@implementation SearchResultsDataSource

@synthesize searchResults = _searchResults;

-(id)initWithResults:(NSArray*)searchResults
{
    self = [super init];
    
    if( self != nil )
    {
        self.searchResults = searchResults;
    }
    
    return self;
}

-(NSDictionary*)ponyFaceAtIndex:(NSUInteger)index
{
    return [self.searchResults objectAtIndex:index];
}

-(NSUInteger)numFaces
{
    return [self.searchResults count];
}

@end
