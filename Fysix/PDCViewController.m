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
@property (strong, nonatomic) UIView *anchorView;
@property (strong, nonatomic) UIView *tailView;
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehavior;
@end

@implementation PDCViewController

- (NSArray *)dynamicItems
{
    if (!_dynamicItems) {
        self.anchorView = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 50, 50)];
        self.anchorView.backgroundColor = [UIColor magentaColor];
        self.tailView = [[UIView alloc] initWithFrame:CGRectMake(300, 300, 50, 50)];
        self.tailView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        _dynamicItems = @[self.anchorView, self.tailView];
    }
    return _dynamicItems;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // init views
    for (UIView *v in self.dynamicItems) {
        [self.view addSubview:v];
    }
    
    // Add animator:
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Add attachment behavior:
    self.attachmentBehavior = [[UIAttachmentBehavior alloc]
                               initWithItem:self.tailView
                               attachedToAnchor:self.anchorView.center];
    [self.animator addBehavior:self.attachmentBehavior];
    
    [self.anchorView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleAttachmentGesture:)]];
}

- (void)handleAttachmentGesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint gesturePoint = [gesture locationInView:self.view];
    self.anchorView.center = gesturePoint;
    [self.attachmentBehavior setAnchorPoint:gesturePoint];
}

@end
