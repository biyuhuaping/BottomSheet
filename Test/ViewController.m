#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "BottomSheetBackgroundView.h"
#import "CountriesTableViewController.h"

@interface ViewController ()<SheetDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, assign) CGFloat topDistance;
@property (nonatomic, strong) UIView *sheetView;

@end

@implementation ViewController{
    BottomSheetBackgroundView *_sheetBgView;
    NSLayoutConstraint *_sheetBgTopConstraint;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self setupViews];
}

- (void)bottomSheet:(id)bottomSheet didScrollTo:(CGPoint)contentOffset {
    self.topDistance = MAX(0, -contentOffset.y);
}

#pragma mark - Private Methods

- (void)setupViews {
    // The sheet background
    _sheetBgView = [[BottomSheetBackgroundView alloc] init];
    [self.view addSubview:_sheetBgView];
    _sheetBgView.translatesAutoresizingMaskIntoConstraints = NO;
    _sheetBgTopConstraint = [_sheetBgView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
    [NSLayoutConstraint activateConstraints:@[
        _sheetBgTopConstraint,
        [_sheetBgView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor],
        [_sheetBgView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [_sheetBgView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor]
    ]];
    
    // tableView视图一直延伸到状态栏
    CountriesTableViewController *shortcutsVC = [[CountriesTableViewController alloc] init];
    shortcutsVC.delegate = self;
    [self addChildViewController:shortcutsVC];
    self.sheetView = shortcutsVC.view;
    [self.view addSubview:_sheetView];
    _sheetView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [_sheetView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [_sheetView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
        [_sheetView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [_sheetView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)setTopDistance:(CGFloat)topDistance {
    _topDistance = topDistance;
    _sheetBgTopConstraint.constant = topDistance;
    NSLog(@"topDistance：%.2f", topDistance);
}

@end
