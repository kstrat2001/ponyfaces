//
//  NetworkActivityViewController.m
//  PonyFaces
//
//  Created by Kain Osterholt on 11/2/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import "NetworkActivityViewController.h"

@interface NetworkActivityViewController()
{
    UIActivityIndicatorView*   _indicator;
}

@end

@implementation NetworkActivityViewController

-(void)loadActivityIndicatorWithSize:(float)size andYMultiplier:(float)yMultiplier
{
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [self.view addSubview:_indicator];
    
    [_indicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indicator attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indicator attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size]];;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:yMultiplier constant:0]];
    
    _indicator.hidden = YES;
}


-(void)startNetworkActivity
{
    _indicator.hidden = NO;
    [_indicator startAnimating];
}

-(void)stopNetworkActivity
{
    _indicator.hidden = YES;
    [_indicator stopAnimating];
}

@end
