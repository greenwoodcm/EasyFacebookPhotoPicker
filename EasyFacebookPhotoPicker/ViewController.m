//
//  ViewController.m
//  EasyFacebookPhotoPicker
//
//  Created by Chris Greenwood on 10/21/13.
//  Copyright (c) 2013 Chris Greenwood. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"user_photos"]];
    loginView.delegate = self;
    
    loginView.frame = CGRectOffset(loginView.frame,
                                   (self.view.center.x - (loginView.frame.size.width / 2)),
                                   (self.view.center.y - (loginView.frame.size.height / 2)));
    [self.view addSubview:loginView];
    [loginView sizeToFit];
}

-(void)showPhotoPicker {
    EasyFacebookPhotoPicker *picker = [[EasyFacebookPhotoPicker alloc] init];
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

-(void)photoPicker:(EasyFacebookPhotoPicker *)picker finishedWithSelectedPhotos:(NSSet *)selected
{
    self.selectedPhotosTextView.text = [selected.allObjects componentsJoinedByString:@", "];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    NSLog(@"Login view did login : %@", user.description);
    [self showPhotoPicker];
}

@end
