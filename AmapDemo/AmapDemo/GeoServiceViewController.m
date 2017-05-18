//
//  GeoServiceViewController.m
//  UniteRoute
//
//  Created by zz on 2017/3/31.
//  Copyright © 2017年 Klaus. All rights reserved.
//

#import "GeoServiceViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>

#import "ArrayDataSource.h"
//#import "UIView+ZYExtention.h"

static NSString* TipCellID = @"TipCell";
@interface GeoServiceViewController ()<MAMapViewDelegate,UISearchBarDelegate,AMapSearchDelegate,UITableViewDelegate,UIScrollViewDelegate>
{
    
}
@property (nonatomic,retain)MAMapView* mapView;
@property (nonatomic,retain)UISearchBar* searchBar;
@property (nonatomic,retain)AMapSearchAPI* searchApi;
@property (nonatomic,retain)AMapReGeocode *regeocode;
@property (nonatomic,retain)CLPlacemark* userPlaceMark;
@property (nonatomic,retain)CLLocation* userLocation;
@property (nonatomic,retain)CLLocation* searchLocation;

@property  (nonatomic,retain) UIView* footerView;
@property (nonatomic,retain) IBOutlet UITableView* tipsTable;
@property (nonatomic,retain)ArrayDataSource* dataSource;
@property (nonatomic,retain)NSArray<AMapTip*>* data;

@property (nonatomic,retain) MAAnnotationView* currentAnnotationView;
@property (nonatomic,retain)NSMutableArray<MAPointAnnotation*>* annotaionsArr;
@property (nonatomic,retain)NSArray<AMapPOI*>* pois;

@property (nonatomic,retain)UILabel* titleLabel;
@property (nonatomic,retain)UILabel* subTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addrLabel;
@property (strong, nonatomic) IBOutlet UIImageView *navIconIV;
@property (strong, nonatomic) IBOutlet UILabel *navTitleLabel;

@end

@implementation GeoServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self setupNav];
    [self setupView];
    [self configTable];
}
#pragma mark- Private For View Creaating
- (void)initialize{
    self.searchApi = [[AMapSearchAPI alloc]init];
    self.searchApi.delegate = self;
    self.annotaionsArr = @[].mutableCopy;
}
- (void)setupNav{
    UISearchBar* searchBar = [UISearchBar new];
    self.searchBar = searchBar;
    searchBar.placeholder = self.placeHolder;
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
}




- (void)setupView{
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0,NAV_H + 20 , DEVICE_WIDTH, DEVICE_HEIGHT - NAV_H - 20)];
    [self.view addSubview:self.mapView];
    
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.delegate = self;
    self.mapView.zoomLevel = 15;
}

- (void)configTable{
    [self.tipsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:TipCellID];
    self.tipsTable.tableFooterView = [[UIView alloc]init];
}

- (void)configDataSource{
    self.dataSource = [[ArrayDataSource alloc]initWithData:self.data dataType:KSDataTypeArray cellIdentifier:TipCellID configureCellBlock:^(UITableViewCell* cell, AMapTip* item, NSIndexPath *indexPath) {
        cell.textLabel.text = item.name;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }];
    _tipsTable.dataSource = self.dataSource;
}

- (CGFloat)labelHeightWithAttributes:(NSDictionary*)attrDic line:(NSUInteger)lineNum{
    NSString* testStr = @"Line0";
    if (lineNum > 1) {
        for (int i = 0; i < lineNum - 1; i ++) {
            [testStr stringByAppendingFormat:@"\nLine%d",i + 1];
        }
    }
    UILabel* label = [[UILabel alloc]init];
    label.numberOfLines = lineNum;
    if (attrDic) {
        label.attributedText = [[NSAttributedString alloc]initWithString:testStr attributes:attrDic];
    }else{
        label.text = testStr;
    }
    [label sizeToFit];
    return label.frame.size.height;
}


#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"icon_jyzy"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    AMapReGeocodeSearchRequest* regeoRequest = [[AMapReGeocodeSearchRequest alloc]init];
    regeoRequest.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    regeoRequest.requireExtension = YES;
    [self.searchApi AMapReGoecodeSearch:regeoRequest];
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    self.footerView.hidden = NO;
    
    if ([view.annotation isKindOfClass:[MAPointAnnotation class]]) {
        if (self.currentAnnotationView) {
            if (self.currentAnnotationView.annotation == view.annotation) {
                return;
            }
            self.currentAnnotationView.image = [UIImage imageNamed:@"icon_jyzy"];
        }
        self.currentAnnotationView = view;
        view.image = [UIImage imageNamed:@"icon_jyz"];
        AMapPOI* poi = [self.pois objectAtIndex:[self.annotaionsArr indexOfObject:view.annotation]];
        self.titleLabel.text = poi.name;
        self.subTitleLabel.text = poi.address;
    }
}

#pragma mark - AMapSearchDelegate
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if (response.pois.count == 0) {
        return;
    }
    
    if ([request isKindOfClass:[AMapPOIAroundSearchRequest class]]){//根据搜索结果绘制点
        [self.annotaionsArr removeAllObjects];
        self.pois = response.pois;
        __weak typeof(self) weakSelf;
        [response.pois enumerateObjectsUsingBlock:^(AMapPOI * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(obj.location.latitude, obj.location.longitude);
            [weakSelf.mapView addAnnotation:pointAnnotation];
            [weakSelf.annotaionsArr addObject:pointAnnotation];
        }];
    }
}

- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response{
    if (response.tips.count == 0) {
        self.tipsTable.hidden = YES;
        return;
    }
    self.data = response.tips;
    [self configDataSource];
    self.tipsTable.hidden = NO;
    [self.view bringSubviewToFront:self.tipsTable];
    [self.tipsTable reloadData];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    if (response.regeocode){
        self.regeocode = response.regeocode;
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{//开始搜索
    [self.searchBar endEditing:YES];
    AMapPOIAroundSearchRequest* aroundRequest = [[AMapPOIAroundSearchRequest alloc]init];
    aroundRequest.location = [AMapGeoPoint locationWithLatitude:self.userLocation.coordinate.latitude longitude:self.userLocation.coordinate.longitude];
    aroundRequest.keywords = self.serviceKeyWord;
    aroundRequest.sortrule = 0;//按距离排序
    aroundRequest.requireExtension = YES;
    [self.searchApi AMapPOIAroundSearch:aroundRequest];
    self.tipsTable.hidden = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{//搜索提示
    AMapInputTipsSearchRequest* tipsRequest = [[AMapInputTipsSearchRequest alloc]init];//搜索建议
    tipsRequest.keywords = searchText;
    tipsRequest.city = self.regeocode.addressComponent.city;//当前定位城市
    tipsRequest.cityLimit = YES;
    [self.searchApi AMapInputTipsSearch:tipsRequest];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.searchBar.text = [self.data objectAtIndex:indexPath.row].name;
    _tipsTable.hidden = YES;
    [self searchBarSearchButtonClicked:self.searchBar];
    [self.searchBar endEditing:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar endEditing:YES];
}

#pragma mark - RespondSelector
- (void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)tapToNavigate{
    
}



- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end

