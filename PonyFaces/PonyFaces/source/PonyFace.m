//
//  PonyFace.m
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import "PonyFace.h"
#import "PonyCategory.h"
#import "PonyTag.h"

@implementation PonyFace

-(NSDictionary*)toDictionary
{
    NSString* idStr = [NSString stringWithFormat:@"%@", self.id];
    NSString* enabledStr = [NSString stringWithFormat:@"%@", self.enabled];
    NSString* viewsStr = [NSString stringWithFormat:@"%@", self.views];
    
    PonyCategory* category = self.category;
    NSString* catIdStr = [NSString stringWithFormat:@"%@", category.id];
    NSDictionary* categoryDict = [NSDictionary dictionaryWithObjectsAndKeys:catIdStr, @"id",
                                  category.name, @"name", nil];
    
    NSMutableArray* tagsArr = [NSMutableArray arrayWithCapacity:[self.tags count]];
    for(PonyTag* tag in self.tags)
    {
        [tagsArr addObject:tag.name];
    }
    
    NSDictionary* faceDict = [NSDictionary dictionaryWithObjectsAndKeys:idStr, @"id",
                              enabledStr, @"enabled",
                              self.image, @"image",
                              self.link, @"link",
                              self.thumbnail, @"thumbnail",
                              viewsStr, @"views",
                              categoryDict, @"category",
                              tagsArr, @"tags", nil];
    
    return faceDict;
}

@end
