//
//  EasyFacebookPhotoPicker.m
//  EasyFacebookPhotoPicker
//
//  Created by Chris Greenwood on 10/21/13.
//  Copyright (c) 2013 Chris Greenwood. All rights reserved.
//

#import "EasyFacebookPhotoPicker.h"
#import "EasyFacebookAlbumTableViewController.h"

@interface EasyFacebookPhotoPicker ()

@end

@implementation EasyFacebookPhotoPicker

-(id)init
{
    EasyFacebookAlbumTableViewController *tvc = [[EasyFacebookAlbumTableViewController alloc] init];
    self.albumDelegate = tvc;
    
    self = [super initWithRootViewController:tvc];
    if(self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadAlbumData];
}

-(void)loadAlbumData
{
    [[FBRequest requestForGraphPath:@"me/albums"] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        if(error)
        {
            NSLog(@"Error getting album data : %@", error.description);
        }
        else
        {
            self.albumData = [result objectForKey:@"data"];
            NSLog(@"Got album data : %@", self.albumData);
            [self.albumDelegate albumDataUpdated];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
