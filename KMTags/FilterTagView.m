//
//  KMTagView.m
//  KMTags
//
//  Created by Kamal MIttal on 26/03/16.
//  Copyright © 2016 _. All rights reserved.
//

#import "FilterTagView.h"
#import "FilterTagCell.h"
#import "UICollectionViewLeftAlignedLayout.h"

@interface FilterTagView ()
@property (nonatomic, strong) NSMutableArray *tagList;
@property (nonatomic, strong) NSMutableArray *selectedTagList;
@end

@implementation FilterTagView

#pragma mark - init Functions

-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setUp];
    }
    return self;
}

-(void) prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}


-(void) setUp {
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[UICollectionViewLeftAlignedLayout new]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.showsVerticalScrollIndicator = false;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FilterTagCell" bundle:nil] forCellWithReuseIdentifier:@"tagcell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FilterTextCell" bundle:nil] forCellWithReuseIdentifier:@"textcell"];

    
    [self addSubview:self.collectionView];
    [self setTags:@[@"Kamal",@"Mittal", @"info.woodenlabs@gmail.com"]];

    self.tagColor = [UIColor purpleColor];
    self.crossColor = [UIColor whiteColor];
    self.tagTextColor = [UIColor whiteColor];
    self.isNeedToShowFilterTitle = NO;
    
    self.fontSize = 12.0;
    self.fontName = @"HelveticaNeue-Regular";
    
    
    self.filterTitle = @"";
    self.filterTitleColor = [UIColor blackColor];
    
    self.tagHorizontalDistance = 3;
    self.tagVerticalDistance = 3;
    self.horizontalPadding = 10;
    self.verticalPadding = 10;
    self.cornerRadius = 0;
    
    self.tagList = [NSMutableArray new];
    self.selectedTagList = [NSMutableArray new];

}

-(void) createTags {
    [self.collectionView reloadData];

    dispatch_async(dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(finalheightOfView:)]) {
            float height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
            [self.delegate finalheightOfView:height];
        }
    });


}


#pragma mark - Class Functions
-(void) setTags:(NSArray *) list
{
    NSArray *uniqueTag = [[NSOrderedSet orderedSetWithArray:list] array];
    self.tagList = [NSMutableArray arrayWithArray:uniqueTag];
    [self createTags];

}

-(NSArray *) getTagList {
    return self.tagList;
}

-(void) setSeelctedTags:(NSArray *) list
{
    NSArray *uniqueTag = [[NSOrderedSet orderedSetWithArray:list] array];
    self.selectedTagList = [NSMutableArray arrayWithArray:uniqueTag];
    [self.collectionView reloadData];

}
-(NSArray *) getSelectedTagList
{
    return self.selectedTagList;
}

#pragma mark - Events
-(void) TagRemoved:(UIButton *) btn {
    
    if([self.delegate respondsToSelector:@selector(removedTag:fromIndex:)]) {
        [self.delegate removedTag:self.tagList[btn.tag] fromIndex:btn.tag];
    }
    
    [self.tagList removeObjectAtIndex:btn.tag];
    [self createTags];
}


#pragma mark - Collection View function
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    NSInteger value = (self.isNeedToShowFilterTitle ? 1 : 0);
    value += self.tagList.count;
    return value;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0 && self.isNeedToShowFilterTitle) {
        FilterTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"textcell" forIndexPath:indexPath];
        cell.lbltag.text = self.filterTitle;
        cell.backgroundColor = [UIColor clearColor];
        return cell;

    }
    else {
        FilterTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tagcell" forIndexPath:indexPath];
        NSInteger index = (self.isNeedToShowFilterTitle ? indexPath.row - 1 : indexPath.row);
        NSString *tagValue = self.tagList[index];
        cell.lbltag.text = tagValue;
        cell.lbltag.textColor = [UIColor whiteColor];
        cell.lbltag.font = [UIFont fontWithName:self.fontName size:self.fontSize];
        cell.backgroundColor = [UIColor purpleColor];
        cell.btncross.tag = index;
        [cell.btncross addTarget:self action:@selector(TagRemoved:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.selectedTagList containsObject:tagValue])
            cell.backgroundColor = self.selectedTagColor;
        else
            cell.backgroundColor = self.tagColor;
        
        cell.lbltag.textColor = self.tagTextColor;
        [cell.btncross setTitleColor:self.crossColor forState:UIControlStateNormal];
        
        cell.clipsToBounds = YES;
        cell.layer.cornerRadius = self.cornerRadius;
        
        cell.paddingLeft.constant = self.horizontalPadding;
        cell.paddingRight.constant = self.horizontalPadding;

        [cell layoutIfNeeded];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = (self.isNeedToShowFilterTitle ? indexPath.row - 1 : indexPath.row);
    NSString *tagValue = self.tagList[index];
    if([self.selectedTagList containsObject:tagValue]) {
        [self.selectedTagList removeObject:tagValue];
    } else {
        [self.selectedTagList addObject:tagValue];
    }
    [self.collectionView reloadData];
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
    NSInteger index = (self.isNeedToShowFilterTitle ? indexPath.row - 1 : indexPath.row);

    UILabel *tempLabel = [UILabel new];
    NSString *text = @"";
    if(self.isNeedToShowFilterTitle) {
        text = (indexPath.row == 0) ? self.filterTitle : self.tagList[index];
    } else {
        text = self.tagList[index];
    }
    
    tempLabel.text = text;
    tempLabel.font = [UIFont fontWithName:self.fontName size:self.fontSize];
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.textAlignment = NSTextAlignmentLeft;
    CGSize s = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    CGSize size = [tempLabel sizeThatFits:s];
    size.height += 2 * self.verticalPadding;
    if (indexPath.row != 0 || !self.isNeedToShowFilterTitle)
      size.width += (2 * self.horizontalPadding) + 25;
    return size;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.tagVerticalDistance ;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.tagHorizontalDistance;
}



@end
