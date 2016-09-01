//
//  QcMessageCell.m
//  160830_qq
//
//  Created by QChris on 16/9/1.
//  Copyright © 2016年 Chrisqc. All rights reserved.
//

#import "QcMessageCell.h"
#import "QcMessage.h"
#import "QcMessageFrame.h"

@interface QcMessageCell ()

@property (nonatomic,weak) UILabel *timeView;
@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UIButton *textView;

@end

@implementation QcMessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"id";
    QcMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[QcMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1. time
        UILabel *timeView = [[UILabel alloc] init];
        timeView.textAlignment = NSTextAlignmentCenter;
        timeView.textColor = [UIColor grayColor];
        timeView.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:timeView];
        self.timeView = timeView;
        
        //2 icon
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        //3.text
        UIButton *textView = [[UIButton alloc]init];
        textView.titleLabel.numberOfLines = 0;
        textView.titleLabel.font = [UIFont systemFontOfSize:13];
        textView.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [textView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setMessageFrame:(QcMessageFrame *)messageFrame {
    _messageFrame = messageFrame;
    
    QcMessage *message = messageFrame.message;
    
    //1.time
    self.timeView.text = message.time;
    self.timeView.frame = messageFrame.timeF;
    
    //2.icon
    NSString *icon = (message.type == 0) ? @"me": @"other";
    self.iconView.image = [UIImage imageNamed:icon];
    self.iconView.frame = messageFrame.iconF;;
    
    //3.text
    [self.textView setTitle:message.text forState:UIControlStateNormal];
    self.textView.frame = messageFrame.textF;
}

@end
