//
//  FirstViewController.m
//  RSSReader
//
//  Created by LJ on 15/7/27.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "FirstViewController.h" 
#import "SecondViewController.h"
#import "OPMLParser.h"
#import "OPMLItem.h"

@interface FirstViewController ()<OPMLParserDelegate>{
    NSArray *_blogArr;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    OPMLParser *opml = [[OPMLParser alloc]initWithOPMLURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"blogcn" ofType:@"opml"]]];
    opml.delegate = self;
    [opml parser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _blogArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    OPMLItem *item = (OPMLItem *)_blogArr[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tabBarController.selectedIndex = 1;
    NSString *title = ((OPMLItem *)_blogArr[indexPath.row]).title;
    NSString *xmlUrl = ((OPMLItem *)_blogArr[indexPath.row]).xmlUrl;
    SecondViewController *selectedController = (SecondViewController *)((UINavigationController *)self.tabBarController.selectedViewController).viewControllers[0];
    selectedController.title = title;
    selectedController.urlStr = xmlUrl;
    selectedController.firstLoad = YES;
}


#pragma mark - OPMLParser delegate
- (void)opmlParser:(OPMLParser *)parser didFinishedWithItemAttributes:(NSArray *)attributes{
    _blogArr = attributes;
    [self.tableView reloadData];
}


@end
