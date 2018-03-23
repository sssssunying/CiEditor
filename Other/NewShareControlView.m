//
//  NewShareControlView.m
//  PregNotice
//
//  Created by xwl on 15/10/8.
//
//

#import "NewShareControlView.h"
#import "ConfigConst.h" // 自定义宏
#import "Masonry.h" // 布局
#import "ShareBtnData.h"
#import "ShareBtnCell.h"
#import "SVProgressHUD.h" // 提示发送状态
//#import "ImageGenerationView.h" // @weixin @weixingroup
//#import "ImageClass.h" // @weixin @weixingroup
//#import "JSON.h"
//#import "WXApi.h"
//#import "MultiLanguage.h"
//#import "DetailTopicModel.h"
//#import "NSString+CategoryFunction.h"
//#import "DetailTopicViewModel.h"
//#import "CiUser.h"

#define BG_VIEW_TAG 100

#define ShareCtrlViewBorderColor [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1]

@implementation NewShareControlView

- (instancetype)init {
    if (self = [super init]) {
        self.isFromPush = NO;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNetWork];
    
    [self initArr];
    
    [self initView];
}

-(void)initNetWork
{
//    self.netWork = [[GetDataFromNetWork alloc] init];
//    [self.netWork setNetDelegate:self];
}

// 初始化分享操作栏
-(void)initView
{
    WS(ws);
    
    // 整屏背景色
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.tag = BG_VIEW_TAG;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewOnClick:)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    // 分享操作框
    self.container = [[UIView alloc] initWithFrame:CGRectZero];
    self.container.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:0.96];
    [self.view addSubview:self.container];
    
    // 标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"shareTo";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = RGBColor(153, 153, 153);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = FONT(14);
    [self.container addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.container.mas_top);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.height.equalTo(@35);
    }];
    
    // 初始化取消按钮
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle: @"cancel" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancelBtn.layer.borderColor = ShareCtrlViewBorderColor.CGColor;
    self.cancelBtn.layer.borderWidth = 1;
    self.cancelBtn.backgroundColor = [UIColor whiteColor];
    [self.cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:self.cancelBtn];
    [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.bottom.equalTo(ws.container.mas_bottom);
    }];
    
    // 分享
    UICollectionViewFlowLayout* shareLayout = [[UICollectionViewFlowLayout alloc] init];
    [shareLayout setSectionInset:UIEdgeInsetsMake(0, 4, 0, 0)];
    [shareLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [shareLayout setMinimumInteritemSpacing:0]; // cell横向间距
    [shareLayout setMinimumLineSpacing:0]; // 只是单行横向也要设置
    [shareLayout setItemSize:CGSizeMake(ScreenWith/4, ScreenWith/4)];
    self.shareBtnCollView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:shareLayout];
    self.shareBtnCollView.backgroundColor = [UIColor clearColor];
    self.shareBtnCollView.dataSource = self;
    self.shareBtnCollView.delegate = self;
    [self.shareBtnCollView registerClass:[ShareBtnCell class] forCellWithReuseIdentifier:ShareBtnCellIdentifier];
    [self.container addSubview:self.shareBtnCollView];
    [self.shareBtnCollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.top.mas_equalTo(ws.titleLabel.mas_bottom);
        make.height.mas_equalTo(@(ScreenWith/4));
    }];
    
    // 操作
    UICollectionViewFlowLayout* actionLayout = [[UICollectionViewFlowLayout alloc] init];
    [actionLayout setSectionInset:UIEdgeInsetsMake(0, 4, 0, 0)];
    [actionLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [actionLayout setMinimumInteritemSpacing:0]; // cell横向间距
    [actionLayout setMinimumLineSpacing:0]; // 只是单行横向也要设置
    [actionLayout setItemSize:CGSizeMake(ScreenWith/4, ScreenWith/4)];
    self.actionBtnCollView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:actionLayout];
    self.actionBtnCollView.backgroundColor = [UIColor clearColor];
    self.actionBtnCollView.dataSource = self;
    self.actionBtnCollView.delegate = self;
    [self.actionBtnCollView registerClass:[ShareBtnCell class] forCellWithReuseIdentifier:ShareBtnCellIdentifier];
    [self.container addSubview:self.actionBtnCollView];
    [self.actionBtnCollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.top.mas_equalTo(ws.shareBtnCollView.mas_bottom).offset(13);
        make.height.mas_equalTo(@(ScreenWith/4));
    }];
    
//    PregNoticeAppDelegate* appDelegate = (PregNoticeAppDelegate*)[[UIApplication sharedApplication] delegate];
//    appDelegate.wxDelegate  = self;
}

// 初始化操作
-(void)loadData:(NSString *)title
        content:(NSString *)content
          image:(UIImage *)image
      image_url:(NSString *)image_url
            url:(NSString *)url
{
    self.title = title;
    self.content = content;
    self.image = image;
    self.image_url = image_url;
    self.url = url;
}

-(void)loadShareImgUrl:(NSString*)img_url
{
//    UIImage *tmpImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:img_url];
//    if(!tmpImage){ // 读取缓存失败，重新下载缓存
//        [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:img_url]
//                                                        options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//                                                        }
//                                                      completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//                                                          if (image) {
//                                                              self.image = image;
//                                                          } else {
//                                                              self.image = [UIImage imageNamed:@"icon"];
//                                                          }
//                                                      }];
//
//    }
//    self.image_url = img_url;
}

//-(void)loadBBSData:(BBSCellData *)bbsData
//       currentUser:(User *)currentUser // 初始化操作，根据当前用户
//{
//    self.bbsData = bbsData;
//
//    if(bbsData.pc==1){ // 图文混排帖子，param error: description is too long
//        self.content = bbsData.content;
//        NSScanner *scanner;
//        NSString *text = nil;
//        scanner = [NSScanner scannerWithString:self.content];
//        while ([scanner isAtEnd] == NO) {
//            [scanner scanUpToString:@"<" intoString:NULL];
//            [scanner scanUpToString:@">" intoString:&text];
//            self.content = [self.content stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@" "];
//        }
//    }else{
//        self.content = bbsData.content;
//    }
//    self.title = bbsData.title;
//    if (bbsData.imageCount>0) // 帖子带图，分享显示的图片就是帖子带的图
//    {
//        // 640p被替换成320p来下载缓存，详见BBSTableViewCell
//        self.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[bbsData.imagesArray objectAtIndex:0]stringByReplacingOccurrencesOfString:@"640p" withString:@"320p"]];
//
//        if(!self.image){ // 读取缓存失败，重新下载缓存
//            [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[[bbsData.imagesArray objectAtIndex:0]stringByReplacingOccurrencesOfString:@"640p" withString:@"320p"]
//                                                            options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//            }
//                                                          completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//                                                              self.image = image;
//            }];
//
//        }
//
//        self.image_url = [bbsData.imagesArray objectAtIndex:0];
//    }else{ // 帖子不带图，分享显示的图片就是帖子作者
//        self.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.bbsData.avatarURL];
//        self.image_url = self.bbsData.avatarURL;
//    }
//
//    // initAction
//    self.actionBtnImgNameArr = [[NSMutableArray alloc] init];
//    self.actionBtnTitleArr = [[NSMutableArray alloc] init];
//
//    self.currentUser = currentUser;
//
//    // 判断当前登录用户是否已收藏过
//    if(self.bbsData.is_mark==1){
//        [self.actionBtnImgNameArr addObject:@"share_unmark"];
//        [self.actionBtnTitleArr addObject:LANG(@"cancelMark")];
//    }else{
//        [self.actionBtnImgNameArr addObject:@"share_mark"];
//        [self.actionBtnTitleArr addObject:LANG(@"mark")];
//    }
//
//    [self.actionBtnImgNameArr addObject:@"share_report"];
//    [self.actionBtnTitleArr addObject:LANG(@"report")];
//
//    if(self.bbsData.is_own == 1){ // 帖子作者自己可以删除
//        [self.actionBtnImgNameArr addObject:@"share_del"];
//        [self.actionBtnTitleArr addObject:LANG(@"delete")];
//    }
//}
//
//-(void)loadBBSDetailData:(DetailTopicViewModel *)viewModel {
//    NSString *content = @"";
//    NSString *imageString = @"";
//    UIImage *image = netimgPlaceHolder;
//    for (DetailContent *one in viewModel.detailTopic.contentArray) {
//        if ((one.contentType == 1) && ([content isEqualToString:@""])) {
//            NSScanner *scanner;
//            NSString *text = nil;
//            content = one.contentString;
//            scanner = [NSScanner scannerWithString:one.contentString];
//            while ([scanner isAtEnd] == NO) {
//                [scanner scanUpToString:@"<" intoString:NULL];
//                [scanner scanUpToString:@">" intoString:&text];
//                content = [content stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@" "];
//            }
//        }
//        if ((one.contentType == 2) && [imageString isEqualToString:@""]) {
//            if (![NSString isBlankString:one.imageUrlString]) {
//                image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:one.imageUrlString]]];
//                if(!image){
//                    [[SDWebImageManager sharedManager] saveImageToCache:image forURL:[NSURL URLWithString:one.imageUrlString]];
//                }
//            }
//            imageString = one.imageUrlString;
//        }
//    }
//    if ([imageString isEqualToString:@""]) {
//        imageString = viewModel.detailTopic.avaterString;
//        image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:viewModel.detailTopic.avaterString];
//    }
//    if(viewModel.detailTopic.isMark==1){
//        if ([[self.actionBtnImgNameArr lastObject] isEqualToString:@"share_mark"]||[[self.actionBtnImgNameArr lastObject] isEqualToString:@"share_unmark"]) {
//            [self.actionBtnTitleArr removeLastObject];
//            [self.actionBtnImgNameArr removeLastObject];
//        }
//        [self.actionBtnImgNameArr addObject:@"share_unmark"];
//        [self.actionBtnTitleArr addObject:LANG(@"cancelMark")];
//    }else{
//        if ([[self.actionBtnImgNameArr lastObject] isEqualToString:@"share_unmark"]||[[self.actionBtnImgNameArr lastObject] isEqualToString:@"share_mark"]) {
//            [self.actionBtnTitleArr removeLastObject];
//            [self.actionBtnImgNameArr removeLastObject];
//        }
//        [self.actionBtnImgNameArr addObject:@"share_mark"];
//        [self.actionBtnTitleArr addObject:LANG(@"mark")];
//    }
//    self.content = [content isEqualToString:@""]?LANG(@"fromPregNotice"):content;
//    self.isFromPush = viewModel.isSplashPresent;
//    self.image = image;
//    self.image_url = imageString;
//    self.title = viewModel.detailTopic.titleString;
//    BBSCellData *shareBBSCellData = [[BBSCellData alloc] init];
//    shareBBSCellData.topic_id = viewModel.detailTopic.topicId;
//    shareBBSCellData.userID = viewModel.detailTopic.topicUserId;
//    self.bbsData = shareBBSCellData;
//    self.currentUser = [User shareInstance];
//    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
//    long long dTime = [[NSNumber numberWithDouble:timeInterval] longLongValue];
//    NSString *time = [NSString stringWithFormat:@"%llu",dTime];
//    NSString *userId = [NSString isBlankString:[[User shareInstance] UserID]] ? @"0" : [[User shareInstance] UserID];
//    self.url = [NSString stringWithFormat:@"http://www.ladybirdedu.com/pregnotice/yunmabang/index.php?id=%@&is_share=1&user_id=%@&time=%@",viewModel.topicId,userId,time];
//    [self show];
//}

// 初始化分享渠道选择
-(void)initArr
{
    self.shareBtnImgNameArr = [NSArray arrayWithObjects:@"share_weixin",@"share_weixin_group",@"share_qq",@"share_qzone"/*,@"PDPV_play_button"*/, nil];
    self.shareBtnTitleArr = [NSArray arrayWithObjects:@"weixinFriend",@"weixinMoments",@"qqFriend",@"qzone", /*@"微信小程序", */nil];
}

#pragma mark -- UICollectionViewDataSource Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark -- UICollectionViewDataSource cell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView == self.shareBtnCollView){
        return [self.shareBtnImgNameArr count];
    }else if(collectionView == self.actionBtnCollView){
        return [self.actionBtnImgNameArr count];
    }else{
        return 0;
    }
}

#pragma mark -- UICollectionViewDataSource 每个cell的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareBtnCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShareBtnCellIdentifier forIndexPath:indexPath];
    if(collectionView == self.shareBtnCollView){
        ShareBtnData *cellData = [[ShareBtnData alloc] init];
        cellData.imgName = self.shareBtnImgNameArr[indexPath.row];
        cellData.title = self.shareBtnTitleArr[indexPath.row];
        [cell loadData:cellData];
        return cell;
    }else if(collectionView == self.actionBtnCollView){
        ShareBtnData *cellData = [[ShareBtnData alloc] init];
        cellData.imgName = self.actionBtnImgNameArr[indexPath.row];
        cellData.title = self.actionBtnTitleArr[indexPath.row];
        [cell loadData:cellData];
        return cell;
    }else{
        return nil;
    }
}

#pragma mark -- UICollectionViewDataSource
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == self.shareBtnCollView){
        NSString *imgName = self.shareBtnImgNameArr[indexPath.row];
        if([imgName isEqualToString:@"share_weixin"]){
            [self weixin];
        }else if([imgName isEqualToString:@"share_weixin_group"]){
            [self weixingroup];
        }else if([imgName isEqualToString:@"share_weibo"]){
//            [self weibo];
        }else if([imgName isEqualToString:@"share_qq"]){
            [self qq];
        }else if([imgName isEqualToString:@"share_qzone"]){
            [self qzone];
        }else if([imgName isEqualToString:@"share_sms"]){
//            [self sms];
        } else {
            [self weChatMini];
        }
    }else if(collectionView == self.actionBtnCollView){
        NSString *imgName = self.actionBtnImgNameArr[indexPath.row];
        if([imgName isEqualToString:@"share_del"]){
            [self delTopic];
        }else if([imgName isEqualToString:@"share_mark"]){
            [self markTopicOrNot:YES];
        }else if([imgName isEqualToString:@"share_unmark"]){
            [self markTopicOrNot:NO];
        }else if([imgName isEqualToString:@"share_report"]){
            [self reportTopic];
        }
    }
    
    return YES;
}

// 显示分享操作框
-(void)show
{
    //    WS(ws);
    if (self.isFromPush) {
//        [self.pushVieController presentViewController:self animated:YES completion:^{
        [self.pushVieController.view addSubview:self.view];
            self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.26];
            CGFloat h = 35+95+50+((iPhoneX)?100:64);
            if([self.actionBtnTitleArr count]>0){
                h += 1+13+95;
            }else{
                [self.actionBtnCollView setHidden:YES];
            }
            // 起始位置
            [_container setFrame:CGRectMake(0, ScreenHeight
                                            , ScreenWith, h)];
//             动画
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            CGPoint point = _container.center;
            point.y -= h;
            [_container setCenter:point];
            [UIView commitAnimations];
//        }];
    }else{
        [[[[[UIApplication sharedApplication] delegate] window] rootViewController] setModalPresentationStyle:UIModalPresentationCurrentContext];
#ifdef __IPHONE_8_0
        [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
#endif
        
        [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:self animated:NO completion:^{
            
            self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.26];
            
//                    [_container mas_remakeConstraints:^(MASConstraintMaker *make) {
//                        make.height.mas_equalTo(@300);
//                        make.left.mas_equalTo(@0);
//                        make.right.mas_equalTo(@0);
//                        make.bottom.equalTo(ws.view.mas_bottom);
//                    }];
            
            CGFloat h = 35+95+50;
            if([self.actionBtnTitleArr count]>0){
                h += 1+13+95;
            }else{
                [self.actionBtnCollView setHidden:YES];
            }
            
            // 起始位置
            [_container setFrame:CGRectMake(0, ScreenHeight, ScreenWith, h)];
            
            // 动画
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            CGPoint point = _container.center;
            point.y -= h;
            [_container setCenter:point];
            [UIView commitAnimations];
            
        }];
    }
}
- (void)showIn: (UIViewController *) viewController {
    self.isFromPush = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.26];
    [viewController.view addSubview:self.view];
    CGFloat h = 35+95+50+((iPhoneX)?100:64);
    if([self.actionBtnTitleArr count]>0){
        h += 1+13+95;
    }else{
        [self.actionBtnCollView setHidden:YES];
    }
    [_container setFrame:CGRectMake(0, ScreenHeight
                                    , ScreenWith, h)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGPoint point = _container.center;
    point.y -= h;
    [_container setCenter:point];
    [UIView commitAnimations];
    WS(ws)
    CGFloat height = (iPhoneX)?86:50;
    [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(height));
        make.left.right.mas_equalTo(@0);
        make.top.mas_equalTo(ws.shareBtnCollView.mas_bottom).offset(1);
    }];
}

- (void)showInView: (UIView *) view {
    self.isFromPush = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.26];
    [view addSubview:self.view];
    [view bringSubviewToFront:self.view];
    CGFloat h = 35+95+50;
    if([self.actionBtnTitleArr count]>0){
        h += 1+13+95;
    }else{
        [self.actionBtnCollView setHidden:YES];
    }
    [_container setFrame:CGRectMake(0, ScreenHeight
                                    , ScreenWith, h)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGPoint point = _container.center;
    point.y -= h;
    [_container setCenter:point];
    [UIView commitAnimations];
    WS(ws)
    [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.top.mas_equalTo(ws.shareBtnCollView.mas_bottom).offset(15);
    }];
}

// 隐藏分享操作框
-(void)hide
{
    if (self.updateMark) {
//        self.updateMark(self.bbsData.is_mark);
    }
    if (self.isFromPush) {
        //        [self.pushVieController presentViewController:self animated:YES completion:^{
        [self.view removeFromSuperview];
    }
    self.view.backgroundColor = [UIColor clearColor];
    [self dismissViewControllerAnimated:YES completion:nil];

    [SVProgressHUD dismiss];
}

#pragma mark -- UIGestureRecognizerDelegate 判断UIGestureRecognizer拦截的点击是否处理
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if(touch.view.tag == BG_VIEW_TAG){ // 是背景view
        return YES; // 交由UITapGestureRecognizer处理
    }
    return NO; // 自己处理
}

// 背景view点击
-(void)bgViewOnClick:(UITapGestureRecognizer *)sender
{
    [self hide];
}

// delegate Sina Weibo Delegate @weibo
//-(void)initSina
//{
//    WBEngine *engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
//    [engine setRootViewController:self];
//    [engine setDelegate:self];
//    [engine setIsUserExclusive:NO];
//    [engine setRedirectURI:@"http://www.ladybirdedu.com"];
//    self.weiBoEngine = engine;
//}
//
//// delegate TencentLoginDelegate @qzone @qq
//-(void)initTenct
//{
//    self.tencentEngine = [[TencentOAuth alloc] initWithAppId:@"100322364"
//                                                 andDelegate:self];
//
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"tencentToken"]) {
//        [self.tencentEngine setAccessToken:[(NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"tencentToken"] objectForKey:@"token"]];
//        [self.tencentEngine setOpenId:[(NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"tencentToken"] objectForKey:@"openid"]];
//        [self.tencentEngine setExpirationDate:[(NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"tencentToken"] objectForKey:@"expiredate"]];
//    }
//    self.permissions=[NSArray arrayWithObjects:
//                      @"get_user_info",@"add_t", @"add_topic",@"add_pic_t",@"get_info",@"check_page_fans",@"add_idol",nil];
//}
//
//// @weibo
//- (int)sinaCountWord:(NSString*)s withCount:(NSInteger)count
//{
//    int i,n=(int)[s length],l=0,a=0,b=0;
//    unichar c;
//    for(i=0;i<n;i++){
//        c=[s characterAtIndex:i];
//
//        if(isblank(c)){
//            b++;
//        }else if(isascii(c)){
//            a++;
//        }else{
//            l++;
//        }
//        if (l+(int)ceilf((float)(a+b)/2.0)==count) {
//            return i;
//        }
//    }
//    if(a==0 && l==0) return 0;
//    return 0;
//}
//// @weibo
//- (int)sinaCountWord:(NSString*)s
//{
//    int i,n=(int)[s length],l=0,a=0,b=0;
//    unichar c;
//    for(i=0;i<n;i++){
//        c=[s characterAtIndex:i];
//        if(isblank(c)){
//            b++;
//        }else if(isascii(c)){
//            a++;
//        }else{
//            l++;
//        }
//    }
//    if(a==0 && l==0) return 0;
//
//    return l+(int)ceilf((float)(a+b)/2.0);
//}
//
//// @weixin @weixingroup
//- (void)sendImageContent:(int)WXScene
//{
//    //发送内容给微信
//    WXMediaMessage *message = [WXMediaMessage message];
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.scene = WXScene;
//    req.bText = NO;
//    UIImage *thumbimage;
//    if (self.url.length>0) { // 分享链接时，注意thumbimage的大小，否则无法发送分享请求
//        WXWebpageObject *urlobject = [WXWebpageObject object];
//        urlobject.webpageUrl = self.url;
//
//        if(self.image.size.width>100){
//            thumbimage = [ImageClass imageByScalingToSize:CGSizeMake(100, self.image.size.height*100/self.image.size.width) sourceImage:self.image]; // 限制大小
//        }else{
//
//
//            thumbimage = self.image;
//        }
//
//        message.title = self.title;
//
//        //        message.description = self.content;
//        NSString *description = self.content;
//        if(description.length>100){
//            description = [description substringWithRange:NSMakeRange(0, 100)];
//        }
//        message.description = description;
//
//        message.mediaObject = urlobject;
//    } else {
//        UIImage *image=NULL;
//        WXImageObject *imageobject;
//        ImageGenerationView *imageGenerationView = [[ImageGenerationView alloc] init];
//        imageGenerationView.title = self.title;
//        imageGenerationView.content = self.content;
//
//        if (self.image.size.width>=300&&self.image.size.height>=300) {
//            imageGenerationView.image=[ImageClass imageByScalingToSize:CGSizeMake(300, 300) sourceImage:self.image];
//        } else {
//            imageGenerationView.image=self.image;
//        }
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGSize contentSize=[self.content boundingRectWithSize:CGSizeMake(300, 310) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
//        CGSize totalSize=CGSizeMake(310, 60+contentSize.height+imageGenerationView.image.size.height);
//        UIGraphicsBeginImageContext(CGSizeMake(320, totalSize.height));
//        UIGraphicsPushContext(context);
//        UIGraphicsPopContext();
//        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
//        [imageGenerationView drawRect:CGRectMake(0, 0, 320, totalSize.height)];
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        NSData *imageData=UIImageJPEGRepresentation(self.image, 60);
//        imageobject = [WXImageObject object];
//        imageobject.imageData = imageData;
//        thumbimage = [ImageClass imageByScalingToSize:CGSizeMake(100, image.size.height*100/image.size.height) sourceImage:image];
////        NSData* data = UIImagePNGRepresentation(thumbimage);
//        message.mediaObject = imageobject;
//        message.title = self.title;
//    }
//    [message setThumbImage:thumbimage];
//    req.message = message;
//
//    if([WXApi sendReq:req]){
//        [self hide];
//    }
//
//}
//
//// @weixin @weixingroup
//- (void)sendTextContent:(int)WXScene
//{
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.bText = YES;
//    req.text = [NSString stringWithFormat:@"%@",self.content];
//    req.scene = WXScene;
//    if ([WXApi sendReq:req]) {
//        [self hide];
//    }
//}

#pragma mark -- TencentLoginDelegate tencentDidLogin @qzone @qq
//- (void)tencentDidLogin
//{
//    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithObjectsAndKeys: self.tencentEngine.accessToken,@"token",self.tencentEngine.expirationDate,@"expiredate",self.tencentEngine.openId,@"openid", nil] forKey:@"tencentToken"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//#pragma mark -- TencentLoginDelegate tencentDidNotLogin @qzone @qq
//- (void)tencentDidNotLogin:(BOOL)cancelled
//{
//    [SVProgressHUD showErrorWithStatus:LANG(@"loginFail")];
//}
//#pragma mark -- TencentLoginDelegate tencentDidNotNetWork @qzone @qq
//- (void)tencentDidNotNetWork
//{
//    [SVProgressHUD showErrorWithStatus:LANG(@"networkError")];
//}
//
//#pragma mark -- Sina Weibo Delegate engineDidLogIn @weibo
//-(void)engineDidLogIn:(WBEngine *)_webEngine
//{
//    [_webEngine addWeiBoFocus];
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"sinaAsyn_new"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [self weibo];
//}
//#pragma mark -- Sina Weibo Delegate requestDidFailWithError @weibo
//- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error
//{
//    [SVProgressHUD showErrorWithStatus:LANG(@"shareFail")];
//}
//#pragma mark -- Sina Weibo Delegate requestDidSucceedWithResult @weibo
//- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result
//{
//    [SVProgressHUD showSuccessWithStatus:LANG(@"shareSuc")];
//    [self hide];
//}
//
//#pragma mark - afn delegate
//-(void)afnRequestFailed:(id)responseObject withUserInfo:(NSDictionary *)userInfo
//{
//    NSString *key = [userInfo objectForKey:@"key"];
//    if ([key isEqualToString:@"delTopic"])
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:LANG(@"postDelFail") message:nil delegate:nil cancelButtonTitle:LANG(@"confirm") otherButtonTitles:nil, nil];
//        [alertView show];
//    }
//}
//-(void)afnRequestFinished:(id)responseObject withUserInfo:(NSDictionary *)userInfo
//{
//    NSString *key = [userInfo objectForKey:@"key"];
//    if ([key isEqualToString:@"delTopic"])
//    {
//        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSDictionary *responseDic = [responseStr JSONValue];
//        NSString *status = [responseDic objectForKey:@"status"];
//        if ([status isEqualToString:@"success"]) { // 删除成功
//
//            if (self.shareControlViewDelegate && [self.shareControlViewDelegate respondsToSelector:@selector(shareCtrlViewDelCallback)])
//            {
//                [self.shareControlViewDelegate shareCtrlViewDelCallback];
//            }
//
//        } else { // 删除失败
//
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:LANG(@"NSCV_NoPermsDelPost") message:nil delegate:nil cancelButtonTitle:LANG(@"confirm") otherButtonTitles:nil, nil];
//            [alertView show];
//
//        }
//    }else if([key isEqualToString:@"reportTopic"]){
//        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSDictionary *responseDic = [responseStr JSONValue];
//        NSString *status = [responseDic objectForKey:@"status"];
//        if ([status isEqualToString:@"success"]) { // 举报成功
//            [SVProgressHUD showSuccessWithStatus:LANG(@"reportSuc")];
//
//            [self performSelector:@selector(hide) withObject:nil afterDelay:2.0];
////            [self hide];
//        }else{
//            [SVProgressHUD showErrorWithStatus:LANG(@"reportFail")];
//        }
//    }else if([key isEqualToString:@"markTopic"] || [key isEqualToString:@"unmarkTopic"]){
//
//        BOOL mark = [key isEqualToString:@"markTopic"]?YES:NO;
//
//        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSDictionary *responseDic = [responseStr JSONValue];
//        NSString *status = [responseDic objectForKey:@"status"];
//        if ([status isEqualToString:@"success"]) { // 成功
//            [SVProgressHUD showSuccessWithStatus:mark?LANG(@"markSuc"):LANG(@"cancelMarkSuc")];
//
//            self.bbsData.is_mark = mark?1:0;
//
//            if(mark){
//                NSUInteger index_img = [self.actionBtnImgNameArr indexOfObject:@"share_mark"];
//                NSUInteger index_title = [self.actionBtnTitleArr indexOfObject:LANG(@"mark")];
//                if (index_img < [self.actionBtnImgNameArr count]) {
//                    [self.actionBtnImgNameArr setObject:@"share_unmark" atIndexedSubscript:index_img];
//                }
//                if (index_title < [self.actionBtnTitleArr count]) {
//                    [self.actionBtnTitleArr setObject:LANG(@"cancelMark") atIndexedSubscript:index_title];
//                }
//            }else{
//                NSUInteger index_img = [self.actionBtnImgNameArr indexOfObject:@"share_unmark"];
//                NSUInteger index_title = [self.actionBtnTitleArr indexOfObject:LANG(@"cancelMark")];
//                if (index_img < [self.actionBtnImgNameArr count]) {
//                    [self.actionBtnImgNameArr setObject:@"share_mark" atIndexedSubscript:index_img];
//                }
//                if (index_title < [self.actionBtnTitleArr count]) {
//                    [self.actionBtnTitleArr setObject:LANG(@"mark") atIndexedSubscript:index_title];
//                }
//            }
//            [self.actionBtnCollView reloadData];
//            [self performSelector:@selector(hide) withObject:nil afterDelay:2.0];
//        }else{
//            [SVProgressHUD showErrorWithStatus:mark?LANG(@"markFail"):LANG(@"cancelMarkFail")];
//        }
//    }
//}
//
//#pragma mark -- UIAlertViewDelegate clickedButtonAtIndex
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if(alertView == self.delTopicAlertView){
//        if (buttonIndex==1) // 0-cancel 1-ok
//        {
//            [self.netWork delTopicWithTID:self.bbsData.topic_id Uid:self.currentUser.UserID];
//        }
//    }
//}

// @NetWorkManagerDelegate @UIAlertViewDelegate
-(void)delTopic
{
    if(!self.delTopicAlertView){
        self.delTopicAlertView = [[UIAlertView alloc] initWithTitle: @"confirmDelPost" message:nil delegate:self cancelButtonTitle: @"cancel" otherButtonTitles: @"confirm", nil];
    }
    [self.delTopicAlertView show];
}

// 收藏帖子
-(void)markTopicOrNot:(BOOL)mark
{
//    if(self.currentUser.UserID.length>0){
//        [self.netWork markTopicOrNot:self.bbsData.topic_id user_id:self.currentUser.UserID markOrNot:mark];
//    }else{
//        [SVProgressHUD showErrorWithStatus:LANG(@"NSCV_NoLogin")];
//    }
}

// 举报帖子
-(void)reportTopic
{
//    if(self.currentUser.UserID.length>0){
//        [self.netWork reportTopic:self.bbsData.topic_id vote_user_id:self.bbsData.userID user_id: [NSString stringWithFormat: @"%ld", (long)[CiUser sharedInstance].userId]];
//    }else{
//        [SVProgressHUD showErrorWithStatus:LANG(@"NSCV_NoLogin")];
//    }
}

//// @sendImageContent @sendTextContent @CiActionStatic.h @WXApi.h
//-(void)weixin
//{
//    if ([WXApi isWXAppInstalled]) {
//        //        if (self.image!=nil) {
//        [self sendImageContent:WXSceneSession];
//        //        } else {
//        //            [self sendTextContent:WXSceneSession];
//        //        }
//    } else {
//        [SVProgressHUD showErrorWithStatus:LANG(@"weixinNeedLastVer")];
//    }
//}
//
//// @sendImageContent @sendTextContent @CiActionStatic.h @WXApi.h
//-(void)weixingroup
//{
//    if ([WXApi isWXAppInstalled]) {
//        //        if (self.image!=nil) {
//        [self sendImageContent:WXSceneTimeline];
//        //        } else {
//        //            [self sendTextContent:WXSceneTimeline];
//        //        }
//    } else {
//        [SVProgressHUD showErrorWithStatus:LANG(@"weixinNeedLastVer")];
//    }
//}
//
//-(void) weChatMini {
//
//    WXMiniProgramObject *wxMini = [WXMiniProgramObject object];
//    wxMini.webpageUrl = self.url;
//    wxMini.userName   = @"gh_ae70767a2ea2";
//    wxMini.path       = @"pages/can-i-eat/food";
////    UIImage *tmpImage = [ImageClass imageByScalingToSize:CGSizeMake(250, 200) sourceImage:self.image];
//    wxMini.hdImageData = UIImageJPEGRepresentation(self.image, 60);
//
//    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = self.title;
//    message.description = self.content;
//    message.mediaObject = wxMini;
//    message.thumbData   = nil;//UIImageJPEGRepresentation([ImageClass imageByScalingToSize:CGSizeMake(100, 100) sourceImage:self.image], 60);
//
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.message = message;
//    req.scene  = WXSceneSession;
//
//    if([WXApi sendReq:req]){
//        [self hide];
//    }
//
//
//}
//
//// @sinaCountWord @sinaCountWord:withCount @CiActionStatic.h
//-(void)weibo
//{
//    if(!self.weiBoEngine){
//        [self initSina];
//    }
//
//    /*判断是否登陆，要有两个条件：1,userid,accessToken还有一个expireTime,并且expireTime没有失效*/
//    if ([self.weiBoEngine isLoggedIn] && ![self.weiBoEngine isAuthorizeExpired])
//    {
//        NSString *url = self.url.length>0?self.url:@"https://itunes.apple.com/cn/app/yun-qi-ti-xing-huai-yun-bi-bei/id455193014?mt=8";
//        NSString *sinaOfficeDirector = LANG(@"atLadybird");
//        NSInteger urlCount = [self sinaCountWord:url];
//        NSInteger fixCount = [self sinaCountWord:sinaOfficeDirector];
//        NSInteger ShengXia = 140-urlCount-fixCount;
//        NSInteger count = [self sinaCountWord:[NSString stringWithFormat:@"%@%@%@",self.content,sinaOfficeDirector,url]];
//        NSString *sendText = NULL;
//        if (count <= 140) {
//            sendText = [NSString stringWithFormat:@"%@%@%@",self.content,sinaOfficeDirector,url];
//        } else {
//            NSInteger index = [self sinaCountWord:self.content withCount:ShengXia];
//            NSString *prefixText = [self.content substringToIndex:index];
//            sendText=[NSString stringWithFormat:@"%@%@%@",prefixText,sinaOfficeDirector,url];
//        }
//        [self.weiBoEngine sendWeiBoWithText:[NSString stringWithFormat:@"%@",sendText] image:(self.image!=nil?self.image:nil)];
//        [SVProgressHUD showWithStatus:LANG(@"sending")];
//    } else {
//        [self.weiBoEngine logIn];
//        return;
//    }
//}
//
//// @initTenct @CiActionStatic.h
//-(void)qq
//{
//
//
//    if (!self.tencentEngine) {
//        [self initTenct];
//
//    }
//
//    if (![TencentOAuth iphoneQQInstalled]||![TencentOAuth iphoneQQSupportSSOLogin]) {
//        [SVProgressHUD showErrorWithStatus:LANG(@"qqNeedLastVer")];
//        return;
//    }
//
//    if(self.postShareSuccessToSever)
//    {
//        PregNoticeAppDelegate* appDelegate = (PregNoticeAppDelegate*)[[UIApplication sharedApplication] delegate];
//        appDelegate.postShareSuccessToSever =self.postShareSuccessToSever;
//    }
//    if ([self.tencentEngine isSessionValid]) {
//        // 旧版中，没有图的帖子，只分享一段文字的功能取消
//        //        if (self.image==nil) {
//        //            QQApiTextObject *txtObj = [QQApiTextObject objectWithText:self.content];
//        //
//        //            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
//        //            //将内容分享到qq
//        //            [QQApiInterface sendReq:req];
//        //        } else {
//        NSString *url = self.url==nil?@"http://a.app.qq.com/o/simple.jsp?pkgname=com.ci123.pregnancy&g_f=991653":self.url;
//        // param error: description is too long
//        NSString *description = self.content;
//        if(description.length>100){
//            description = [description substringWithRange:NSMakeRange(0, 100)];
//        }
//
//        if(self.image_url.length>0){
//            NSString *previewImageUrl = self.image_url;
//            QQApiNewsObject *obj = [QQApiNewsObject
//                                    objectWithURL:[NSURL URLWithString:url]
//                                    title:self.title
//                                    description:description
//                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
//            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
//            [QQApiInterface sendReq:req];
//        }else{
////            UIImage *thumbimage = [ImageClass imageByScalingToSize:CGSizeMake(100, self.image.size.height*100/self.image.size.height) sourceImage:self.image];
//            NSData *imgData = UIImageJPEGRepresentation(self.image,60);
//            NSLog(@"jpg is ok");
//            QQApiImageObject *object = [QQApiImageObject objectWithData:imgData previewImageData:nil title:self.title description:self.description];
//            /*
//            QQApiNewsObject *obj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url]
//                                                            title:self.title
//                                                      description:description
//                                                 previewImageData:imgData];
//             */
//            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:object];
//
//            [QQApiInterface sendReq:req];
//        }
//    }
//    else
//    {
//        [self.tencentEngine authorize:self.permissions inSafari:NO];
//    }
//}

//// @initTenct @CiActionStatic.h
//-(void)qzone
//{
//    if (!self.tencentEngine) {
//        [self initTenct];
//    }
//    if (![TencentOAuth iphoneQQInstalled]||![TencentOAuth iphoneQQSupportSSOLogin]) {
//        [SVProgressHUD showErrorWithStatus:LANG(@"qqNeedLastVer")];
//        return;
//    }
//    if ([self.tencentEngine isSessionValid]) {
//        NSString *utf8String = self.url.length>0?self.url:@"https://itunes.apple.com/cn/app/yun-qi-ti-xing-huai-yun-bi/id455193014?mt=8";
//        NSString *title = self.title==nil?@"孕期提醒":self.title;
//        NSLog(@"title = %@",title);
//        // param error: description is too long
//        NSString *description = self.content;
//        if(description.length>100){
//            description = [description substringWithRange:NSMakeRange(0, 100)];
//        }
//
//        if(self.image_url.length>0){
//            NSString *previewImageUrl = self.image_url;
//            QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String]
//                                                                title:title
//                                                          description:description
//                                                      previewImageURL:[NSURL URLWithString:previewImageUrl]];
//            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
//            [QQApiInterface SendReqToQZone:req];
//        }else{
//
//            //self.image = [ImageClass imageByScalingToSize:CGSizeMake(300, 300) sourceImage:self.image];
//            NSData *imgData = UIImageJPEGRepresentation(self.image, 60);
//            /*
//            QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String]
//                                                                title:title
//                                                          description:description
//                                                     previewImageData:imgData];
//             */
//            NSArray *imgArr = @[imgData];
//            //QQApiImageObject *object = [QQApiImageObject objectWithData:imgData previewImageData:nil title:title description:description];
//            QQApiImageArrayForQZoneObject *obj = [QQApiImageArrayForQZoneObject objectWithimageDataArray:imgArr title:title];
//
//            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
//            [QQApiInterface SendReqToQZone:req];
//        }
//    }
//    else
//    {
//        [self.tencentEngine authorize:self.permissions inSafari:NO];
//    }
//}

//// @messageComposeDelegate
//-(void)sms
//{
//    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
//    picker.messageComposeDelegate = self;
//    NSString *smsBody =[NSString stringWithFormat:@"%@-－%@",self.content,LANG(@"fromPregNotice")] ;
//    picker.body=smsBody;
//    if (iOS7&&self.image!=nil) { // 带图片的分享短信发送失败，暂未解决
//        NSData *imgData = UIImagePNGRepresentation(self.image);
//        [picker addAttachmentData:imgData typeIdentifier:@"public.data" filename:@"image.png"];
//    }
//    if (iOS7) {
//        picker.navigationBar.tintColor = [UIColor whiteColor];
//    }
//    else
//    {
//        picker.navigationBar.tintColor = [UIColor colorWithRed:244/255.0 green:81/255.0 blue:122/255.0 alpha:1];
//    }
//    [self presentViewController:picker animated:YES completion:nil];
//}
//
//#pragma mark -- messageComposeDelegate @sms
//- (void)messageComposeViewController:(MFMessageComposeViewController *)_controller didFinishWithResult:(MessageComposeResult)result
//{
//    [_controller dismissViewControllerAnimated:YES completion:^{
//
//    }];
//}
//
//#pragma mark - 分享成功回调
//// qqZone
//- (void)addShareResponse:(APIResponse *)response {
//
//    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"qq zone:%@",response.message ]];
//
//    if ([response.message isEqualToString:@"success"] && self.postShareSuccessToSever) {
//        self.postShareSuccessToSever();
//    }
//}
//
//// qq
////- (void)onResp:(QQBaseResp *)resp {
////
////     [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"qq:%@",resp.result]];
////
////    if (resp.type == kOpenSDKErrorSuccess && self.postShareSuccessToSever) {
////        self.postShareSuccessToSever();
////    }
////}
//
//// WX Delegate
//- (void)onResp:(BaseResp *)resp {
//    //微信回调
//    if (resp.errCode == WXSuccess && self.postShareSuccessToSever) {
//        self.postShareSuccessToSever();
//    }
//    //    NSLog(@"WX onResp %d %@",resp.errCode,resp.errStr);
//}


@end
