//
//  PonyFace+CoreDataProperties.h
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PonyFace.h"

NS_ASSUME_NONNULL_BEGIN

@interface PonyFace (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *enabled;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSString *thumbnail;
@property (nullable, nonatomic, retain) NSNumber *views;
@property (nullable, nonatomic, retain) PonyCategory *category;
@property (nullable, nonatomic, retain) NSSet<PonyTag *> *tags;

@end

@interface PonyFace (CoreDataGeneratedAccessors)

- (void)addTagsObject:(PonyTag *)value;
- (void)removeTagsObject:(PonyTag *)value;
- (void)addTags:(NSSet<PonyTag *> *)values;
- (void)removeTags:(NSSet<PonyTag *> *)values;

@end

NS_ASSUME_NONNULL_END
