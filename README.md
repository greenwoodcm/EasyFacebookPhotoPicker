EasyFacebookPhotoPicker
=======================

iOS modal view for selecting photos from a user's albums.  Allows the caller to specify a delegate as well as the maximum number of pictures the user can select.  The delegate receives a message containing the selected set of FBGraphObjects when the user has finished selecting their photos.

Usage
=====

    -(void)showPhotoPicker {
        EasyFacebookPhotoPicker *picker = [[EasyFacebookPhotoPicker alloc] init];
        picker.delegate = self;
        picker.maxPicturesToSelect = 3;
        
        [self presentViewController:picker animated:YES completion:^{}];
    }
    
    -(void)photoPicker:(EasyFacebookPhotoPicker *)picker finishedWithSelectedPhotos:(NSSet *)selected
    {
        self.selectedPhotosTextView.text = [selected.allObjects componentsJoinedByString:@", "];
    }

Installation
============

1. Clone the repository and related dependencies

    git clone https://github.com/greenwoodcm/EasyFacebookPhotoPicker.git
    cd EasyFacebookPhotoPicker
    git submodule update --init

2. Drag the `EasyFacebookPhotoPicker` directory into your project to import classes, XIBs, and image assets
3. Install dependencies
    1. Drag the `Vendor/SDWebImage/SDWebImage.xcodeproj` project into your project
    2. In Build Phases, under "Target Dependencies", add the SDWebImage libary
    3. In Build Phases, under "Link Binary with Libraries", add libSDWebImage.a and ImageIO.framework
    4. In Build Settings, add "-ObjC" to "Other Linker Flags"
    5. Drag the `Vendor/FacebookSDK.framework` folder into your project
4. Add Facebook app information to your plist file
    1. Add the FacebookDisplayName
    2. Add your app ID in "FacebookAppID"
    3. Add your app ID in "URL types/Item 0/URL schemes/Item 0" (be sure to leave the leading "fb" string)
4. Import the header in your own class - `#import "EasyFacebookPhotoPicker/EasyFacebookPhotoPicker.h"`
