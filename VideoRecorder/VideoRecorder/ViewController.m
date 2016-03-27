//
//  ViewController.m
//  VideoRecorder
//
//  Created by badman on 16/3/27.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    UIButton *recordButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2-50, screenHeight - 100, 100, 30)];
    [recordButton setTitle:@"录视频" forState:UIControlStateNormal];
    [recordButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [recordButton addTarget:self action:@selector(recordVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)recordVideo:(UIButton *)sender
{
    // Test if there is a camera available
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.camera = [[UIImagePickerController alloc] init];
        self.camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.camera.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
        self.camera.showsCameraControls = YES;
        self.camera.delegate = self;
        [self presentViewController:self.camera animated:YES completion:nil];
    } else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No camera available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    // Handle a movie capture
    if (CFStringCompare((CFStringRef)mediaType, kUTTypeMovie,  0))
    {
        NSString *moviePath = (NSString *)[[info objectForKey:UIImagePickerControllerMediaURL] path];
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath))
        {
            UISaveVideoAtPathToSavedPhotosAlbum(moviePath, self, @selector(video:didFinishSavingWithError:), nil);
        }
    }
    [self.camera dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error
{
    if (error)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Video Saving Failed"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles: nil];
        [alert show];
    } else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved"
                                                        message:@"Saved to your Photo Album"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
}
@end
