//
//  KMTagCell.h
//  KMTags
//
//  Created by Kamal MIttal on 26/03/16.
//  Copyright © 2016 _. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterTagCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UILabel *lbltag;
@property (nonatomic, weak) IBOutlet UIButton *btncross;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *paddingLeft;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *paddingRight;
@end
