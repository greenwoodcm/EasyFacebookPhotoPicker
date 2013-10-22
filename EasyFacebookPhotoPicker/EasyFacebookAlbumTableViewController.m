//
//  EasyFacebookAlbumTableViewController.m
//  EasyFacebookPhotoPicker
//
//  Created by Chris Greenwood on 10/22/13.
//  Copyright (c) 2013 Chris Greenwood. All rights reserved.
//

#import "EasyFacebookAlbumTableViewController.h"
#import "EasyFacebookAlbumTableViewCell.h"
#import "EasyFacebookAlbumViewController.h"

@interface EasyFacebookAlbumTableViewController ()

@end

@implementation EasyFacebookAlbumTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray*)albumData
{
    return ((EasyFacebookPhotoPicker*)self.navigationController).albumData;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self albumData].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"EasyFacebookAlbumCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if(!cell)
    {
        NSArray *tlobjs = [[NSBundle mainBundle] loadNibNamed:@"EasyFacebookAlbumTableViewCell" owner:nil options:nil];
        cell = (EasyFacebookAlbumTableViewCell*)[tlobjs objectAtIndex:0];
    }
    
    FBGraphObject *album = [[self albumData] objectAtIndex:indexPath.row];
    cell.textLabel.text = [album objectForKey:@"name"];
    
    NSString *coverPhotoId = [album objectForKey:@"cover_photo"];
    NSURL *coverPhotoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=album", coverPhotoId]];
    
    UIImage *coverPhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:coverPhotoUrl]];
    cell.imageView.image = coverPhoto;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBGraphObject *album = [[self albumData] objectAtIndex:indexPath.row];
    
    EasyFacebookAlbumViewController *avc = [[EasyFacebookAlbumViewController alloc] init];
    avc.album = album;
    
    [self.navigationController pushViewController:avc animated:YES];
}

-(void)albumDataUpdated
{
    [self.tableView reloadData];
}

@end