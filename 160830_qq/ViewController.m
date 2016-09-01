//
//  ViewController.m
//  160830_qq
//
//  Created by QChris on 16/8/30.
//  Copyright © 2016年 Chrisqc. All rights reserved.
//

#import "ViewController.h"
#import "QcMessageFrame.h"
#import "QcMessage.h"
#import "QcMessageCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *messageArray;

@end

@implementation ViewController

- (NSArray *)messageArray {
    if (_messageArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            QcMessage *message = [QcMessage QcMessageWithDict:dict];
            
            QcMessageFrame *messageframe = [[QcMessageFrame alloc] init];
            messageframe.message = message;
            [array addObject:messageframe];
        }
        _messageArray = array;
    }
    return _messageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark --实现数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QcMessageCell *cell = [QcMessageCell cellWithTableView:tableView];
    
    cell.messageFrame = self.messageArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QcMessageFrame *mf = self.messageArray[indexPath.row];
    
    return mf.cellHeight;
}

@end
