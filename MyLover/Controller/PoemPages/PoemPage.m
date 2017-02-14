//
//  PoemPage.m
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import "PoemPage.h"
#import "CoreDataManager.h"
#import "Poem.h"
#import "BRFlabbyTableManager.h"
#import "BRFlabbyTableViewCell.h"
#import "PoemInfoPage.h"
#import "AddNewPoemPage.h"
#import "INSSearchBar.h"
static NSString *const kMineCellIdentifier = @"poemCellIndentifier";
@interface PoemPage ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,BRFlabbyTableManagerDelegate,INSSearchBarDelegate>

@property (nonatomic, strong) UITableView           * tableView;
@property (nonatomic, strong) INSSearchBar          * searchBar;
@property (nonatomic, strong) NSMutableArray        * dataArr;
@property (nonatomic, strong) NSMutableArray        * searchArr;
@property (nonatomic, strong) CoreDataManager       * manager;
@property (nonatomic, strong) BRFlabbyTableManager  * flabbyTableManager;
@property (nonatomic, strong) NSArray               * cellColors;
@property (nonatomic, strong) CAGradientLayer       * gradientLayer;
@end

@implementation PoemPage

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArr = [[NSMutableArray alloc] init];
        _manager = [CoreDataManager sharedCoreDataManager];
        _cellColors = @[[UIColor colorWithRed:27.0f/255.0f green:191.0f/255.0f blue:161.0f/255.0f alpha:0.7f],
                        [UIColor colorWithRed:126.0f/255.0f green:113.0f/255.0f blue:128.0f/255.0f alpha:0.7f],
                        [UIColor colorWithRed:255.0f/255.0f green:79.0f/255.0f blue:75.0f/255.0f alpha:0.7f],
                        [UIColor colorWithRed:150.0f/255.0f green:214.0f/255.0f blue:217.0f/255.0f alpha:0.7f],
                        [UIColor colorWithRed:230.0f/255.0f green:213.0f/255.0f blue:143.0f/255.0f alpha:0.7f]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeColorView];
    [self loadNaviBar];
    [self requestDataFromCoreData];

    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
    headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.searchBar = [[INSSearchBar alloc] initWithFrame:CGRectMake(20.0, 3.0, 44.0, 34.0)];
    self.searchBar.delegate = self;
    [headView addSubview:self.searchBar];
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"button_type_add"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"button_type_add"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(clickAdd:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.equalTo(headView).with.offset(-20);
         make.right.equalTo(headView).with.offset(-12);
         make.width.mas_equalTo(@38);
         make.height.mas_equalTo(@40);

     }];

    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = headView;
    _tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-60);
        make.top.equalTo(self.view.mas_top).with.offset(66);
    }];

    _flabbyTableManager = [[BRFlabbyTableManager alloc] initWithTableView:_tableView];
    [_flabbyTableManager setDelegate:self];
    [_tableView registerClass:[BRFlabbyTableViewCell class] forCellReuseIdentifier:kMineCellIdentifier];

}
- (void) loadNaviBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(clickAdd:)];
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identifier = @"poemtablecell";
    BRFlabbyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( cell == nil )
    {
        cell =[[ BRFlabbyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setFlabby:YES];
        [cell setLongPressAnimated:YES];
        [cell setFlabbyColor:[self colorForIndexPath:indexPath]];
        Poem * poem = [[Poem alloc] init];
        poem = [_dataArr objectAtIndex:indexPath.row];
        cell.nameLab.text = poem.name;
        cell.authLab.text = poem.author;
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString * timestr = [dateFormatter stringFromDate:poem.time];
        cell.timeLab.text = timestr;
        cell.backImgView.image = [UIImage imageNamed:@"ceshi.jpg"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Poem * poem = [_dataArr objectAtIndex:indexPath.row];
    PoemInfoPage * infopage = [[PoemInfoPage alloc] init];
    infopage.poem = poem;
    [self.navigationController pushViewController:infopage animated:YES];
}
- (void) clickAdd:(id)sender
{
    AddNewPoemPage * add = [[AddNewPoemPage alloc] init];
    add.title = @"新增";
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"zoomyIn";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:add animated:NO completion:nil];
}
#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}

#pragma mark - BRFlabbyTableManagerDelegate methods

- (UIColor *)flabbyTableManager:(BRFlabbyTableManager *)tableManager flabbyColorForIndexPath:(NSIndexPath *)indexPath
{
    return [self colorForIndexPath:indexPath];
}

#pragma mark - Miscellenanious
- (UIColor *)colorForIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    return _cellColors[row%_cellColors.count];
}

#pragma mark view UI
-(void)changeColorView
{
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.gradientLayer];
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    NSArray * c = [[NSArray alloc] initWithObjects:RGB(29, 180, 129),RGB(30, 155, 235), nil];
    UIColor * top = [c objectAtIndex:1];
    UIColor * bottom = [c objectAtIndex:0];
    self.gradientLayer.colors = @[(__bridge id)top.CGColor,
                                  (__bridge id)bottom.CGColor];
    self.gradientLayer.locations = @[@(0.3f) ,@(1.0f)];
}
#pragma mark searchBar
- (CGRect)destinationFrameForSearchBar:(INSSearchBar *)searchBar
{
    return CGRectMake(20.0, 3.0, CGRectGetWidth(self.view.bounds) - 80.0, 34.0);
}
- (void)searchBar:(INSSearchBar *)searchBar willStartTransitioningToState:(INSSearchBarState)destinationState
{
    // Do whatever you deem necessary.
}

- (void)searchBar:(INSSearchBar *)searchBar didEndTransitioningFromState:(INSSearchBarState)previousState
{
    // Do whatever you deem necessary.
}

- (void)searchBarDidTapReturn:(INSSearchBar *)searchBar
{
    NSString * searchStr = searchBar.searchField.text;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    for (int i = 0 ; i < _dataArr.count ; i ++ )
    {
        Poem * info = [_dataArr objectAtIndex:i];
        NSString * timestr = [dateFormatter stringFromDate:info.time];
        if ([searchStr rangeOfString:timestr].location != NSNotFound)
        {

        }
        if ([searchStr rangeOfString:info.tag].location != NSNotFound)
        {

        }
        if ([searchStr rangeOfString:info.name].location != NSNotFound)
        {

        }
        if ([searchStr rangeOfString:info.author].location != NSNotFound)
        {

        }
    }
}

- (void)searchBarTextDidChange:(INSSearchBar *)searchBar
{
    // Do whatever you deem necessary.
    // Access the text from the search bar like searchBar.searchField.text
}

#pragma mark Data
-(void)requestDataFromCoreData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Poem" inManagedObjectContext:_manager.managedObjContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    NSError *error = nil;
    NSArray *fetchResult = [_manager.managedObjContext executeFetchRequest:request error:&error];
    if (!fetchResult)
    {
        NSLog(@"error:%@,%@",error,[error userInfo]);
    }
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:fetchResult];
    NSLog(@"%@",self.dataArr);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
@end
