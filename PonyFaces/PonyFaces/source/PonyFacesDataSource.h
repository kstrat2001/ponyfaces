//
//  DetailViewDataSource.h
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PonyFacesDataSource <NSObject>

@required
-(NSDictionary*)ponyFaceAtIndex:(NSUInteger)index;

@required
-(NSUInteger)numFaces;

@end
