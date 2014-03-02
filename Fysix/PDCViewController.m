//
//  PDCViewController.m
//  Fysix
//
//  Created by Kyle Oba on 3/1/14.
//  Copyright (c) 2014 Pas de Chocolat. All rights reserved.
//

#import "PDCViewController.h"

@interface PDCViewController ()
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) NSArray *dynamicItems;
@end

#define NUM_DYNAMIC_ITEMS 10

@implementation PDCViewController

- (NSArray *)dynamicItems
{
    if (!_dynamicItems) {
        NSMutableArray *allItems = [NSMutableArray array];
        for (int i=0; i<NUM_DYNAMIC_ITEMS; i++) {
            CGFloat x = arc4random_uniform(CGRectGetWidth(self.view.bounds));
            CGFloat y = arc4random_uniform(CGRectGetHeight(self.view.bounds));
            [allItems addObject:[[UIView alloc] initWithFrame:CGRectMake(x, y, 50, 50)]];
        }
        _dynamicItems = [NSArray arrayWithArray:allItems];
        for (UIView *item in _dynamicItems) {
            item.backgroundColor = [UIColor magentaColor];
            [self.view addSubview:item];
        }
    }
    return _dynamicItems;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Add animator:
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Add behavior:
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:self.dynamicItems];
    gravityBehavior.gravityDirection = CGVectorMake(0.0, 1.0);
    [self.animator addBehavior:gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.dynamicItems];
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
}

@end
