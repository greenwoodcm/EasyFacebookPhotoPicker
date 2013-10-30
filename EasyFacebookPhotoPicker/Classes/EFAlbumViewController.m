//
//  EasyFacebookAlbumViewController.m
//  EasyFacebookPhotoPicker
//
//  Created by Chris Greenwood on 10/22/13.
//  Copyright (c) 2013 Chris Greenwood. All rights reserved.
//

#import "EFAlbumViewController.h"
#import "EasyFacebookPhotoPicker.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface EFAlbumViewController ()

@property (strong, nonatomic) NSArray *photoData;
@end

@implementation EFAlbumViewController

-(id)init
{
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    if(self)
    {
        
    }
    
    return self;
}

-(NSMutableSet*)selectedPhotos
{
    return [(EasyFacebookPhotoPicker*)self.navigationController selectedPhotos];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [(EasyFacebookPhotoPicker*)self.navigationController addSubmitButton:self];
    
    [self getData];
    
    UINib *cellNib = [UINib nibWithNibName:@"EFPhotoViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"PhotoCell"];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionViewLayout;
    [flowLayout setItemSize:CGSizeMake(100, 100)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData
{
    NSString *albumId = [self.album valueForKey:@"id"];
    NSString *endpoint = [NSString stringWithFormat:@"%@/photos", albumId];
    
    [[FBRequest requestForGraphPath:endpoint] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        if(error)
        {
            NSLog(@"Error getting album [%@] photos : %@", albumId, error.description);
        }
        else
        {
            self.photoData = [result objectForKey:@"data"];
            NSLog(@"Got album [%@] photos : %@", albumId, self.photoData);
            [self.collectionView reloadData];
        }
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PhotoCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    
    FBGraphObject *pic = [self.photoData objectAtIndex:indexPath.row];
    NSURL *picUrl = [NSURL URLWithString:[pic objectForKey:@"picture"]];
    
    [imageView setImageWithURL:picUrl];
    
    NSString *picId = [pic objectForKey:@"id"];
    UIImageView *overlay = (UIImageView*)[cell viewWithTag:200];
    if([[self selectedPhotos] containsObject:picId])
    {
        overlay.image = [UIImage imageNamed:@"photo-selected-filter.png"];
    }
    else
    {
        overlay.image = nil;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FBGraphObject *pic = [self.photoData objectAtIndex:indexPath.row];
    NSString *picId = [pic objectForKey:@"id"];
    
    if([[self selectedPhotos] containsObject:picId])
        [[self selectedPhotos] removeObject:picId];
    else
        [[self selectedPhotos] addObject:picId];
    
    [self.collectionView reloadData];
}

@end
