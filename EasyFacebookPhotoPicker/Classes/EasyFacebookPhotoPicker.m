//
//  EasyFacebookPhotoPicker.m
//  EasyFacebookPhotoPicker
//
//  Created by Chris Greenwood on 10/21/13.
//  Copyright (c) 2013 Chris Greenwood. All rights reserved.
//

#import "EasyFacebookPhotoPicker.h"
#import "EFAlbumTableViewController.h"

@interface EasyFacebookPhotoPicker ()

@end

@implementation EasyFacebookPhotoPicker

-(id)init
{
    EFAlbumTableViewController *tvc = [[EFAlbumTableViewController alloc] init];
    self.albumDelegate = tvc;
    
    self = [super initWithRootViewController:tvc];
    if(self) {
        self.selectedPhotos = [[NSMutableSet alloc] init];
        self.maxPicturesToSelect = INT_MAX;
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

-(void)addSubmitButton:(UIViewController*)child
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(submitButtonPressed)];
    child.navigationItem.rightBarButtonItem = rightButton;
}

-(void)submitButtonPressed
{
    NSLog(@"Submit button pressed, selected : %@", self.selectedPhotos.description);
    [self.delegate photoPicker:self finishedWithSelectedPhotos:self.selectedPhotos];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
