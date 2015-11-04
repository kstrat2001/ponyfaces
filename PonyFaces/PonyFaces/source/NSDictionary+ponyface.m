//
//  NSDictionary+ponyface.m
//  PonyFaces
//
//  Created by Kain Osterholt on 11/1/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import "NSDictionary+ponyface.h"

@implementation NSDictionary (ponyface)

- (NSNumber*)identifier
{
    NSString *cc = self[@"id"];
    NSNumber* n = @([cc intValue]);
    return n;
}

- (BOOL)enabled
{
    NSString *cc = self[@"enabled"];
    NSNumber *n = @([cc intValue]);
    return [n isEqualToNumber: [NSNumber numberWithInt:1]];
}

- (NSNumber *)views
{
    NSString *cc = self[@"views"];
    NSNumber* n = @([cc intValue]);
    return n;
}

- (NSString*)link
{
    return self[@"link"];
}

- (NSString*)image
{
    return self[@"image"];
}

- (NSString*)thumbnail
{
    return self[@"thumbnail"];
}

- (NSArray*)tags
{
    NSArray* tags = self[@"tags"];
    return tags;
}

- (NSNumber*)categoryId
{
    NSDictionary* cat = self[@"category"];
    NSString* idStr = cat[@"id"];
    NSNumber* catId = @([idStr intValue]);
    return catId;
}

- (NSString*)categoryName
{
    NSDictionary* cat = self[@"category"];
    NSString* categoryName = cat[@"name"];
    return categoryName;
}

@end