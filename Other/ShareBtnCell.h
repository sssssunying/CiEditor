//
//  ShareBtnCell.h
//  PregNotice
//
//  Created by xwl on 15/10/8.
//
//

#import <UIKit/UIKit.h>
#import "ShareBtnData.h"

static NSString *ShareBtnCellIdentifier = @"ShareBtnCellIdentifier";

@interface ShareBtnCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *titleLabel;

- (void)loadData:(ShareBtnData *)cellData;

@end
