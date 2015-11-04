//
//  PonyFace.h
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PonyCategory, PonyTag;

NS_ASSUME_NONNULL_BEGIN

@interface PonyFace : NSManagedObject
{
    
}

-(NSDictionary*)toDictionary;

@end

NS_ASSUME_NONNULL_END

#import "PonyFace+CoreDataProperties.h"
