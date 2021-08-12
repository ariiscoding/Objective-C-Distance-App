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
@property (nonatomic) DestinationCityRowViewController *destination4;

@property (nonatomic) UITextField *originCityInput;
@property (nonatomic) UIButton *updateButton;
@property (nonatomic) UIStackView *inputStack;

@property (nonatomic) DGDistanceRequest *req;

@end

@implementation ViewController


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
    _originCityInput = [UITextField new];
    [_originCityInput setPlaceholder:@"Enter origin city"];
    
    _updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_updateButton setTitle:@"Update" forState:UIControlStateNormal];
    [_updateButton addTarget:self action:@selector(didClickUpdateButton) forControlEvents:UIControlEventTouchUpInside];
    
    _inputStack = [UIStackView new];
    [_inputStack setAxis:UILayoutConstraintAxisHorizontal];
    [_inputStack setUserInteractionEnabled:TRUE];
    [_inputStack setDistribution:UIStackViewDistributionFill];
    
    [_inputStack addArrangedSubview:_originCityInput];
    [_inputStack addArrangedSubview:_updateButton];
    
    [_updateButton setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.view addSubview:_inputStack];
}

- (void)setUpDestinationRows {
    _destination1 = [DestinationCityRowViewController new];
    _destination2 = [DestinationCityRowViewController new];
    _destination3 = [DestinationCityRowViewController new];
    _destination4 = [DestinationCityRowViewController new];
    
    [self.view addSubview:_destination1.view];
    [self.view addSubview:_destination2.view];
    [self.view addSubview:_destination3.view];
    [self.view addSubview:_destination4.view];
}


// MARK: Constraints

- (void)setUpConstraints {
    [self setUpInputStackConstraint];
    [self setUpDestinationRowConstraints];
}

- (void)setUpInputStackConstraint {
    [_inputStack setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    
    // Top
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_inputStack attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.00 constant:100];
    
    // Leading
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:_inputStack attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:30];
    
    // Trailing
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:_inputStack attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-30];
    
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
    [self setUpConstraintForDestinationRow:_destination1 top:_inputStack];
    [self setUpConstraintForDestinationRow:_destination2 top:_destination1.view];
    [self setUpConstraintForDestinationRow:_destination3 top:_destination2.view];
    [self setUpConstraintForDestinationRow:_destination4 top:_destination3.view];
}

// MARK: Distance Request

- (void)didClickUpdateButton {
    [self sendDistanceRequest];
}

- (void)sendDistanceRequest {
    if ([_originCityInput.text isEqualToString:@""]) {
        return;
    }
    
    NSString *start = _originCityInput.text;
    
    NSMutableArray *destinationArray = [NSMutableArray new];
    
    [destinationArray addObject:_destination1.getDestinationCity];
    [destinationArray addObject:_destination2.getDestinationCity];
    [destinationArray addObject:_destination3.getDestinationCity];
    [destinationArray addObject:_destination4.getDestinationCity];
    
    _req = [[DGDistanceRequest alloc] initWithLocationDescriptions:destinationArray sourceDescription:start];
    
    [_req start];
    
    __weak ViewController* weakSelf = self;
    
    _req.callback = ^(NSArray *distances) {
        if (weakSelf == nil) return;
        else [weakSelf assignDistances:distances];
    };
    
    [_updateButton setEnabled:FALSE];
}

- (void)assignDistances: (NSArray*)distances {
    [_updateButton setEnabled:TRUE];
    
    // Prevent circular references
    _req = nil;
    
    [self setDistance:distances[0] toRow:_destination1];
    [self setDistance:distances[1] toRow:_destination2];
    [self setDistance:distances[2] toRow:_destination3];
    [self setDistance:distances[3] toRow:_destination4];
}

- (void)setDistance: (NSNumber*)distanceInM toRow: (DestinationCityRowViewController*)row {
    if ([distanceInM isEqualToNumber:@-1]) {
        [row setDistanceLabel:@"N/A"];
    } else {
        NSNumber *distanceInKm = [NSNumber numberWithDouble:[distanceInM doubleValue] / 1000];
        NSString *text = [NSString stringWithFormat:@"%@ km", [self round: distanceInKm]];
        
        [row setDistanceLabel:text];
    }
}

- (NSString*)round: (NSNumber*)number {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:0];
    
    return [formatter stringFromNumber:number];
}


@end
