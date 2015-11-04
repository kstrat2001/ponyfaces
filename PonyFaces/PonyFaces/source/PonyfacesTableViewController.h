//
//  PonyfacesTableViewController.h
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PonyFacesDataSource.h"

@interface PonyfacesTableViewController : UITableViewController
{
    
}

@property (nonatomic, strong) id<PonyFacesDataSource> facesDataSource;

@end
