//
//  PonyfacesTableViewController.m
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import "PonyfacesTableViewController.h"

#import "PonyfaceDetailViewController.h"
#import "NSDictionary+ponyfaces_search.h"
#import "NSDictionary+ponyface.h"
#import "UIImageView+AFNetworking.h"

#import "Constants.h"

@implementation PonyfacesTableViewController

@synthesize facesDataSource = _facesDataSource;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.facesDataSource == nil)
        return 0;
    
    return [self.facesDataSource numFaces];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PonyfaceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary* face = [self.facesDataSource ponyFaceAtIndex:indexPath.row];
    
    [cell.textLabel setFont:[UIFont fontWithName:@"Marker Felt" size:18]];
    [cell.textLabel setTextColor:ponyFacesPink];
    cell.textLabel.text = [face categoryName];
    
    NSURL *url = [NSURL URLWithString:[face thumbnail]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"thumbnail_downloading"];
    
    __weak UITableViewCell *weakCell = cell;
    
    [cell.imageView
     setImageWithURLRequest:request
     placeholderImage:placeholderImage
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
         
         weakCell.imageView.image = image;
         [weakCell setNeedsLayout];
         
     } failure:nil];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PonyfaceDetailViewController* dvc = (PonyfaceDetailViewController*)segue.destinationViewController;
    
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    
    if(self.facesDataSource != nil)
    {
        dvc.face = [self.facesDataSource ponyFaceAtIndex:path.row];
    }
}

@end
