//
//  PonySearchViewController.m
//  PonyFaces
//
//  Created by Kain Osterholt on 11/1/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import "PonySearchViewController.h"

#import <AFNetworking/AFNetworking.h>

#import "FileManager.h"
#import "PonyfacesTableViewController.h"
#import "NSDictionary+ponyfaces_search.h"
#import "SearchResultsDataSource.h"

@interface PonySearchViewController() <UITextFieldDelegate>
{
    IBOutlet UITextField* _searchField;
    IBOutlet UIButton*    _seeResultsButton;
    IBOutlet UILabel*     _resultsLabel;
    
    NSDictionary*         _searchResults;
}

@end

@implementation PonySearchViewController

-(void)viewDidLoad
{
    _searchField.delegate = self;
    
    [self loadActivityIndicatorWithSize:100 andYMultiplier:1.3];
    
    _resultsLabel.hidden = YES;
    _seeResultsButton.hidden = YES;
    _seeResultsButton.layer.cornerRadius = 10;
    
    [self.view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler)]];
}

-(void)tapHandler
{
    [_searchField resignFirstResponder];
}

#pragma mark TextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_searchField resignFirstResponder];
    NSLog(@"Search tag: %@", textField.text);
    
    NSURL* url = [FileManager searchUrlWithTag:_searchField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        _searchResults = (NSDictionary*)responseObject;
        [self stopNetworkActivity];
        [self showResults];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Search request failed:%@", error);
        [self stopNetworkActivity];
        _searchResults = nil;
        [self showResultsFailure];
    }];
    
    _seeResultsButton.hidden = YES;
    _resultsLabel.hidden = YES;
    [self startNetworkActivity];
    [operation start];
    
    return YES;
}

#pragma mark Search Results Handlers

-(void)showResultsFailure
{
    _resultsLabel.text = @"Search failed! Please try again!";
    _resultsLabel.hidden = NO;
}

-(void)showResults
{
    if(_searchResults == nil || [_searchResults faces] == nil)
        return;
    
    NSInteger numResults = [[_searchResults faces] count];
    _resultsLabel.text = [NSString stringWithFormat:@"%ld Faces Found!", (long)numResults ];
    _resultsLabel.hidden = NO;
    
    if(numResults != 0)
        _seeResultsButton.hidden = NO;
}

-(IBAction)seeResultsPressed:(id)sender
{
    [self performSegueWithIdentifier:@"show_results_segue" sender:self];
}

#pragma mark navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PonyfacesTableViewController* tvc = (PonyfacesTableViewController*)segue.destinationViewController;
    
    SearchResultsDataSource* source = [[SearchResultsDataSource alloc] initWithResults:[_searchResults faces]];
    
    // Set a source for detail data
    tvc.facesDataSource = source;
    
    tvc.navigationItem.title = @"Search Results";
}

@end
