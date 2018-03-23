//
//  SYHomeNoticeTool.m
//  PregNotice
//
//  Created by 大大大大荧 on 16/10/20.
//
//

#import "SYHomeNoticeTool.h"
@import SVProgressHUD;
//#import "HomeNoticeConfig.h"
//#import "PregnancyCheckComfirmViewModel.h"
//#import "BaByInfo.h"
//#import <AssetsLibrary/AssetsLibrary.h>
//#import "LoginPregNoticeViewController.h"
//#import <SystemConfiguration/CaptiveNetwork.h>
//#import <NetworkExtension/NetworkExtension.h>
//#import <UserNotifications/UserNotifications.h>
//#import "AuthorizationController.h"
//
//#import "CiUser.h"
//#import <PregNotice-Swift.h>

//@interface SYHomeNoticeTool ()
//@property (nonatomic,strong) ALAssetsLibrary *library;
//@end

@implementation SYHomeNoticeTool

//- (ALAssetsLibrary *)library {
//    if (!_library) {
//        _library = [[ALAssetsLibrary alloc] init];
//    }
//    return _library;
//}
    
+ (NSAttributedString *) transformListShowStringWithDateStringArray2: (NSArray *) tmpArray withIsSelected: (BOOL) isSelected {
//    NSString *year = tmpArray[0];
//    NSString *month = tmpArray[1];
//    NSString *day = tmpArray[2];
//    NSMutableAttributedString *mulString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@%@%@",year,LANG(@"year"), month,LANG(@"month"),day,LANG(@"oneDay")] attributes:@{NSFontAttributeName:HOMENOTICE_FONT_15,NSForegroundColorAttributeName:(isSelected)?(HOMENOTICE_COLOR_204):(HOMENOTICE_COLOR_64)}];
//
//    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
//    NSString *formatString = @"yyyy-MM-dd";
//    NSString *week = [SYHomeNoticeTool getWeekByDateStr:dateStr withDateFormat:formatString];
//
//    [mulString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"    %@", week] attributes:@{NSFontAttributeName:HOMENOTICE_FONT_12,NSForegroundColorAttributeName:isSelected?(HOMENOTICE_COLOR_204):(HOMENOTICE_COLOR_64)}]];
//    return mulString;
    
    return [[NSAttributedString alloc] init];
}

+ (NSAttributedString *) transformListShowStringWithDateStringArray: (NSArray *) tmpArray withIsSelected: (BOOL) isSelected withFontSize:(CGFloat) fontSize {
//    if ([tmpArray count] < 2) {
//        return [[NSAttributedString alloc] initWithString:@""];
//    }
//    NSString *year = tmpArray[0];
//    NSString *month = tmpArray[1];
//    NSString *day = tmpArray[2];
//    NSMutableAttributedString *mulString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@ ",month,LANG(@"month"),day,LANG(@"oneDay")] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:fontSize],NSForegroundColorAttributeName:(isSelected)?(HOMENOTICE_COLOR_64):(HOMENOTICE_COLOR_64)}];
//
//    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
//    NSString *formatString = @"yyyy-MM-dd";
//    NSString *week = [SYHomeNoticeTool getWeekByDateStr:dateStr withDateFormat:formatString];
//
//    [mulString appendAttributedString:[[NSAttributedString alloc] initWithString:week attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:11],NSForegroundColorAttributeName:isSelected?(HOMENOTICE_COLOR_64):(HOMENOTICE_COLOR_64)}]];
//    return mulString;
    
    return [[NSAttributedString alloc] init];
}

+ (NSString *)getDayBetweenTodayAndDateString:(NSString *)dateString withDateFormat:(NSString *)dateFormatString{
//    NSString *returnString = LANG(@"today");
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:dateFormatString];
//    NSDate *thisDate = [formatter dateFromString:dateString];
//    NSTimeInterval timerNowInterval = [thisDate timeIntervalSinceDate:[NSDate date]];
//    NSInteger day = ceil(timerNowInterval/86400);
//    if (day == 0) {
//        returnString = LANG(@"today");
//    } else if (day == 1) {
//        returnString = LANG(@"tomorrow");
//    } else if(day > 0) {
//        returnString = [NSString stringWithFormat:@"%ld天后",(long)day];
//    } else {
//        returnString = [NSString stringWithFormat:@"%ld天前",-(long)day];
//    }
//    return returnString;
    
    return @"12";
}

+ (NSString *) getWeekByDateStr:(NSString *)dateString withDateFormat:(NSString *) dateFormatString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatString];
    NSDate *thisDate = [formatter dateFromString:dateString];
    return [SYHomeNoticeTool weekdayStringFromDate:thisDate];
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

//- (void)removeLocalNotificationWithType:(HomeNoticeLocalNotificationType)type {
//    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
//    for (UILocalNotification *localNotification in notificationArray) {
//        NSDictionary *dic = localNotification.userInfo;
//        NSInteger notificationType = [[dic objectForKey:@"localNotificationType"] intValue];
//        if (notificationType == type && [dic objectForKey:@"localNotificationType"]) {
//            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
//        }
//    }
//}

+ (void) removeLocalNotificationWithNotificationDateString : (NSString *) dateString {
//    NSArray *localArr = [[UIApplication sharedApplication] scheduledLocalNotifications];
//    if (localArr) {
//        for (UILocalNotification *noti in localArr) {
//            NSDictionary *dict = noti.userInfo;
//            if (dict) {
//                HomeNoticeLocalNotificationType type = [[dict objectForKey:@"localNotificationType"] integerValue];
////                NSString *localDay = [dict objectForKey:@"localNotificationDay"];
//                if (type == HNLNTEveryDaySignIn) {
////                    if ([localDay isEqualToString:dateString]) {
//                        [[UIApplication sharedApplication] cancelLocalNotification:noti];
//                        return ;
////                   / }
//                }
//            }
//        }
//    }
}

//+ (void)setLocalNotificationWithType:(HomeNoticeLocalNotificationType)type {
//    NSMutableArray *localNotificationMutablArray = [NSMutableArray array];
//    if ((type == HNLNTFetalMovementMorning) || (type == HNLNTFetalMovementAfternoon) || (type == HNLNTFetalMovementEvening)) {
//        [[self alloc] removeLocalNotificationWithType:type];
//
//        PushSetting *tmpPushSettingViewController = [[PushSetting alloc] init];
//        PushOption *tmpPushOption = [tmpPushSettingViewController initPushDataWithId:3];
//        if (!tmpPushOption.isOn) {
//            return;
//        }
//
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
//        NSInteger i = 1;
//        switch (type) {
//            case HNLNTFetalMovementMorning:
//            {
//                i = 1;
//            }
//                break;
//            case HNLNTFetalMovementAfternoon:
//            {
//                i = 7;
//            }
//                break;
//            case HNLNTFetalMovementEvening:
//            {
//                i = 13;
//            }
//                break;
//            default:
//                break;
//        }
//        NSDate *fireDate = [NSDate dateWithTimeIntervalSince1970:i*60*60];
//        notification.fireDate = fireDate;
//        notification.timeZone = [NSTimeZone defaultTimeZone];
//        notification.repeatInterval = NSCalendarUnitDay;
//        notification.alertBody = LANG(@"SYHNT_fetal_movement_local_notice_title");
//        notification.soundName =UILocalNotificationDefaultSoundName;
//        NSMutableDictionary *oneDict = [NSMutableDictionary dictionary];
//        [oneDict setObject:[NSNumber numberWithInteger:type] forKey:@"localNotificationType"];
//        [oneDict setObject:@"666" forKey:@"localNotificationId"];
//        [oneDict setObject:@"666" forKey:@"localNotificationDay"];
//        [oneDict setObject:LANG(@"SYHNT_fetal_movement_local_notice_title") forKey:@"localNotificationTitle"];
//        NSDictionary *userDict = oneDict;
//        notification.userInfo = userDict;
//        [localNotificationMutablArray addObject:notification];
//
//    } else if (type == HNLNTEveryDaySignIn){
//        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        NSMutableDictionary *oneDict = [NSMutableDictionary dictionary];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//        NSString *pregDateString = [dateFormatter stringFromDate:[NSDate date]];
//        [oneDict setObject:pregDateString forKey:@"localNotificationDay"];
//        pregDateString = [NSString stringWithFormat:@"%@ 12:00:00",pregDateString];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        localNotif.fireDate = [dateFormatter dateFromString:pregDateString];
//        localNotif.timeZone = [NSTimeZone localTimeZone];
//        localNotif.repeatInterval = NSCalendarUnitDay;
//        localNotif.soundName = UILocalNotificationDefaultSoundName;
//        localNotif.alertBody = LANG(@"SIVC_local_notification_alert_body");
//        localNotif.alertAction = LANG(@"check");
//        [oneDict setObject:[NSNumber numberWithInteger:type] forKey:@"localNotificationType"];
//        [oneDict setObject:@"777" forKey:@"localNotificationId"];
//        [oneDict setObject:LANG(@"SYHNT_fetal_movement_local_notice_title") forKey:@"localNotificationTitle"];
//        localNotif.userInfo = [oneDict copy];
//        [localNotificationMutablArray addObject:localNotif];
//    } else if (type == HNLNTDaDuMovie) {
//
//        [[self alloc] removeLocalNotificationWithType:type];
//
//        PushSetting *tmpPushSettingViewController = [[PushSetting alloc] init];
//        PushOption *tmpPushOption = [tmpPushSettingViewController initPushDataWithId:5];
//        if (!tmpPushOption.isOn) {
//            return;
//        }
//
//        UILocalNotification *localNotice = [[UILocalNotification alloc]init];
//        [localNotice setTimeZone:[NSTimeZone localTimeZone]];
//        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
//        [localNotice setAlertBody:LANG(@"DDDY_LocalNotification")];
//        [localNotice setAlertAction:LANG(@"check")];
//        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSDate *destDate= [dateformatter dateFromString:[dateformatter stringFromDate:[NSDate date]]];
//        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
//        NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//        comps = [calendar components:unitFlags fromDate:destDate];
//        NSInteger week = [comps weekday];
//        if (week == 6) {
//            week = 1;
//        }
//        NSString *dateString = [NSString stringWithFormat:@"%@ 19:30:00",[dateformatter stringFromDate:destDate]];
//        NSDate *date_ten = [dateformatter dateFromString:dateString];
//        [localNotice setFireDate:[date_ten dateByAddingTimeInterval:labs(6-week)*86400 ]];
//        [localNotice setSoundName:UILocalNotificationDefaultSoundName];
//
//        NSMutableDictionary *oneDict = [NSMutableDictionary dictionary];
//        [oneDict setObject:[NSNumber numberWithInteger:type] forKey:@"localNotificationType"];
//        [oneDict setObject:@"888" forKey:@"localNotificationId"];
//        [oneDict setObject:LANG(@"DDDY_LocalNotification") forKey:@"localNotificationTitle"];
//        localNotice.userInfo = [oneDict copy];
//
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNotice];
//
//    }else {
//        NSArray *dataArray = [NSArray arrayWithArray:[[self alloc] getLocalnotificationDataWithType:type]];
//        if ([dataArray count] > 0) {
//            [[self alloc] removeLocalNotificationWithType:type];
//        }
//        if (type == HNLNTPregnancyCheck) {
//            PushSetting *tmpPushSettingViewController = [[PushSetting alloc] init];
//            PushOption *tmpPushOption = [tmpPushSettingViewController initPushDataWithId:2];
//            if (!tmpPushOption.isOn) {
//                return;
//            }
//        }
//
//        for (NSDictionary *localNotificationDict in dataArray) {
//            NSInteger day = [[localNotificationDict objectForKey:@"localNotificationDay"] integerValue];
//            NSString *titleString = [NSString stringWithFormat:@"%@",[localNotificationDict objectForKey:@"localNotificationTitle"]];
//            if (day > 0 && titleString.length > 0 ) {
//                NSDate *pregDate = [CiUser sharedInstance].currentBaby.pregdate;
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//                NSString *pregDateString = [dateFormatter stringFromDate:pregDate];
//                switch (type) {
//                    case HNLNTPregnancyCheck:
//                    {
//                        pregDateString = [NSString stringWithFormat:@"%@ 10:00:00",pregDateString];
//                    }
//                        break;
//                    case HNLNTDailyKnowledge:
//                    {
//                        pregDateString = [NSString stringWithFormat:@"%@ 09:10:00",pregDateString];
//                    }
//                        break;
//                    default:
//                        break;
//                }
//                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                pregDate = [dateFormatter dateFromString:pregDateString];
//                NSDate *localNotificationTime = [pregDate dateByAddingTimeInterval:-((280 - day) * 86400)];
//                UILocalNotification *localNotif=[[UILocalNotification alloc] init];
//                [localNotif setTimeZone:[NSTimeZone localTimeZone]];
//                localNotif.alertBody = titleString;
//                localNotif.alertAction = LANG(@"check");
//                localNotif.fireDate = localNotificationTime;
////                NSLog(@"notification time : %@",localNotificationTime.toStringWithTime);
//
//                [localNotif setSoundName:UILocalNotificationDefaultSoundName];
//                localNotif.userInfo = [NSDictionary dictionaryWithDictionary:localNotificationDict];
//                [localNotificationMutablArray addObject:localNotif];
//            }
//        }
//    }
//    [localNotificationMutablArray addObjectsFromArray:[[UIApplication sharedApplication] scheduledLocalNotifications]];
//    if ([localNotificationMutablArray count]!=0) {
//        [UIApplication sharedApplication].scheduledLocalNotifications = [localNotificationMutablArray copy];
//    }
//}

+ (BOOL) updatePregnancyCheckWithCheckID:(NSInteger)checkID withDayTime:(NSInteger)day {
//    DataBaseEx *dateBase = [DataBaseEx initWithFileName:@"reminder" type:@"db"];
//    NSString *sql=[NSString stringWithFormat:@"update pregnancy_checkup set day='%ld' where id=%ld",(long)day,(long)checkID];
//    return [dateBase executeUpdate:sql];

    return NO;
}

//- (NSArray *) getLocalnotificationDataWithType:(HomeNoticeLocalNotificationType) type {
//    NSMutableArray *dataArray = [NSMutableArray array];
//    DataBaseEx *dateBase = [DataBaseEx initWithFileName:@"reminder" type:@"db"];
//    NSString *sqlString = @"";
//    switch (type) {
//        case HNLNTPregnancyCheck:
//            sqlString = @"select * FROM pregnancy_checkup";
//            break;
//        case HNLNTDailyKnowledge:
//        {
//            NSInteger leftDay = [[self class] getDayLeft];
//            leftDay = (leftDay > 279) ? 1 : (279 - leftDay);
//            sqlString = [NSString stringWithFormat:@"SELECT * FROM daily_knowledge where id > '%ld' and id <= '280'",(long)leftDay];
//        }
//            break;
//        default:
//            break;
//    }
//    FMResultSet *resultSet = [dateBase executeQuery:sqlString];
//    while ([resultSet next]) {
//        NSInteger localNotificationId = [resultSet intForColumn:@"id"];
//        NSInteger localNotificationDay = [resultSet intForColumn:@"day"];
//        NSString *reminderTitle = [resultSet stringForColumn:@"remind_title"];
//        NSInteger articleId = 0;
//        if (type == HNLNTDailyKnowledge) {
//            articleId = [resultSet intForColumn:@"article_id"];
//        }
//        if (localNotificationId > 0 && localNotificationDay > 0 && reminderTitle.length > 0) {
//            NSMutableDictionary *oneDict = [NSMutableDictionary dictionary];
//            [oneDict setObject:[NSNumber numberWithInteger:type] forKey:@"localNotificationType"];
//            [oneDict setObject:[NSNumber numberWithInteger:localNotificationId] forKey:@"localNotificationId"];
//            [oneDict setObject:[NSNumber numberWithInteger:localNotificationDay] forKey:@"localNotificationDay"];
//            [oneDict setObject:reminderTitle forKey:@"localNotificationTitle"];
//            if (type == HNLNTDailyKnowledge && articleId > 0) {
//                [oneDict setObject:[NSNumber numberWithInteger:articleId] forKey:@"localNotificationArticleId"];
//            }
//            [dataArray addObject:oneDict];
//        }
//    }
//    return [dataArray copy];
//}

+ (void) tabbarIsShow: (BOOL) show {
//    PregNoticeAppDelegate *app = (PregNoticeAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [app.tabView tabBarHidden:show withAnimation:NO];
}

+ (UILabel *) getStaticLabel {
    UILabel *tmpLabel = [[UILabel alloc] init];
//    [tmpLabel setFont:HOMENOTICE_FONT_12];
//    [tmpLabel setTextColor:HOMENOTICE_COLOR_153];
    [tmpLabel setNumberOfLines:1];
    [tmpLabel setTextAlignment:NSTextAlignmentCenter];
    return tmpLabel;
}

+ (void)addBackButton:(UIViewController*)controller{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 60, 37)];
    leftButton.showsTouchWhenHighlighted = YES;
    [leftButton setImage:[UIImage imageNamed:@"return_new"] forState:UIControlStateNormal];
    [leftButton setTitle:@"    " forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [leftButton addTarget:controller action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *returnback = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    [PregNoticeAppDelegate addLeftNavigationItem:controller item:returnback];
}

+ (void)addBlackBackButton:(UIViewController*)controller{
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 60, 37)];
    leftButton.showsTouchWhenHighlighted = YES;
    [leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [leftButton setTitle:@"    " forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [leftButton addTarget:controller action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *returnback = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item.width = 0;
    controller.navigationItem.leftBarButtonItems = @[item, returnback];
}

- (void) back {
    
}

+ (NSString *) getWeekdayStringWithPregDate: (NSString *)checkDateString withDateFormat:(NSString *)dateFormatString {
//    NSString *weekDay = LANG(@"monday");
//    NSArray *tmpArray = @[LANG(@"sunday"),LANG(@"monday"),LANG(@"tuesday"),LANG(@"wednesday"),LANG(@"thursday"),LANG(@"friday"),LANG(@"saturday")];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:dateFormatString];
//    NSDate *date = [formatter dateFromString:checkDateString];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    NSInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitWeekday |
//    NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
//    comps = [calendar components:unitFlags fromDate:date];
//    NSInteger weekday = [comps weekday];
//    if (weekday - 1 < [tmpArray count]) {
//        weekDay = [tmpArray objectAtIndex:(weekday-1)];
//    }
//    return weekDay;
    
    return @"aas";
    
}

+(NSDictionary *)getBabyWHAndIntroDetailDictionaryByWeek:(NSInteger)week withTable:(BOOL) table {
//    DataBaseEx *db =[DataBaseEx initWithFileName:@"birthbaby" type:@"sqlite"];
//    NSDictionary *data = [[NSDictionary alloc]init];
//    NSString *sql = table?@"select * from baby_wh where week=?":@"select * from baby_growth where week=?";
//    FMResultSet *rs =[db executeQuery:sql,[NSNumber numberWithInteger:week]];
//    while ([rs next]) {
//        if (table) {
//            data = [[NSDictionary alloc]initWithObjectsAndKeys:[rs stringForColumn:@"boy_h"],@"boy_h",[rs stringForColumn:@"boy_w"],@"boy_w",[rs stringForColumn:@"girl_h"],@"girl_h",[rs stringForColumn:@"girl_w"],@"girl_w", nil];
//        }else
//        {
//            data = [[NSDictionary alloc]initWithObjectsAndKeys:[rs stringForColumn:@"content"],@"content", nil];
//        }
//    };
//    return data;
    return @{};
}

// 在APP启动时就被调用，计算距离预产期时间
+(NSInteger) getDayLeft{
    
//    switch ([CiUser sharedInstance].currentBaby.status) {
//        case 0:
//            return 280;
//        case 1:
//        {
//            NSDate *pregDate = [NSDate new];
//            pregDate = [[CiUser sharedInstance].currentBaby getDate];
//            NSTimeInterval time = [pregDate timeIntervalSinceNow];
//            int day = time/86400;
//            return (day + 1);
//        }
//        default:
            return 0;
//    }
}

- (void) writeIntoLocalAblumWithSelectedImage :(UIImage *) image withUserName:(NSString *)userName{
//    image = [ImageClass watercolorBlockImage:image WithUserName:userName];
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    if(authStatus == AVAuthorizationStatusAuthorized) {
//        [self writeWithImage:image];
//    } else {
//        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//            if(granted) {
//                [self writeWithImage:image];
//            } else {
//                [self showNoAuthorization];
//            }
//        }];
//    }
}

-(void)showNoAuthorization{
    [SVProgressHUD showErrorWithStatus:@"孕期提醒无法访问您的相机"];
}

-(void) writeWithImage: (UIImage *) image {
//    if (image) {
//        __block NSString *groupName = LANG(@"pregNotice");
//        __weak ALAssetsLibrary *weakLibrary = self.library;
//        [weakLibrary writeImageDataToSavedPhotosAlbum:UIImagePNGRepresentation(image) metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
//            if (error) {
//                return ;
//            }
//            [weakLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//                if ([groupName isEqualToString:[group valueForProperty:ALAssetsGroupPropertyName]]) {
//                    [weakLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
//                        [group addAsset:asset];
//
//                    } failureBlock:nil];
//                } else {
//                    [weakLibrary addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *newGroup) {
//                        [weakLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
//                            [newGroup addAsset:asset];
//
//                        } failureBlock:nil];
//                    } failureBlock:nil];
//                }
//            } failureBlock:nil];
//        }];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@%@",LANG(@"save"),LANG(@"success")]];
//        });
//    }

}

+ (void)showLoginViewControllerWithNavigationController:(UIViewController *)viewController {
//    [LoginPregNoticeViewController showLoginPanelWithController:viewController];
}

+ (void)addClickCountWithName:(NSString *)eventName {
//    [MobClick event:eventName];
}

+ (BOOL)isUploadFileDataTodayNow {
//    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
//    NSInteger lastDayNumber = timeInterval / 86400;
//    lastDayNumber = lastDayNumber % 10;
//    NSString *total_id = [NSString stringWithFormat:@"%@",[[User shareInstance] total_userId]];
//    if (![NSString isBlankString:total_id]) {
//        NSInteger lastUserIdNumber = [[total_id substringWithRange:NSMakeRange(total_id.length - 1, 1)] integerValue];
//        return (lastDayNumber == lastUserIdNumber);
//    }
    return NO;
}

+ (NSString *) getMacAddress {
//    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
//    id info = nil;
//    for (NSString *ifnam in ifs) {
//        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef)ifnam);
//        if (info && [info count]) {
//            break;
//        }
//    }
//    NSDictionary *dic = (NSDictionary *)info;
//    NSString *ssid = [[dic objectForKey:@"SSID"] lowercaseString];
//    NSString *bssid = [dic objectForKey:@"BSSID"];
//    NSLog(@"ssid : %@ ,bssid : %@",ssid,bssid);
//    return bssid;
    return @"12";
}

+ (NSString *) date2Str:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter stringFromDate:date];
}

+ (NSString *) dateTime2Str:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter stringFromDate:date];
}

+ (NSDate *) str2Date:(NSString *)str{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter dateFromString:str];
}

+ (NSDate *) str2DateTime:(NSString *)str{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter dateFromString:str];
}

+ (NSString *)getServerRequestTokenString {
//    if ([CiUser sharedInstance].jwtToken.length > 0) {
//        return [NSString stringWithFormat:@"bearer%@",[CiUser sharedInstance].jwtToken];
//    }
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"modifyWithServerRequestData"]) {
//        NSDictionary *tmpDict = [NSDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"modifyWithServerRequestData"]];
//        if([[tmpDict allKeys] containsObject:@"token"] && [tmpDict objectForKey:@"token"]) {
//            return [NSString stringWithFormat:@"bearer%@",[tmpDict objectForKey:@"token"]];
//        }
//    }
//    if ([SYStoreDataToLocal getPreferenceValueWithKey:@"modifyWithServerRequestTokenValue"]) {
//        return [NSString stringWithFormat:@"bearer%@",[SYStoreDataToLocal getPreferenceValueWithKey:@"modifyWithServerRequestTokenValue"]];
//    }
    return @"bearer000";
}


+ (void) checkBabyId: (NSString *) babyId {
    
//    if ([NSString isBlankString:babyId]) {
//        return ;
//    }
//
//    NSString *total_id = [NSString stringWithFormat:@"%@",[[User shareInstance] total_userId]];
//    NSString *key = [NSString stringWithFormat:@"%@_baby_id",total_id];
//
//    if ([SYStoreDataToLocal getPreferenceValueWithKey:key]) {
//        NSString *storeBabyId = [NSString stringWithFormat:@"%@",[SYStoreDataToLocal getPreferenceValueWithKey:key]];
//        if (![storeBabyId isEqualToString:babyId]) {
//            [SYStoreDataToLocal storeByPreferenceWithKey:key WithValue:babyId];
//        }
//    } else {
//        [SYStoreDataToLocal storeByPreferenceWithKey:key WithValue:babyId];
//    }
//
//    [User shareInstance].babyId = babyId;
}

+ (NSString *)getBabyAgeStringWithNowDate:(NSDate *)nowDate {
    
//    NSDate *date1 = [CiUser sharedInstance].currentBaby.getDate;
//    NSDate *date = nowDate;
//    NSCalendar * calendar = [NSCalendar currentCalendar];
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ;
//    NSDateComponents * components = [calendar components:unit fromDate:date1 toDate:date options:0];
//
//    NSString *tmpString = @"";
//    if (components.year > 0) {
//        tmpString = [NSString stringWithFormat:@"%ld%@",components.year,LANG(@"old")];
//    }
//    if (components.month > 0) {
//        tmpString = [NSString stringWithFormat:@"%@%ld%@", tmpString, components.month,LANG(@"month")];
//    }
//    if (components.day >= 0 ) {
//        tmpString = [NSString stringWithFormat:@"%@%ld%@", tmpString, components.day + 1,LANG(@"day")];
//    }
//    return tmpString;
    return @"1";
    
}

@end
