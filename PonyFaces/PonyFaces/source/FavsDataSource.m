//
//  FavsDataSource.m
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import "FavsDataSource.h"
#import "DataManager.h"
#import "FileManager.h"
#import "PonyFace.h"

@interface FavsDataSource()
{
}

@property (nonatomic, strong) NSArray* faceEntities;

@end

@implementation FavsDataSource

@synthesize faceEntities = _faceEntities;

-(id)init
{
    self = [super init];
    
    if( self != nil )
    {
        _faceEntities = [[DataManager sharedManager] getFavFaces];
    }
    
    return self;
}

#pragma mark PonyFacesDataSource methods

-(NSDictionary*)ponyFaceAtIndex:(NSUInteger)index
{
    if(_faceEntities == nil)
        return nil;
    
    PonyFace* faceEntity = [_faceEntities objectAtIndex:index];
    
    return [faceEntity toDictionary];
}

-(NSUInteger)numFaces
{
    return [_faceEntities count];
}

#pragma mark added functionality for favorites

-(void)deletePonyFaceAtIndex:(NSUInteger)index
{
    PonyFace* faceEntity = [_faceEntities objectAtIndex:index];
    NSDictionary* faceDict = [faceEntity toDictionary];

    // Delete the cached image file
    NSString* imagePath = [[FileManager sharedManager] getFullImageFilePath:faceDict];
    [[FileManager sharedManager] removeFile:imagePath];
    
    [[DataManager sharedManager] deleteFavPonyFace:faceEntity];
    
    // Do another query to update the face entities
    _faceEntities = [[DataManager sharedManager] getFavFaces];
}

@end
