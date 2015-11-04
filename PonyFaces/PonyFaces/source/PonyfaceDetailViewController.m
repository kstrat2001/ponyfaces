//
//  PonyfaceDetailViewController.m
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import "PonyfaceDetailViewController.h"

#import <AFNetworking/AFNetworking.h>

#import "NSDictionary+ponyface.h"
#import "UIImageView+AFNetworking.h"
#import "DataManager.h"
#import "FileManager.h"

@interface PonyfaceDetailViewController()
{
    IBOutlet UILabel*       _categoryLabel;
    IBOutlet UITextView*    _tagsView;
    IBOutlet UIImageView*   _faceImageView;
    
    UIImageView*            _favoriteIndicatorView;
}

@end

@implementation PonyfaceDetailViewController

@synthesize face = _face;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if(_face != nil)
        [self loadViewComponents];
    
    [self loadActivityIndicatorWithSize:100 andYMultiplier:1.0];
    
    [_faceImageView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faceTapped)]];
    _faceImageView.clipsToBounds = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString* imagePath = [[FileManager sharedManager] getFullImageFilePath:_face];
    
    // If the image exists it's already a favorite
    if([[FileManager sharedManager] fileExists:imagePath])
    {
        NSData* data = [NSData dataWithContentsOfFile:imagePath];
        UIImage* img = [UIImage imageWithData:data scale:2];
        _faceImageView.image = img;
        
        // Already a favorite so don't allow the user to save
        _faceImageView.userInteractionEnabled = NO;
        
        [self loadFavoriteIndicator];
    }
    else
    {
        // By downloading the image we know that it is not saved as a favorite
        // So the success block will enable user interaction to allow the user to save
        [self downloadImage];
        
        [self hideFavoriteIndicator];
    }
}

-(void)downloadImage
{
    // Finally download the image in the background
    NSURL *url = [NSURL URLWithString:[_face image]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __weak UIImageView* _weakView = _faceImageView;
    __unsafe_unretained typeof(self) weakSelf = self;
    [self startNetworkActivity];
    
    [_faceImageView
     setImageWithURLRequest:request
     placeholderImage:nil
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
         
         _weakView.image = image;
         [_weakView setNeedsLayout];
         _weakView.userInteractionEnabled = YES;
         [weakSelf stopNetworkActivity];
         
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
         [weakSelf stopNetworkActivity];
     }];
}

-(void)loadFavoriteIndicator
{
    UIImage* starImage = [UIImage imageNamed:@"star"];
    _favoriteIndicatorView = [[UIImageView alloc] initWithImage:starImage];
    _favoriteIndicatorView.alpha = 0.0f;
    
    [self.view addSubview:_favoriteIndicatorView];
    [_favoriteIndicatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_favoriteIndicatorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:starImage.size.width]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_favoriteIndicatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:starImage.size.height]];;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_favoriteIndicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_faceImageView attribute:NSLayoutAttributeLeft multiplier:1 constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_favoriteIndicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_faceImageView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [UIView animateWithDuration:0.5f animations:^(void){
        _favoriteIndicatorView.alpha = 1.0f;
    }];
}

-(void)hideFavoriteIndicator
{
    if(_favoriteIndicatorView != nil)
    {
        [UIView animateWithDuration:0.5f animations:^(void){
            _favoriteIndicatorView.alpha = 0.0f;
        }];
    }
}

-(void)loadViewComponents
{
    // Set the category at the top of the view
    _categoryLabel.text = [_face categoryName];
    
    // Set the tags text view at the bottom
    NSArray* tags = [_face tags];
    NSString* tagsString = @"tags: ";
    NSString* joinedTags = [tags componentsJoinedByString:@", "];
    tagsString = [tagsString stringByAppendingString:joinedTags];
    [_tagsView setText:tagsString];
}

-(void)faceTapped
{
    [self promptSaveToFavs];
}

-(void)promptSaveToFavs
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Save Favorite?"
                                  message:[NSString stringWithFormat:@"Would you like to save this face to favorites?"]
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Save"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [[DataManager sharedManager] savePonyFaceToFavs:_face];
                                    [self cachePonyfaceImage];
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                    [self loadFavoriteIndicator];
                                    
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                   
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)cachePonyfaceImage
{
    NSString* imagePath = [[FileManager sharedManager] getFullImageFilePath:_face];
    NSString* directory = [imagePath stringByDeletingLastPathComponent];
    
    [[FileManager sharedManager] createDirectory:directory];
    [UIImagePNGRepresentation(_faceImageView.image) writeToFile:imagePath atomically:YES];
}

@end
