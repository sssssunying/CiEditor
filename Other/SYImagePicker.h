//
//  SYImagePicker.h
//  PregNotice
//
//  Created by 大大大大荧 on 17/3/5.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 创建方式：
    alloc init
    setShowViewController
    setFinishPickImage(推出imagePicker后做的事)
 */
@interface SYImagePicker : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

/**
    照片选择器
 */
@property (nonatomic,strong) UIImagePickerController *imagePicker ;

/**
    展示主控
 */
@property (nonatomic,strong) UIViewController *showViewController ;

/**
底部操作表选择
    － 相册
    － 拍照
    － 取消
 */
//- (void) showImagePickerWithActionSheet ;

/**
 确认选择完图片后调用
 */
@property (nonatomic,strong) void(^finishPickImage)(UIImage *chooseImage);

@end
