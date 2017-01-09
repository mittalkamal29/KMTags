//
//  KMTagView.h
//  KMTags
//
//  Created by Kamal MIttal on 26/03/16.
//  Copyright © 2016 _. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE


@protocol FilterTagViewDelegate <NSObject>
-(void) removedTag:(NSString *)tag fromIndex:(NSInteger)index;
-(void) finalheightOfView:(float) height;

@end

@interface FilterTagView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic) IBInspectable UIColor  *tagColor;
@property (nonatomic) IBInspectable UIColor  *selectedTagColor;

@property (nonatomic) IBInspectable UIColor  *crossColor;
@property (nonatomic) IBInspectable UIColor  *tagTextColor;
@property (nonatomic) IBInspectable CGFloat   fontSize;
@property (nonatomic) IBInspectable NSString *fontName;

@property (nonatomic) IBInspectable BOOL      isNeedToShowFilterTitle;
@property (nonatomic) IBInspectable NSString *filterTitle;
@property (nonatomic) IBInspectable UIColor  *filterTitleColor;

@property (nonatomic) IBInspectable CGFloat   tagHorizontalDistance;
@property (nonatomic) IBInspectable CGFloat   tagVerticalDistance;
@property (nonatomic) IBInspectable CGFloat   horizontalPadding;
@property (nonatomic) IBInspectable CGFloat   verticalPadding;
@property (nonatomic) IBInspectable CGFloat   cornerRadius;

@property (nonatomic)  UICollectionView *collectionView;


@property (nonatomic, weak) IBOutlet id<FilterTagViewDelegate> delegate;
-(void) setTags:(NSArray *) list;
-(NSArray *) getTagList;

-(void) setSeelctedTags:(NSArray *) list;
-(NSArray *) getSelectedTagList;

@end
