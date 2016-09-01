//
//  QcMessageCell.h
//  160830_qq
//
//  Created by QChris on 16/9/1.
//  Copyright © 2016年 Chrisqc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QcMessageFrame;

@interface QcMessageCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) QcMessageFrame *messageFrame;

@end
