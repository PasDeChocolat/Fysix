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
@property (strong, nonatomic) IBOutlet UIView *anchorView;
@property (strong, nonatomic) IBOutlet UIView *tailView;
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehavior;
@end

@implementation PDCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Add animator:
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Add attachment behavior:
    self.attachmentBehavior = [[UIAttachmentBehavior alloc]
                               initWithItem:self.tailView
                               attachedToAnchor:self.anchorView.center];
    [self.animator addBehavior:self.attachmentBehavior];
}

- (IBAction)handleAttachmentGesture:(UIPanGestureRecognizer *)sender
{
    CGPoint gesturePoint = [sender locationInView:self.view];
    self.anchorView.center = gesturePoint;
    [self.attachmentBehavior setAnchorPoint:gesturePoint];
}

@end
