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
@property (strong, nonatomic) IBOutlet UIView *pushView;
@property (strong, nonatomic) UIPushBehavior *pushBehavior;
@end

@implementation PDCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Add animator:
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Add gravity:
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.pushView]];
    [self.animator addBehavior:gravityBehavior];
    
    // Add boundary:
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.pushView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
    
    // Add push behavior:
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.pushView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehavior.angle = 0.0;
    self.pushBehavior.magnitude = 0.0;
    [self.animator addBehavior:self.pushBehavior];
}

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)sender
{
    CGPoint tapPoint = [sender locationInView:self.view];
    CGPoint itemPoint = self.pushView.center;

    // Calculate direction of force toward tap:
    self.pushBehavior.pushDirection = CGVectorMake(tapPoint.x - itemPoint.x,
                                                   tapPoint.y - itemPoint.y);

    // Calculate distance, inversely proportional to distance from block:
    CGFloat dist = sqrtf(powf(tapPoint.x - itemPoint.x, 2.0) +
                         powf(tapPoint.y - itemPoint.y, 2.0));
    self.pushBehavior.magnitude = dist/100.0;
    
    // Apply instantaneous force:
    self.pushBehavior.active = YES;
}


@end
