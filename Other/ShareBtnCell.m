//
//  ShareBtnCell.m
//  PregNotice
//
//  Created by xwl on 15/10/8.
//
//

#import "ShareBtnCell.h"

#define ScreenWith ([[UIScreen mainScreen] bounds].size.width)

@implementation ShareBtnCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
     
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWith/8 - 25, ScreenWith/8 - 25 - 10, 50, 50)];
        [self addSubview:self.imgView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50 + (ScreenWith/8 - 25), frame.size.width, 12)];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)loadData:(ShareBtnData *)cellData
{    
    [self.imgView setImage:[UIImage imageNamed:cellData.imgName]];
    self.titleLabel.text = cellData.title;
}

@end
