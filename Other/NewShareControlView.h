//
//  NewShareControlView.h
//  PregNotice
//
//  Created by xwl on 15/10/8.
//
//

#import <UIKit/UIKit.h>
//#import "BBSCellData.h"
//#import <MessageUI/MFMessageComposeViewController.h>
//#import "WBEngine.h"
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//#import "User.h"
//#import "GetDataFromNetWork.h"
//#import "NetWorkManager.h" // @NetWorkManagerDelegate
//#import "WXApi.h"

//@class DetailTopicViewModel;

@protocol ShareControlViewDelegate<NSObject>

@optional
-(void)shareCtrlViewDelCallback;

@end

@interface NewShareControlView : UIViewController<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
//    MFMessageComposeViewControllerDelegate,
//    WBEngineDelegate,
//    WXApiDelegate,
//    TencentLoginDelegate,
//    TencentSessionDelegate,
//    QQApiInterfaceDelegate,
//    NetWorkManagerDelegate,  // @NetWorkManager.h
    UIAlertViewDelegate,      // @confirm Delete Topic
    UIGestureRecognizerDelegate//, // 点击事件 截取后的处理
//    GetDataFromNetWorkDelegate
>

@property(nonatomic,weak)id<ShareControlViewDelegate> shareControlViewDelegate;

@property (nonatomic,assign) BOOL isFromPush;
@property (nonatomic,strong) UIViewController *pushVieController;

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *container;
@property(nonatomic,strong)UIButton *cancelBtn;

@property(nonatomic,strong)NSArray *shareBtnImgNameArr;
@property(nonatomic,strong)NSArray *shareBtnTitleArr;
@property(nonatomic,strong)UICollectionView *shareBtnCollView;

@property(nonatomic,strong)NSMutableArray *actionBtnImgNameArr;
@property(nonatomic,strong)NSMutableArray *actionBtnTitleArr;
@property(nonatomic,strong)UICollectionView *actionBtnCollView;

@property(nonatomic,strong)UIAlertView *delTopicAlertView;

//@property(nonatomic,strong)GetDataFromNetWork *netWork;
//
//// 微博授权 @weibo
//@property(nonatomic,strong) WBEngine *weiBoEngine;
//
//// 腾讯授权 @qzone @qq
//@property(nonatomic,strong) TencentOAuth *tencentEngine;
//@property(nonatomic,strong) NSArray *permissions;

// 分享参数
@property(nonatomic,strong)NSString *title; // 标题
@property(nonatomic,strong)NSString *content; // 描述
@property(nonatomic,strong)UIImage *image; // 图片
@property(nonatomic,strong)NSString *image_url; // 图片地址
@property(nonatomic,strong)NSString *url; // 链接地址，不设置则默认孕期提醒下载地址

// 初始化操作
-(void)loadData:(NSString *)title
        content:(NSString *)content
          image:(UIImage *)image
      image_url:(NSString *)image_url
            url:(NSString *)url;

// 初始化操作，根据当前用户
//@property(nonatomic,strong)BBSCellData *bbsData;
//@property(nonatomic,strong)User *currentUser;
//-(void)loadBBSData:(BBSCellData *)bbsData
//       currentUser:(User *)currentUser;
//
//-(void)loadShareImgUrl:(NSString*)img_url;
//
//-(void)loadBBSDetailData:(DetailTopicViewModel *)viewModel;

-(void)show;
-(void)hide;
-(void)weixin;
-(void)weixingroup;
-(void)qq;
-(void)qzone;
-(void)weChatMini;

- (void) showIn: (UIViewController *) viewController;
- (void)showInView: (UIView *) view;

@property (nonatomic,strong) void (^postShareSuccessToSever)();
@property (nonatomic,strong) void (^updateMark)(int isMark);

@end
