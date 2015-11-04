//
//  NetworkActivityViewController.h
//  PonyFaces
//
//  Created by Kain Osterholt on 11/2/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkActivityViewController : UIViewController
{
    
}

-(void)loadActivityIndicatorWithSize:(float)size andYMultiplier:(float)yMultiplier;
-(void)startNetworkActivity;
-(void)stopNetworkActivity;

@end
