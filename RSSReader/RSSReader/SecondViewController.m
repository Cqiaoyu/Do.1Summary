//
//  SecondViewController.m
//  RSSReader
//
//  Created by LJ on 15/7/27.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "SecondViewController.h"
#import "ArticleDetailViewController.h"
#import <MWFeedParser/MWFeedParser.h>

@interface SecondViewController ()<MWFeedParserDelegate,NSXMLParserDelegate>{
    MWFeedParser *_mwparser;
    NSXMLParser *_parser;
    NSURL *_url;
    NSMutableArray *_articleArr;
    NSIndexPath *_selecedIndexPath;
}

@end

@implementation SecondViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.title = self.tabBarController.selectedViewController.title;
    _url = [NSURL URLWithString:_urlStr];
    if (!_articleArr) {
        _articleArr = [NSMutableArray array];
    }
    if (_firstLoad) {
        _firstLoad = NO;
        [_articleArr removeAllObjects];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _mwparser = [[MWFeedParser alloc]initWithFeedURL:_url];
            _mwparser.delegate = self;
            [_mwparser parse];
            
        });
    }
}
- (void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ArticleDetailViewController *article = (ArticleDetailViewController *)segue.destinationViewController;
    article.urlStr = ((MWFeedItem *)_articleArr[_selecedIndexPath.row]).link;
}

#pragma mark - tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _articleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    MWFeedItem *item = ((MWFeedItem *)_articleArr[indexPath.row]);
    cell.textLabel.text = item.title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selecedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"articleDetail" sender:nil];
}

#pragma mark - xmlparser delegate
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    
}


#pragma mark - feedParser delegate
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error{
    
}
- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info{
    NSLog(@"%@,%@,%@,%@",info.title,info.link,info.summary,info.url);
}
- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item{
    NSLog(@"%@,%@",item.title,item.link);
    [_articleArr addObject:item];
}
- (void)feedParserDidFinish:(MWFeedParser *)parser{
    [parser stopParsing];
    [self.tableView reloadData];
    
}
- (void)feedParserDidStart:(MWFeedParser *)parser{
    
}

@end
