//
//  NSDictionary+ponyface.h
//  PonyFaces
//
//  Created by Kain Osterholt on 11/1/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ponyface)

- (NSNumber*)identifier;
- (BOOL)enabled;
- (NSNumber*)views;
- (NSString*)link;
- (NSString*)image;
- (NSString*)thumbnail;
- (NSArray*)tags;

- (NSNumber*)categoryId;
- (NSString*)categoryName;

@end