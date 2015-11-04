//
//  FileManager.m
//  PonyFaces
//
//  Created by Kain Osterholt on 11/1/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileManager.h"

#import "Constants.h"
#import "NSDictionary+ponyface.h"

@implementation FileManager

@synthesize docRoot = _docRoot;

+ (id)sharedManager {
    static FileManager *sharedFileManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFileManager = [[self alloc] init];
    });
    
    return sharedFileManager;
}

+(NSURL*)searchUrlWithTag:(NSString*)tag
{
    NSString* url = PONYFACES_HOST;
    url = [url stringByAppendingPathComponent:PONY_FACES_API];
    
    NSString* tagString = [NSString stringWithFormat:@"tag:%@", tag];
    
    url = [url stringByAppendingPathComponent:tagString];
    
    return [NSURL URLWithString:url];
}

- (NSString*)getFullImageFilePath:(NSDictionary*)ponyface
{
    if(_docRoot == nil)
        return nil;
    
    NSString* path = [_docRoot stringByAppendingPathComponent:ponyface[@"id"]];
    path = [path stringByAppendingPathComponent:@"full"];
    
    return path;
}

-(void)initDocRoot
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    _docRoot = [documentsDirectory stringByAppendingPathComponent:DOC_ROOT];
    
    NSURL* URL= [NSURL fileURLWithPath: _docRoot];
    
    if( ![self fileExists:_docRoot] )
    {
        [self createDirectory:_docRoot];
        
        NSError *error = nil;
        
        BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                        
                                      forKey: NSURLIsExcludedFromBackupKey error: &error];
        
        if(!success)
        {
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
    }
}

#pragma mark - File system helpers

-(unsigned long long)getFileSize:(NSString*)fileName
{
    unsigned long long size = 0;
    
    if( [self fileExists:fileName])
        size = [[NSFileManager defaultManager] attributesOfItemAtPath:fileName error:nil].fileSize;
    
    return size;
}

-(BOOL)fileExists:(NSString*)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

-(NSArray*)listFilesAtPath:(NSString *)path
{
    //-----> LIST ALL FILES <-----//
    NSLog(@"LISTING ALL FILES FOUND in:%@", path);
    
    int count;
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    for (count = 0; count < (int)[directoryContent count]; count++)
    {
        NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
    }
    
    return directoryContent;
}

- (void)removeFile:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:path error:&error];
    if (success) {
        NSLog(@"Removed file: %@", path);
    }
    else
    {
        NSLog(@"Could not delete file named '%@' due to error:%@",path, [error localizedDescription]);
    }
}

-(void)removeFilesAtPath:(NSString*)path
{
    NSLog(@"REMOVING ALL FILES FOUND in:%@", path);
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    for (NSString* file in directoryContent)
    {
        [self removeFile:[path stringByAppendingPathComponent:file]];
    }
}

-(void)createDirectory:(NSString *)directory
{
    NSError *error;
    
    if (![[NSFileManager defaultManager] createDirectoryAtPath:directory
                                   withIntermediateDirectories:YES
                                                    attributes:nil
                                                         error:&error])
    {
        NSLog(@"Create directory error: %@", error);
    }
}

@end
