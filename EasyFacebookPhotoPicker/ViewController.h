//
//  ViewController.h
//  EasyFacebookPhotoPicker
//
//  Created by Chris Greenwood on 10/21/13.
//  Copyright (c) 2013 Chris Greenwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "EasyFacebookPhotoPicker.h"

@interface ViewController : UIViewController <FBLoginViewDelegate, EasyFacebookPhotoPickerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *selectedPhotosTextView;

@end
