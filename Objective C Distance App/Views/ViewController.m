//
//  ViewController.m
//  Objective C Distance App
//
//  Created by Ari He on 8/11/21.
//

#import "ViewController.h"
#import "DestinationCityRowViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DestinationCityRowViewController *destination1;
@property (nonatomic) DestinationCityRowViewController *destination2;
@property (nonatomic) DestinationCityRowViewController *destination3;

@end

@implementation ViewController

// MARK: Properties

UITextField *originCityInput;
UIButton *updateButton;
UIStackView *inputStack;

DGDistanceRequest *req;


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
    [self setUpDestinationRows];
}

- (void)setUpInputStack {
    originCityInput = [UITextField new];
    [originCityInput setPlaceholder:@"Enter origin city"];
    
    updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [updateButton setTitle:@"Update" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(didClickUpdateButton) forControlEvents:UIControlEventTouchUpInside];
    
    inputStack = [UIStackView new];
    [inputStack setAxis:UILayoutConstraintAxisHorizontal];
    [inputStack setUserInteractionEnabled:TRUE];
    [inputStack setDistribution:UIStackViewDistributionFill];
    
    [inputStack addArrangedSubview:originCityInput];
    [inputStack addArrangedSubview:updateButton];
    
    [updateButton setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.view addSubview:inputStack];
}

- (void)setUpDestinationRows {
    _destination1 = [DestinationCityRowViewController new];
    _destination2 = [DestinationCityRowViewController new];
    _destination3 = [DestinationCityRowViewController new];
    
    [self.view addSubview:_destination1.view];
    [self.view addSubview:_destination2.view];
    [self.view addSubview:_destination3.view];
}


// MARK: Constraints

- (void)setUpConstraints {
    [self setUpInputStackConstraint];
    [self setUpDestinationRowConstraints];
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

- (void)setUpConstraintForDestinationRow: (DestinationCityRowViewController*)row top: (UIView*)topView {
    [row.view setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    
    // Top
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:row.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30];
    
    // Height
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:row.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
    
    // Leading
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:row.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:30];
    
    // Trailing
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:row.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-30];
    
    // Activation
    NSArray *constraints = [NSArray arrayWithObjects:top, leading, trailing, height, nil];
    [self.view addConstraints: constraints];
    
}

- (void)setUpDestinationRowConstraints {
    [self setUpConstraintForDestinationRow:_destination1 top:inputStack];
    [self setUpConstraintForDestinationRow:_destination2 top:_destination1.view];
    [self setUpConstraintForDestinationRow:_destination3 top:_destination2.view];
}

// MARK: Distance Request

- (void)didClickUpdateButton {
    [self sendDistanceRequest];
}

- (void)sendDistanceRequest {
    if ([originCityInput.text isEqualToString:@""]) {
        return;
    }
    
    NSString *start = originCityInput.text;
    
    NSMutableArray *destinationArray = [NSMutableArray new];
    
    [destinationArray addObject:_destination1.getDestinationCity];
    [destinationArray addObject:_destination2.getDestinationCity];
    [destinationArray addObject:_destination3.getDestinationCity];
    
    req = [[DGDistanceRequest alloc] initWithLocationDescriptions:destinationArray sourceDescription:start];
    
    NSLog(@"Sending request with destinations: %@", destinationArray);
    
    [req start];
    
    __weak ViewController* weakSelf = self;
    
    req.callback = ^(NSArray *distances) {
        if (weakSelf == nil) return;
        else [weakSelf assignDistances:distances];
    };
    
    [updateButton setEnabled:FALSE];
}

- (void)assignDistances: (NSArray*)distances {
    [updateButton setEnabled:TRUE];
    
    // Prevent circular references
    req = nil;
    
    NSLog(@"received callback: %@", distances);
    
    [self setDistance:distances[0] toRow:_destination1];
    [self setDistance:distances[1] toRow:_destination2];
    [self setDistance:distances[2] toRow:_destination3];
}

- (void)setDistance: (NSNumber*)distance toRow: (DestinationCityRowViewController*)row {
    if ([distance isEqualToNumber:@-1]) {
        [row setDistanceLabel:@"N/A"];
    } else {
        NSString *text = [NSString stringWithFormat:@"%@ miles", [self round:distance]];
        
        [row setDistanceLabel:text];
    }
}

- (NSString*)round: (NSNumber*)number {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    
    return [formatter stringFromNumber:number];
}


@end
