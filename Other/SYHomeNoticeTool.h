//
//  SYHomeNoticeTool.h
//  PregNotice
//
//  Created by 大大大大荧 on 16/10/20.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//@class PregnancyCheckComfirmViewModel;

//typedef NS_ENUM(NSInteger, HomeNoticeLocalNotificationType){
//    HNLNTPregnancyCheck = 233,
//    HNLNTDailyKnowledge,
//    HNLNTBabyCheck,
//    HNLNTBabyVassicine,
//    HNLNTFetalMovementMorning,
//    HNLNTFetalMovementAfternoon,
//    HNLNTFetalMovementEvening,
//    HNLNTEveryDaySignIn,
//    HNLNTDaDuMovie,
//};

@interface SYHomeNoticeTool : NSObject

/**
 唤起登陆记录
 @param viewController 需要唤起登陆的当前控制器
 */
+ (void) showLoginViewControllerWithNavigationController : (UIViewController *) viewController ;

/**
 统计数据
 @param eventName 事件名称
 */
+ (void) addClickCountWithName : (NSString *) eventName ;

/**
 添加返回按钮
 @param controller 当前控制器
 */
+ (void) addBackButton:(UIViewController*)controller ;
+ (void) addBlackBackButton:(UIViewController*)controller ;

/**
 底部tabbar显示隐藏
 */
+ (void) tabbarIsShow: (BOOL) show ;

/**
 默认灰色label
 */
+ (UILabel *) getStaticLabel ;

/**
 获取距离预产期天数
 */
+ (NSInteger) getDayLeft;

/**
 根据日期和格式获取当天周数
 @param checkDateString 日期
 @param dateFormatString 日期格式
 @return 该日期为周几
 */
+ (NSString *) getWeekdayStringWithPregDate: (NSString *)checkDateString withDateFormat:(NSString *)dateFormatString;

+ (NSDictionary *)getBabyWHAndIntroDetailDictionaryByWeek:(NSInteger)week withTable:(BOOL) table;

/**
 根据[year,month,day] 获取形如 XX月XX日/XXXX年字符串
 @param tmpArray [year,month,day]
 @param isSelected 是否选中是否标红
 @return
 */
+ (NSAttributedString *) transformListShowStringWithDateStringArray: (NSArray *) tmpArray withIsSelected: (BOOL) isSelected withFontSize:(CGFloat) fontSize;

+ (NSAttributedString *) transformListShowStringWithDateStringArray2: (NSArray *) tmpArray withIsSelected: (BOOL) isSelected;

/**
 获取指定日期距离今天天数
 @param dateString 日期
 @param dateFormatString 日期格式
 @return 距离今天天数（string）
 */
+ (NSString *)getDayBetweenTodayAndDateString:(NSString *)dateString withDateFormat:(NSString *)dateFormatString;

+ (NSString *)getWeekByDateStr:(NSString *)dateString withDateFormat:(NSString *)dateFormatString;

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

//+ (void) setLocalNotificationWithType:(HomeNoticeLocalNotificationType) type;
//
//- (void) removeLocalNotificationWithType:(HomeNoticeLocalNotificationType)type ;

+ (BOOL) updatePregnancyCheckWithCheckID:(NSInteger)checkID withDayTime:(NSInteger)day;

/**
 当前签到完成移除本次签到提醒
 @param dateString yyyy-MM-dd
 */
+ (void) removeLocalNotificationWithNotificationDateString : (NSString *) dateString ;

/**
 图片加水印存入本地
 @param image 图片
 @param userName 水印上的用户名
 */
- (void) writeIntoLocalAblumWithSelectedImage :(UIImage *) image withUserName:(NSString *) userName;

/**
 根据用户id最后一位和当前天数(距1970)最后一位
 @return 是否可以今天上传
 */
+ (BOOL) isUploadFileDataTodayNow ;

/**
 获取mac地址
 */
+ (NSString *) getMacAddress ;

+ (NSString *) date2Str:(NSDate *)date;
+ (NSString *) dateTime2Str:(NSDate *)date;
+ (NSDate *) str2Date:(NSString *)str;
+ (NSDate *) str2DateTime:(NSString *)str;

/**
 获取本地加密token
 */
+ (NSString *) getServerRequestTokenString ;

/**
 获取baby_id
 */
+ (void) checkBabyId: (NSString *) babyId ;

/**
  获取宝宝年纪
 */
+ (NSString *) getBabyAgeStringWithNowDate: (NSDate *) nowDate ;

@end
