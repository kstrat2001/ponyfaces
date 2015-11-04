//
//  FavsDataSource.h
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PonyFacesDataSource.h"

@interface FavsDataSource : NSObject <PonyFacesDataSource>
{
    
}

// PonyFacesDataSource methods
-(NSDictionary*)ponyFaceAtIndex:(NSUInteger)index;
-(NSUInteger)numFaces;

// Needed for favs functionality
-(void)deletePonyFaceAtIndex:(NSUInteger)index;

@end
