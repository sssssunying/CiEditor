//
//  ConfigConst.h
//  preNoticeDemo
//
//  Created by 彤辉 沈 on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4_retain ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
#define iOS7  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?YES:NO)
#define iOS8  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0?YES:NO)

#define SYSTEMVERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define Scalex ([[UIScreen mainScreen] bounds].size.height>480?[[UIScreen mainScreen] bounds].size.width/320.0:1)
#define Scaley ([[UIScreen mainScreen] bounds].size.height>480?[[UIScreen mainScreen] bounds].size.height/568.0:1)
#define ScreenWith ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)

#ifndef preNoticeDemo_ConfigConst_h
#define preNoticeDemo_ConfigConst_h
#define replyContentSizeWidth 295
#define replyReplyTopMargin 14
#define replyReplyBottomMargin 8
#define replyReplyDistanceTitle 9
#define replyReplyLeftMargin 8
#define replyReplyBackGroundWith 287
#define userNameHeight 18
#define titleHeight 25
#define contentSizeHeight 5000//
#define footerHeight 30//时间地点评价所占的高度
#define avaterMarginX 12//头像距离x轴的距离
#define avaterMarginY 15//头像距离y轴的距离
#define titleWidth 294
#define contentWidth 294
#define myTitleFont 16
#define contentFont 16
#define LEFT_BLANK 55 //cell左边的空白宽度
#define avatarSizeWidth 36
#define avatarSizeHeight 36
#define contentMarginX 12
#define contentMarginY 51
#define contentSizeWidth 295
#define contentSizePurchaseWidth 293
#define whoSeeMeHeight 30
#define wordNum 74
#define imageShowWordNum 40
#define noImageShowWordNum 80
#define activityRowHeight 44
#define MaxNickNameNum 10
#define oauth2TokenKey @"access_token="
#define oauth2OpenidKey @"openid="
#define oauth2OpenkeyKey @"openkey="
#define oauth2ExpireInKey @"expires_in="
#define kWBSDKDemoAppKey @"4273619100"
#define kWBSDKDemoAppSecret @"9061465e2180acb6ca273bd68dc027e6"
#define replyOtherViewHeight 32
#define textMarginLeft 20
#define textMarginTop 13
#define textMarginBottom 13
#define noticeNoCheckHeight 74
#define firstSpacingHeight 40
#define NumberOfPage 280

#define YUERNAVIGATIONCOLOR [UIColor colorWithRed:28.0/255.0 green:147.0/255.0 blue:238.0/255.0 alpha:1.0]
#define TEXT_COLOR [UIColor colorWithRed:118/255.0 green:118/255.0 blue:118/255.0 alpha:1.0]
#ifndef kWBSDKDemoAppKey
#error
#endif

#ifndef kWBSDKDemoAppSecret
#error
#endif
#endif
enum
{
    KKFromOthers=0,
    KKFromHomeBBS=1,
    KKFromHomeMine=2
    
};
typedef NSUInteger KKFrom;
typedef enum{
    postTopicFromShou=0,
    postTopicFromActivity=1,
    
} postTopicFromWhere;
typedef enum
{
    initValue=-1,
    Pregnancy=1,
    BeiYun=0,
    NewYuEr=2,
    Yuer=3
    
}PregStatus;
enum
{
    RegisterFromBBS=0,
    RegisterFromPerson=1,
    RegisterFromDiary=2
    
};
typedef NSUInteger RegisterFromWhere;

enum
{
    KKFromNearBy=0,
    KKFromBBS=1,
    
    
};
typedef NSUInteger KKFromWhereTo;

enum
{
    NoticeCheck=1,
    NoticeWater=2,
    NoticeSports=3,
    NoticeMaMa=4,
    NoticeHospital=5,
    NoticeBabyPhysical=6,
    NoticeBabyVaccine=7,
    NoticeAudio=9,
    NoticeYuerMaMa=8,
    
    BiBeiNotice = 111,
    PrefectBabyInfoNotice = 112,
    DaDuMovieNotice=113,
};
typedef NSUInteger NoticeType;

enum
{
    VaccineCost=0,
    VaccineFree=1,
    VaccineAll=2
};
typedef NSUInteger VaccineToken;
enum
{
    FromPersonToDirection=0,
    FromNoticeToDirection=1,
    FromRacBBSToDirection=2
    
};

typedef NSUInteger FromWhereToDirection;

enum
{
    StyleBBSDetail=0,
    StyleHospitalDiscuss=1,
    StyleMessage=2,
    StyleMaMa=3,
};
typedef NSInteger StyleReply;

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define ARGBColor(a,r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define IDFA [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]
#define VERSION ([NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]])

//#define VERSION @"6.1"

#define PLAT @"11"

#define UDID [CIOpenUDID value]
#define avatarPlaceHolder [UIImage imageNamed:@"avatar_placeholder_green.png"]
#define netimgPlaceHolder [UIImage imageNamed:@"netplaceholder"]
#define fromnetimgPlaceHolder [UIImage imageNamed:@"http://www.ladybirdedu.com/pregnotice/images/default.png"]
#define LINE_COLOR [UIColor colorWithRed:242/255.0 green:232/255.0 blue:231/255.0 alpha:1.0]
#define FONT(s) [UIFont systemFontOfSize:(s)]
#define BFONT(s) [UIFont boldSystemFontOfSize:(s)]
#define PREGNOTICE_NAVIGATION_COLOR [UIColor colorWithRed:101.0/255.0 green:196.0/255.0 blue:170.0/255.0 alpha:1]
#define PREGNOTICE_NEW_NAVGATION_COLOR [UIColor colorWithRed:101.0/255.0 green:196.0/255.0 blue:170.0/255.0 alpha:1]

#define iOS11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0?YES:NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define NAVHEIGHT ((iOS11)?((iPhoneX)?140:88):64)
