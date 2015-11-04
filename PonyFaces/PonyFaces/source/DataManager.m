//
//  DataManager.m
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import "DataManager.h"
#import "PonyFace.h"
#import "PonyCategory.h"
#import "PonyTag.h"
#import "NSDictionary+ponyface.h"

@implementation DataManager

+ (id)sharedManager {
    static DataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.kainosterholt.PonyFaces" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PonyFaces" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PonyFaces.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark Ponyface specific helper methods

- (void)savePonyFaceToFavs:(NSDictionary*)face
{
    NSManagedObjectContext *context = [self managedObjectContext];
    PonyFace *ponyFaceEntity = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"PonyFace"
                                      inManagedObjectContext:context];

    ponyFaceEntity.enabled = [face enabled] ? @(1) : @(0);
    ponyFaceEntity.id = [face identifier];
    ponyFaceEntity.image = [face image];
    ponyFaceEntity.link = [face link];
    ponyFaceEntity.thumbnail = [face thumbnail];
    ponyFaceEntity.views = [face views];
    
    PonyCategory *category = [NSEntityDescription
                                            insertNewObjectForEntityForName:@"PonyCategory"
                                            inManagedObjectContext:context];
    category.id = [face categoryId];
    category.name = [face categoryName];
    
    ponyFaceEntity.category = category;
    
    NSArray* tags = [face tags];
    for(NSString* tagName in tags)
    {
        PonyTag *tag = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"PonyTag"
                                  inManagedObjectContext:context];
        
        tag.name = tagName;
        [ponyFaceEntity addTagsObject:tag];
    }
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Error saving pony face: %@", [error localizedDescription]);
    }
}

- (NSArray*)getFavFaces
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PonyFace"
                                              inManagedObjectContext:context];
    
    NSError *error;
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

-(void)deleteFavPonyFace:(PonyFace*)ponyfaceEntity
{
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:ponyfaceEntity];
    
    NSError *error;
    if (![context save:&error]) {
         NSLog(@"Error deleting pony face: %@", [error localizedDescription]);
    }
}

@end
