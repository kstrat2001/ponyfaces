//
//  PonyfaceDetailViewController.h
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetworkActivityViewController.h"

@interface PonyfaceDetailViewController : NetworkActivityViewController
{
    
}

@property (nonatomic, strong) NSDictionary* face;

@end
