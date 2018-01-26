//
//  PCDSelectViewController.m
//  UniteRoute
//
//  Created by zz on 19/01/2018.
//  Copyright © 2018 Klaus. All rights reserved.
//

#import "PCDSelectViewController.h"
#import "ArrayDataSource.h"
#import "CityTableViewCell.h"
//#import "UIView+ZYExtention.h"
@interface PCDSelectViewController ()<UITableViewDelegate>
{
    UILabel* _currentLocLabel;
    UIImageView* _refreshTag;
}
@property (nonatomic,retain)UITableView* tableView;
@property (nonatomic,retain)ArrayDataSource* dataSource;
@property (nonatomic,retain)NSMutableDictionary<Province*,NSArray<NSArray<City*>*>*>* data;



@property (nonatomic,retain)NSArray<Province*>* sectionItems;
@property (nonatomic,retain)NSMutableArray<NSArray<City*>*>* values;
@property (nonatomic,retain)Province *province;
@property (nonatomic,retain)City *city;
@property (nonatomic,retain)Area *area;
@end

static NSString* CellID = @"CityCellIdentifier";
static NSString* ProvinceHeaderID = @"ProvinceSectionHeader";
@implementation PCDSelectViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self setupNav];
    [self setupView];
    [self loadData];
}
#pragma mark- Private For View Creaating
- (void)initialize{
    ///获取数据
    self.data = @{}.mutableCopy;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)loadData {
    NSData* jsonData = [[NSData alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Province-City-District" ofType:@"json"]];
    NSError* error;
    NSArray* jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    NSMutableArray<Province*>* tempArr = [NSMutableArray array];
    for (NSDictionary* provinceDic in jsonObject) {
        Province* province = [[Province alloc] initWithDic:provinceDic];
        [tempArr addObject:province];
    }
    
    
    
    NSArray* sortedProvinceArr = [tempArr sortedArrayUsingComparator:^NSComparisonResult(Province*  _Nonnull obj1, Province*  _Nonnull obj2) {
        return [obj1.name localizedCompare:obj2.name] == NSOrderedDescending;
    }];
    self.values = [NSMutableArray arrayWithCapacity:sortedProvinceArr.count];
    for (int i = 0; i<sortedProvinceArr.count; i ++) {
        [self.values addObject:@[]];
    }
    self.sectionItems = sortedProvinceArr;
    [self.data setObject:sortedProvinceArr forKey:@"key"];
    [self.data setObject:self.values forKey:@"value"];
    [self.tableView reloadData];
}
- (void)setupNav{
    self.title = @"常驻地区";
}

- (void)setupView{
    [self setupTable];
    [self setupTableHeader];
}

- (void)setupTable {
    UITableView* table = [[UITableView alloc]initWithFrame:kScreenBounds style:UITableViewStylePlain];
    table.backgroundColor = kBGColor;
    table.delegate = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = table;
    table.tableFooterView = [[UIView alloc]init];
    table.sectionIndexBackgroundColor = [UIColor clearColor];
    [table registerClass:[CityTableViewCell class] forCellReuseIdentifier:CellID];
    [table registerClass:[ProvinceSectionHeader class] forHeaderFooterViewReuseIdentifier:ProvinceHeaderID];
    [self.view addSubview:table];
    [self configDataSource];
}

- (void)configDataSource {
    kWeakSelf(weakSelf);
    ArrayDataSource* dataSource = [[ArrayDataSource alloc]initWithData:self.data dataType:KSDataTypeDictionary cellIdentifier:CellID configureCellBlock:^(CityTableViewCell* cell, City* item, NSIndexPath *indexPath) {
        cell.city = item;
        [cell configureTapBlock:^(Area *area, City *city) {
            weakSelf.area = area;
            weakSelf.city = city;
            weakSelf.province = [weakSelf.sectionItems objectAtIndex:indexPath.section];
            if ([weakSelf.delegate respondsToSelector:@selector(didSelect:city:area:)]) {
                [weakSelf.delegate didSelect:weakSelf.province city:weakSelf.city area:weakSelf.area];
            }
            [weakSelf.navigationController popViewControllerAnimated:true];
        }];
    }];
    self.dataSource = dataSource;
    self.dataSource.needSectionToggle = YES;
    self.dataSource.sectionOpenStyle = SectionOpenStyleSingle;
    self.dataSource.customSectionHeader = YES;
    self.tableView.dataSource = self.dataSource;
}

- (void)setupTableHeader {
    UIView* headerView = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, kScreenWidth, 30 + 44))];
    UIView* noteView = [[UIView alloc]init];
    noteView.backgroundColor = [UIColor colorWithHexString:@"#f8c377"];
    UIView* locateView = [[UIView alloc]init];
    [headerView addSubview:noteView];
    [headerView addSubview:locateView];
    
    {
        noteView.sd_layout
        .leftEqualToView(headerView)
        .rightEqualToView(headerView)
        .topEqualToView(headerView)
        .heightIs(30);
        
        locateView.sd_layout
        .topSpaceToView(noteView, 0)
        .leftEqualToView(headerView)
        .rightEqualToView(headerView)
        .heightIs(44);
    }
    
    UILabel* noteLabel = [UILabel labelWithTextColor:kDarkGray font:KSUser.twelveFont];
    
    noteLabel.textAlignment = NSTextAlignmentCenter;
    noteLabel.text = @"您的一切业务都由常驻地区子公司进行处理，请正确填写";
    [noteView addSubview:noteLabel];
    noteLabel.sd_layout
    .leftSpaceToView(noteView, kEdgeWidth)
    .rightSpaceToView(noteView, kEdgeWidth)
    .centerYEqualToView(noteView)
    .autoHeightRatio(0);
    [noteLabel setMaxNumberOfLinesToShow:2];
    
    _currentLocLabel = [UILabel labelWithTextColor:kBlackColor font:KSUser.fourteenFont];
    _currentLocLabel.text = @"选择当前定位地区：";
    _refreshTag = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sx"]];
    _refreshTag.hidden = true;
    [locateView addSubview:_currentLocLabel];
    [locateView addSubview:_refreshTag];
    
    _currentLocLabel.sd_layout
    .leftSpaceToView(locateView, kEdgeWidth)
    .centerYEqualToView(locateView)
    .autoHeightRatio(0);
    [_currentLocLabel setSingleLineAutoResizeWithMaxWidth:kScreenWidth - 2*kEdgeWidth - 20];
    
    _refreshTag.sd_layout
    .widthIs(20)
    .heightIs(20)
    .centerYEqualToView(locateView)
    .leftSpaceToView(_currentLocLabel, kEdgeWidth);
    
    
    UITapGestureRecognizer* singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseCurrentLocation)];
    [locateView addGestureRecognizer:singleTapGesture];
    self.tableView.tableHeaderView = headerView;
}

- (void)chooseCurrentLocation {
    
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    KSLog(@"Memory Warning!");
}

#pragma mark *******************UITableViewDelegate*******************
#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    City* city = [[self.values objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return [tableView cellHeightForIndexPath:indexPath model:city keyPath:@"city" cellClass:[CityTableViewCell class] contentViewWidth:kScreenWidth];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ProvinceSectionHeader* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ProvinceHeaderID];
    Province* province = [self.sectionItems objectAtIndex:section];
    headerView.province = province;
    kWeakSelf(weakSelf);
    [headerView configureToggleBlock:^(Province *province,BOOL open) {
        if ([weakSelf.values objectAtIndex:section].count == 0) {
            [weakSelf.values replaceObjectAtIndex:section withObject:[province.cities sortedArrayUsingComparator:^NSComparisonResult(City*  _Nonnull obj1, City*  _Nonnull obj2) {
                return [obj1.name localizedCompare:obj2.name] == NSOrderedDescending;
            }]];
        }
        province.selected = open;
        
        //将当前打开区下面一区的topLine显示或隐藏
        if (weakSelf.province) {
            NSInteger idx = [weakSelf.sectionItems indexOfObject:weakSelf.province];
            if (idx < weakSelf.sectionItems.count - 1) {
                Province* tempProvince = [weakSelf.sectionItems objectAtIndex:idx + 1];
                tempProvince.showTopLine = !open;
            }
        }
        if (open) {
            if (weakSelf.dataSource.sectionOpenStyle == SectionOpenStyleSingle) {//单区打开时需要关闭上一打开区
                if (weakSelf.province != province) {
                    if (weakSelf.province) {
                        weakSelf.province.selected = NO;
                    }
                }
            }
            weakSelf.province = province;
        }else {
            NSArray* openedSections = [weakSelf.sectionItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.selected = 1"]];
            if (weakSelf.dataSource.sectionOpenStyle == SectionOpenStyleSingle || openedSections.count == 0) {
                weakSelf.province = nil;
            }
        }
        
        
        //打开或隐藏当前区 //真正控制行的显示
        [weakSelf.dataSource open:open section:section];

        //让即将打开区下面一区的topLine显示或隐藏
        if (section < weakSelf.sectionItems.count - 1) {
            Province* tempProvince = [weakSelf.sectionItems objectAtIndex:section + 1];
            tempProvince.showTopLine = open;
        }
        [weakSelf.tableView reloadData];
        
        if (open) {
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:true];
        }
        
    }];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    Province* tempProvince = [self.sectionItems objectAtIndex:section];
    return tempProvince.showTopLine?kCellHeight + 2:kCellHeight + 1;
}

@end

@interface ProvinceSectionHeader ()
{
    UIView* _bottomLine;
    UIView* _topLine;
}
@property (nonatomic,copy)ToggleBlock toggleBlock;
@property (nonatomic,retain)UILabel* titleLabel;
@property (nonatomic,retain)UIButton* toggleBtn;
@end

@implementation ProvinceSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kWhiteColor;
        [self createView];
    }
    return self;
}

- (void)createView {
    UILabel* titleLabel = [UILabel labelWithTextColor:kBlackColor font:KSUser.fourteenFont];
    self.titleLabel = titleLabel;
    UIButton* closureBtn = [UIButton buttonAddTarget:self action:@selector(toggle:) withTitle:nil imageNamed:@"up"];
    self.toggleBtn = closureBtn;
    [closureBtn setImage:[UIImage imageNamed:@"dow"] forState:UIControlStateSelected];
    {
        closureBtn.imageView.sd_layout
        .rightSpaceToView(closureBtn,kEdgeWidth)
        .centerYEqualToView(closureBtn)
        .heightIs(16)
        .widthIs(16);
    }
    [self.contentView sd_addSubviews:@[titleLabel,closureBtn]];
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,kEdgeWidth)
    .centerYEqualToView(self.contentView)
    .autoHeightRatio(0);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
    
    closureBtn.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .centerYEqualToView(self.contentView)
    .heightIs(kCellHeight);
    
    _topLine = [UIView addSeparatorLineBelow:NO view:closureBtn toParentView:self.contentView margin:0 leftMargin:kEdgeWidth rightMargin:0 height:1];
    _topLine.backgroundColor = kBGColor;
    _bottomLine = [UIView addSeparatorLineBelow:YES view:closureBtn toParentView:self.contentView margin:0 leftMargin:kEdgeWidth rightMargin:0 height:1];
    _bottomLine.backgroundColor = kBGColor;
}

- (void)toggle:(UIButton*)sender{
    if (self.toggleBlock) {
        self.toggleBlock(self.province,!sender.selected);
    }
}

- (void)showTopLine{
    _topLine.sd_layout.heightIs(1);
    [_topLine updateLayout];
}

- (void)hideTopLine{
    _topLine.sd_layout.heightIs(0);
    [_topLine updateLayout];
}

- (void)setProvince:(Province *)province {
    _province = province;
    self.toggleBtn.selected = province.selected;//解决复用问题
    self.titleLabel.text = province.name;
    if (province.showTopLine) {
        [self showTopLine];
    }else{
        [self hideTopLine];
    }
}


- (void)configureToggleBlock:(ToggleBlock)block {
    self.toggleBlock = block;
}


@end


