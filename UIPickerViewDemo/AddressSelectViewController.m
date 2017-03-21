//
//  AddressSelectViewController.m
//  UniteRoute
//
//  Created by zz on 2016/10/18.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "AddressSelectViewController.h"
#import "City.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#define DATA_DEBUG 1
@interface AddressSelectViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,AMapLocationManagerDelegate>
{
    UIPickerView *_pickerView;
    NSArray *_typeArr;
    NSArray<Area*> *_areaCountyArr;
    NSArray *_cityArr;
    NSArray *_dataArr;
    NSArray *_selectArr;
    UIButton*_locationButton;
}
@property (nonatomic,retain)AMapLocationManager *locationManager;
@property (nonatomic,copy)NSString *currDistrict;
@end
@implementation AddressSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择地区";
    [self location];
    [self readData];
    [self setupView];
}

- (void)dealloc{
    _dataArr = nil;
    _selectArr = nil;
    _locationButton = nil;
    _typeArr = nil;
    _cityArr = nil;
    _areaCountyArr = nil;
}
#pragma mark- private for data
- (void)readData{
    NSArray *tmpCityArr = [KSDB selectFromTable:@"T_City" withCondition:nil attributes:@{@"cityCode":KS_INTEGER,@"cityName":KS_TEXT} modelClass:[City class]];
    NSMutableArray *tmpData = @[].mutableCopy;
    NSMutableDictionary *cityTypeDic = nil;
    NSMutableArray *types = nil;
    for (City *city in tmpCityArr) {
        cityTypeDic = @{}.mutableCopy;
        types = @[].mutableCopy;
        NSArray *tmpTypeArr = [KSDB selectFromTable:@"T_Type" withCondition:[NSString stringWithFormat:@"cityCode = %ld",city.cityCode] attributes:@{@"typeCode":KS_INTEGER,@"typeName":KS_TEXT} modelClass:[Type class]];
        NSMutableDictionary *typeAreaDic = nil;
        for (Type *type in tmpTypeArr) {
            typeAreaDic = @{}.mutableCopy;
            NSArray *areaCountyArr = [KSDB selectFromTable:@"T_AreaCounty" withCondition:[NSString stringWithFormat:@"typeCode = %ld",type.typeCode] attributes:@{@"name":KS_TEXT} modelClass:[Area class]];
            [typeAreaDic setObject:areaCountyArr forKey:type.typeName];
            [types addObject:typeAreaDic];
        }
        [cityTypeDic setObject:types forKey:city.cityName];
        [tmpData addObject:cityTypeDic];
    }
    _dataArr = tmpData;
    _cityArr = [self allKeysForDictionaryArray:_dataArr];
    _typeArr = [self allKeysForDictionaryArray:[[_dataArr objectAtIndex:0]allValues].firstObject];
    _areaCountyArr = [[[[[_dataArr objectAtIndex:0]allValues]objectAtIndex:0]objectAtIndex:0] allValues].firstObject;
    _selectArr = [[_dataArr objectAtIndex:0]allValues].firstObject;
}

- (NSArray *)allKeysForDictionaryArray:(NSArray<NSDictionary*>*)dicArr{
    NSMutableArray *tempArr = @[].mutableCopy;
    for (id obj in dicArr) {
        [tempArr addObjectsFromArray:[obj allKeys]];
    }
    if (tempArr.count) {
        return tempArr;
    }
    return nil;
}

#pragma mark- private for locate
- (void)location {
    if (KSUser.netState<=0) {
        [KSAlert weakAlertShowInViewCotroller:self withMessage:@"当前网络状态不佳，请稍微再试"];
    }
    self.locationManager = [[AMapLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    self.locationManager.locationTimeout = 3;
    self.locationManager.reGeocodeTimeout = 3;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            [KSAlert weakAlertShowInViewCotroller:self withMessage:@"定位失败，请稍微再试"];
            [_locationButton setTitle:@"重新定位" forState:UIControlStateNormal];
        }else {
            [_locationButton setTitle:regeocode.district forState:UIControlStateNormal];
        }
    }];
}
#pragma mark- Private for view creating
- (void)setupView{
    [self setupPickerView];
    [self setupTopView];
}

- (void)setupTopView{
    UIView *locationView = [UIView view];
    locationView.frame = CGRectMake(0, 1, kScreenWidth, 100);
    [self.view addSubview:locationView];
    
    UILabel *locationLabel = [UILabel view];
    locationLabel.text = @"当前定位";
    
    UIButton *locationButton = [UIButton new];
    locationButton.backgroundColor = kBGColor;
    
    [locationView sd_addSubviews:@[locationLabel,locationButton]];
    locationLabel.sd_layout
    .leftSpaceToView(locationView,20)
    .topSpaceToView(locationView,20)
    .autoHeightRatio(0);
    [locationLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    locationButton.sd_layout
    .leftSpaceToView(locationLabel,10)
    .centerYEqualToView(locationView)
    .heightRatioToView(locationView,0.5)
    .widthIs(100);
    _locationButton = locationButton;
}

- (void)setupPickerView{
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kNavHeight, kScreenWidth, 300)];
    [self.view addSubview:_pickerView];
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
}

- (void)setupBottomView{
    UIView *bottomView = [UIView view];
    bottomView.frame = CGRectMake(0, kScreenHeight - kNavHeight - 400,kScreenWidth, 100);
    [self.view addSubview:bottomView];
    
    UILabel *leftLabel = [UILabel view];
    leftLabel.text = @"开通城市";
    
    UIButton *cityButton = [UIButton new];
    cityButton.backgroundColor = kBGColor;
    
}

#pragma mark- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger components = 0;
    switch (component) {
        case 0:
            components = _cityArr.count;
            break;
        case 1:
            components = _typeArr.count;
            break;
        case 2:
            components = _areaCountyArr.count;
            break;
        default:
            break;
    }
    return components;
}

#pragma mark- UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _selectArr = [[_dataArr objectAtIndex:row]allValues].firstObject;
        
        _typeArr = [self allKeysForDictionaryArray:_selectArr];
        
        if (_typeArr.count) {
            _areaCountyArr = [[_selectArr objectAtIndex:0]allValues].firstObject;
        }else{
            _areaCountyArr = nil;
        }
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
    }else if (component == 1){
        if (_selectArr.count&&_typeArr.count) {
            _areaCountyArr = [[_selectArr objectAtIndex:row]allValues].firstObject;
        }else{
            _areaCountyArr = nil;
        }
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    [pickerView reloadComponent:2];
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [_cityArr objectAtIndex:row];
    }else if(component == 1){
        return  [_typeArr objectAtIndex:row];
    }else{
        return [_areaCountyArr objectAtIndex:row].name;
    }
}


@end
