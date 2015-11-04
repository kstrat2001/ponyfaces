//
//  FileManager.h
//  PonyFaces
//
//  Created by Kain Osterholt on 11/1/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject
{
    
}

@property (nonatomic, strong) NSString* docRoot;

+ (id)sharedManager;

- (void)initDocRoot;

// Helper to create tag search URL
+ (NSURL*)searchUrlWithTag:(NSString*)tag;

// Helper to create a file path from ponyface
- (NSString*)getFullImageFilePath:(NSDictionary*)ponyface;

// File management
- (BOOL)fileExists:(NSString*)path;
- (void)createDirectory:(NSString *)directory;
- (void)removeFilesAtPath:(NSString*)path;
- (void)removeFile:(NSString *)path;

@end
