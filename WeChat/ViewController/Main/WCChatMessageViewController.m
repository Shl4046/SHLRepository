//
//  WCChatMessageViewController.m
//  WeChat
//
//  Created by 宋红亮 on 15/9/15.
//  Copyright © 2015年 Song. All rights reserved.
//

#import "WCChatMessageViewController.h"
#import "WCMessageCell.h"
@interface WCChatMessageViewController () <NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController *_resultsController;
}

@end

@implementation WCChatMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self loadMessage];
}

- (void)loadMessage {
    
    // 使用CoreData获取数据
    // 1. 上下文【关联到数据库XMPPRoster.sqlite】
    NSManagedObjectContext *context = [WCXMPPTool sharedWCXMPPTool].xmppMessageArchivingCoreDataStorage.mainThreadManagedObjectContext;
     NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:context];
    // 2. FetchRequest【查哪张表】
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    // 3. 设置过滤和排序
    // 过滤当前登录用户的好友
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bareJidStr = %@", _friend.jidStr];
    request.predicate = predicate;
    
    // 排序
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
//    request.sortDescriptors = @[sort];
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors = @[sort];
    // 4. 执行请求获取数据
    _resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                             managedObjectContext:context
                                                               sectionNameKeyPath:nil
                                                                        cacheName:nil];
    _resultsController.delegate = self;
    
    NSError *error = nil;
    [_resultsController performFetch:&error];
    if (error) {
        WCLog(@"%@", error);
    }
}

#pragma mark - NSFetchedResultsControllerDelegate 方法

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _resultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"messageCell";
    WCMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    XMPPMessageArchiving_Message_CoreDataObject* message =_resultsController.fetchedObjects[indexPath.row];
    
    if (_friend.photo) {
        
        cell.iconView.image = _friend.photo;
    }else{
        cell.iconView.image = [UIImage imageNamed:@"123.jpg"];
    }
    cell.messagedata = message;
    return cell;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        
//        XMPPUserCoreDataStorageObject *friend = _resultsController.fetchedObjects[indexPath.row];
//        [[WCXMPPTool sharedWCXMPPTool].roster removeUser:friend.jid];
//    }
//}

@end
