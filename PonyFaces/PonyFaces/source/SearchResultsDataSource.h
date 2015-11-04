//
//  SearchResultsDataSource.h
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PonyFacesDataSource.h"

@interface SearchResultsDataSource : NSObject <PonyFacesDataSource>
{
    
}

-(id)initWithResults:(NSArray*)searchResults;

-(NSDictionary*)ponyFaceAtIndex:(NSUInteger)index;
-(NSUInteger)numFaces;

@end
