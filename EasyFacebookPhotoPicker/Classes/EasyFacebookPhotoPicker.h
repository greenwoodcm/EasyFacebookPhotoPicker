//
//  EasyFacebookPhotoPicker.h
//  EasyFacebookPhotoPicker
//
//  Created by Chris Greenwood on 10/21/13.
//  Copyright (c) 2013 Chris Greenwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@protocol EasyFacebookPhotoPickerAlbumsDelegate <NSObject>

-(void)albumDataUpdated;

@end

@interface EasyFacebookPhotoPicker : UINavigationController

@property (weak, nonatomic) id<EasyFacebookPhotoPickerAlbumsDelegate> albumDelegate;
@property (strong, nonatomic) NSArray *albumData;

@end
