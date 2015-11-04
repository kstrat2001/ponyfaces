//
//  DataManager.h
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PonyFace;

@interface DataManager : NSObject
{
    
}

+(id)sharedManager;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)savePonyFaceToFavs:(NSDictionary*)face;
- (NSArray*)getFavFaces;

-(void)deleteFavPonyFace:(PonyFace*)ponyfaceEntity;

@end
