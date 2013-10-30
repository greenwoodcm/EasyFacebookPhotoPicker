//
//  EasyFacebookPhotoPicker.h
//  EasyFacebookPhotoPicker
//
//  Created by Chris Greenwood on 10/21/13.
//  Copyright (c) 2013 Chris Greenwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@class EasyFacebookPhotoPicker;

/*
    Delegate used to notify child view that the albums data
    has been loaded from the server
 */
@protocol EasyFacebookPhotoPickerAlbumsDelegate <NSObject>
-(void)albumDataUpdated;
@end

/*
    Delegate used to notify the client that this picker
    has finished selecting photos.
 */
@protocol EasyFacebookPhotoPickerDelegate <UINavigationControllerDelegate>
-(void)photoPicker:(EasyFacebookPhotoPicker*)picker finishedWithSelectedPhotos:(NSSet*)selected;
@end

@interface EasyFacebookPhotoPicker : UINavigationController

@property (weak, nonatomic) id<EasyFacebookPhotoPickerDelegate> delegate;
@property (weak, nonatomic) id<EasyFacebookPhotoPickerAlbumsDelegate> albumDelegate;
@property (strong, nonatomic) NSArray *albumData;

@property (strong, nonatomic) NSMutableSet *selectedPhotos;

@property (nonatomic) NSInteger maxPicturesToSelect;

-(void)addSubmitButton:(UIViewController*)child;

@end
