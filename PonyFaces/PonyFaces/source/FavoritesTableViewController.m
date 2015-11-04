//
//  FavoritesTableViewController.m
//  PonyFaces
//
//  Created by Kain Osterholt on 11/3/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "DataManager.h"
#import "FavsDataSource.h"

@implementation FavoritesTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Favorites!";
    
    // Reload data source by getting new data from the database
    self.facesDataSource = [[FavsDataSource alloc] init];
    
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        FavsDataSource* source = (FavsDataSource*)self.facesDataSource;
        [source deletePonyFaceAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

@end
