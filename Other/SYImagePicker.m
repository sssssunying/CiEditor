//
//  SYImagePicker.m
//  PregNotice
//
//  Created by 大大大大荧 on 17/3/5.
//
//

#import "SYImagePicker.h"
#import "SVProgressHUD.h"

@implementation SYImagePicker

- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        [_imagePicker setDelegate:self];
        _imagePicker.navigationBar.tintColor = [UIColor blackColor];
        _imagePicker.navigationBar.backgroundColor = [UIColor whiteColor];
        _imagePicker.navigationBar.translucent = NO;
        _imagePicker.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    }
    return _imagePicker;
}

- (void)setShowViewController:(UIViewController *)showViewController {
    _showViewController = showViewController ;
}

#pragma - mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self chooseImageFromAlbum];
            break;
        case 1:
            [self takePhotoByCamera];
            break;
        default:
            break;
    }
}

- (void) chooseImageFromAlbum {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.showViewController presentViewController:self.imagePicker animated:YES completion:nil];
    }else{
//        [SVProgressHUD showErrorWithStatus:LANG(@"dontOpenCamera")];
    }
}

- (void) takePhotoByCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.showViewController presentViewController:self.imagePicker animated:YES completion:nil];
    }else{
//        [SVProgressHUD showErrorWithStatus:LANG(@"dontOpenCamera")];
    }
}

#pragma - mark UIimagePickerControllerDelegate 
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if (self.finishPickImage) {
        UIImage *pngImage;
        if(_imagePicker.allowsEditing){
            UIImage *fromAlbum = [info objectForKey:UIImagePickerControllerOriginalImage];
            CGRect crop = [[info valueForKey:@"UIImagePickerControllerCropRect"] CGRectValue];
            fromAlbum = [self ordinaryCrop:fromAlbum toRect:crop];
           pngImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        }else{
           pngImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        }
        if (pngImage) {
            [picker dismissViewControllerAnimated:YES completion:^(){
                self.finishPickImage(pngImage);
            }];
        }
    }
}

- (UIImage *)ordinaryCrop:(UIImage *)imageToCrop toRect:(CGRect)cropRect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], cropRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cropped;
}

@end
