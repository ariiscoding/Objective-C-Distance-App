//
//  ViewController.m
//  Objective C Distance App
//
//  Created by Ari He on 8/11/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// MARK: Properties

UITextField *originCityInput;
UIButton *updateButton;
UIStackView *inputStack;



// MARK: Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    [self setUpViews];
    [self setUpConstraints];
}


// MARK: View Setup

- (void)setUpViews {
    [self setUpInputStack];
}

- (void)setUpInputStack {
    originCityInput = [UITextField new];
    [originCityInput setPlaceholder:@"Enter origin city"];
    
    updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [updateButton setTitle:@"Update" forState:UIControlStateNormal];
    
    inputStack = [UIStackView new];
    [inputStack setAxis:UILayoutConstraintAxisHorizontal];
    [inputStack setUserInteractionEnabled:TRUE];
    [inputStack setDistribution:UIStackViewDistributionFill];
    
    [inputStack addArrangedSubview:originCityInput];
    [inputStack addArrangedSubview:updateButton];
    
    [updateButton setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.view addSubview:inputStack];
}


// MARK: Constraints

- (void)setUpConstraints {
    [self setUpInputStackConstraint];
}

- (void)setUpInputStackConstraint {
    [inputStack setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    
    // Top
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:inputStack attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.00 constant:100];
    
    // Leading
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:inputStack attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:30];
    
    // Trailing
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:inputStack attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-30];
    
    // Activation
    NSArray *constraints = [NSArray arrayWithObjects:top, leading, trailing, nil];
    [self.view addConstraints: constraints];
}


@end
