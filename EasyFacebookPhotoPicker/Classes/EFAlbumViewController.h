//
//  EasyFacebookAlbumViewController.h
//  EasyFacebookPhotoPicker
//
//  Created by Chris Greenwood on 10/22/13.
//  Copyright (c) 2013 Chris Greenwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface EFAlbumViewController : UICollectionViewController

@property (strong, nonatomic) FBGraphObject *album;

@end
