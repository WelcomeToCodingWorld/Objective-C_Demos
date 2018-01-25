//
//  CityTableViewCell.m
//  UniteRoute
//
//  Created by zz on 19/01/2018.
//  Copyright © 2018 Klaus. All rights reserved.
//

#import "CityTableViewCell.h"
#import "City.h"
@interface CityTableViewCell()
{
    UILabel* _titleLabel;
}
@property (nonatomic,copy)ChooseBlock chooseBlock;
@property (nonatomic,retain)NSMutableArray<UIButton*>* itemsView;
@property (nonatomic,assign)BOOL reused;

@end

const NSInteger defaultAreasNum = 15;
const NSInteger itemsPerRow = 3;
const CGFloat leftEdge = 30;
const CGFloat itemW = 100;
const CGFloat itemH = 26;

@implementation CityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.itemsView = [NSMutableArray array];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kBGColor;
        [self setupView];
    }
    return self;
}


- (void)setupView{
    _titleLabel = [UILabel labelWithTextColor:kBlackColor font:KSUser.fourteenFont];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 2*kEdgeWidth)
    .topEqualToView(self.contentView)
    .heightIs(30);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:kScreenWidth - 3*kEdgeWidth];
    
    for (int i = 0; i < defaultAreasNum; i++) {
        UIButton* item = [self districtButton];
        [self.contentView addSubview:item];
    }
}

- (UIButton*)districtButton {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.hidden = true;
    [btn setTitleColor:kBlackColor forState:UIControlStateNormal];
    btn.titleLabel.font = KSUser.fourteenFont;
    [btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 3.0;
    btn.layer.masksToBounds = true;
    btn.backgroundColor = kWhiteColor;
    [_itemsView addObject:btn];
    btn.tag = _itemsView.count - 1;
    return btn;
}

- (void)setCity:(City *)city {
    _titleLabel.text = city.name;
    CGFloat hSpace = (kScreenWidth - leftEdge - kEdgeWidth - itemsPerRow*itemW)/(itemsPerRow - 1);
    if (!_reused) {//not reuse
        __block UIView* lastView = _titleLabel;
        if (defaultAreasNum < city.areas.count) {//不够就补
            for (int i = 0;i < (city.areas.count - defaultAreasNum);i ++) {
                UIButton* btn = [self districtButton];
                [self.contentView addSubview:btn];
            }
        }
        
        _city = city;
        
        //show and layout
        [_itemsView enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < city.areas.count) {
                obj.hidden = false;
                [obj setTitle:city.areas[idx].name forState:UIControlStateNormal];
            }
            
            if (idx < itemsPerRow) {
                if (idx == 0) {
                    obj.sd_layout
                    .leftSpaceToView(self.contentView, leftEdge);
                }else {
                    obj.sd_layout
                    .leftSpaceToView(lastView, hSpace);
                }
                obj.sd_layout
                .topSpaceToView(_titleLabel, 0);
                lastView = obj;
            }else {
                lastView = [_itemsView objectAtIndex:idx - itemsPerRow];
                obj.sd_layout
                .leftEqualToView(lastView)
                .topSpaceToView(lastView, kEdgeWidth);
            }
            obj.sd_layout
            .widthIs(100)
            .heightIs(26);
        }];
        [self setupAutoHeightWithBottomView:[_itemsView objectAtIndex:city.areas.count - 1] bottomMargin:30];
    }else {//reuse
        KSLog(@"Reused:%@ should not be nil",_city);
        self.reused = false;
        if (_city.areas.count == city.areas.count) {
            //show
            [_itemsView enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx < city.areas.count) {
                    obj.hidden = false;
                    [obj setTitle:city.areas[idx].name forState:UIControlStateNormal];
                }
            }];
            return;
        }else {
            NSInteger newIndex = city.areas.count - 1;
            __block UIView* lastView;

            NSMutableArray<UIButton*>* newUpdateItems = [NSMutableArray array];
            NSInteger currentNum = _itemsView.count;
            if (currentNum < city.areas.count) {//不够就补
                for (int i = 0;i < city.areas.count - currentNum;i ++) {
                    UIButton* btn = [self districtButton];
                    [self.contentView addSubview:btn];
                    [newUpdateItems addObject:btn];
                }
            }else if (currentNum > city.areas.count) {//多了就去，在够用的情况下只保留defaultItems个
                if (currentNum > defaultAreasNum && defaultAreasNum > city.areas.count ){//尽量只保留defatuItems个
                    for (int i = defaultAreasNum;i < city.areas.count;i ++) {
                        [_itemsView[i] removeFromSuperview];
                        [_itemsView removeObjectAtIndex:i];
                    }
                }
            }
 
            _city = city;
            
            //show
            [_itemsView enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx < city.areas.count) {
                    obj.hidden = false;
                    [obj setTitle:city.areas[idx].name forState:UIControlStateNormal];
                }
            }];

            // layout
            for (UIButton* item  in newUpdateItems) {
                NSInteger idx = [_itemsView indexOfObject:item];
                if (idx < itemsPerRow) {
                    if (idx == 0) {
                        item.sd_resetLayout
                        .leftSpaceToView(self.contentView, leftEdge);
                    }else {
                        lastView = _itemsView[idx - 1];
                        item.sd_resetLayout
                        .leftSpaceToView(lastView, hSpace);
                    }
                    item.sd_layout
                    .topSpaceToView(_titleLabel, 0);
                }else {
                    lastView = [_itemsView objectAtIndex:idx - itemsPerRow];
                    item.sd_resetLayout
                    .leftEqualToView(lastView)
                    .topSpaceToView(lastView, kEdgeWidth);
                }
                item.sd_layout
                .widthIs(100)
                .heightIs(26);
            }
            [self setupAutoHeightWithBottomView:_itemsView[newIndex] bottomMargin:30];
        }
    }
}

-(NSMutableSet<UIButton*>*)setFromReminder:(NSInteger)reminder minIdx:(NSInteger)minIdx{
    NSMutableSet<UIButton*>* set = [NSMutableSet set];
    [_itemsView enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger currentReminder = idx % itemsPerRow;
        if (reminder <= currentReminder && minIdx <= idx) {
            [set addObject:obj];
        }
    }];
    return set;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    [_itemsView enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = true;
    }];
    self.reused = true;
    KSLog(@"Reused:%@ should not be nil",_city);
}

#pragma mark *******************RespondSelector*******************
- (void)choose:(UIButton*)sender {
    Area* area = [self.city.areas objectAtIndex:sender.tag];
    if (self.chooseBlock) {
        self.chooseBlock(area,self.city);
    }
}

- (void)configureTapBlock:(ChooseBlock)chooseBlock {
    self.chooseBlock =  chooseBlock;
}

@end
