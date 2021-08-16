//
//  JKMonitorContentView.m
//  JKMonitor
//
//  Created by 王治恒 on 2021/8/15.
//

#import "JKMonitorContentView.h"

@interface JKMonitorContentView()

@property (nonatomic, strong) UILabel *fpsLabel;
@property (nonatomic, strong) UILabel *cpuLabel;
@property (nonatomic, strong) UILabel *useMemoryLabel;
@property (nonatomic, strong) UILabel *avalibelMemoryLabel;

@end

@implementation JKMonitorContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupStyle];
        [self initView];
    }
    return self;
}

- (void)setupStyle
{
    self.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:.2f];
    self.layer.cornerRadius = 16.f;
}

- (void)initView
{
    UILabel *fpsKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, 30, 20)];
    fpsKeyLabel.text = @"FPS";
    fpsKeyLabel.font = [UIFont boldSystemFontOfSize:12];
    fpsKeyLabel.textColor = [self colorWithHexStr:@"333333" alpha:1];
    [self addSubview:fpsKeyLabel];
    [self addSubview:self.fpsLabel];
    
    UIView *split1View = [[UIView alloc] initWithFrame:CGRectMake(38, 10, 1, self.frame.size.height - 20)];
    split1View.backgroundColor = [self colorWithHexStr:@"00a6ac" alpha:1];
    [self addSubview:split1View];
    
    UILabel *cpuKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(46, 5, 30, 20)];
    cpuKeyLabel.text = @"CPU";
    cpuKeyLabel.font = [UIFont boldSystemFontOfSize:12];
    cpuKeyLabel.textColor = [self colorWithHexStr:@"333333" alpha:1];
    [self addSubview:cpuKeyLabel];
    [self addSubview:self.cpuLabel];
    
    UILabel *cpuRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(66, 32, 12, 12)];
    cpuRateLabel.text = @"%";
    cpuRateLabel.font = [UIFont boldSystemFontOfSize:10];
    cpuRateLabel.textColor = [self colorWithHexStr:@"009ad6" alpha:1];
    [self addSubview:cpuRateLabel];
    
    UIView *split2View = [[UIView alloc] initWithFrame:CGRectMake(82, 10, 1, self.frame.size.height - 20)];
    split2View.backgroundColor = [self colorWithHexStr:@"00a6ac" alpha:1];
    [self addSubview:split2View];
    
    UILabel *memoryKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 30, 20)];
    memoryKeyLabel.text = @"MEM";
    memoryKeyLabel.font = [UIFont boldSystemFontOfSize:12];
    memoryKeyLabel.textColor = [self colorWithHexStr:@"333333" alpha:1];
    [self addSubview:memoryKeyLabel];
    [self addSubview:self.useMemoryLabel];
    [self addSubview:self.avalibelMemoryLabel];
}

#pragma mark - lazy load

- (UILabel *)fpsLabel
{
    if (!_fpsLabel) {
        _fpsLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 25, 30, 24)];
        _fpsLabel.font = [UIFont boldSystemFontOfSize:15];
        _fpsLabel.textColor = [self colorWithHexStr:@"1d315e" alpha:.9f];
    }
    return _fpsLabel;
}

- (UILabel *)cpuLabel
{
    if (!_cpuLabel) {
        _cpuLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 25, 25, 24)];
        _cpuLabel.font = [UIFont boldSystemFontOfSize:15];
        _cpuLabel.textColor = [self colorWithHexStr:@"009ad6" alpha:.9f];
        _cpuLabel.textAlignment = NSTextAlignmentRight;
        _cpuLabel.text = @"0";
    }
    return _cpuLabel;
}

- (UILabel *)useMemoryLabel
{
    if (!_useMemoryLabel) {
        _useMemoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 22, 40, 20)];
        _useMemoryLabel.font = [UIFont boldSystemFontOfSize:13];
        _useMemoryLabel.textColor = [self colorWithHexStr:@"3F4545" alpha:.9f];
    }
    return _useMemoryLabel;
}

- (UILabel *)avalibelMemoryLabel
{
    if (!_avalibelMemoryLabel) {
        _avalibelMemoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 35, 40, 20)];
        _avalibelMemoryLabel.font = [UIFont boldSystemFontOfSize:13];
        _avalibelMemoryLabel.textColor = [self colorWithHexStr:@"145b7d" alpha:.9f];
    }
    return _avalibelMemoryLabel;
}

- (void)setFpsValue:(CGFloat)fpsValue
{
    _fpsValue = fpsValue;
    self.fpsLabel.text = [NSString stringWithFormat:@"%.0f", fpsValue];
}

- (void)setCpuValue:(CGFloat)cpuValue
{
    _cpuValue = cpuValue;
    if (cpuValue < 10) {
        self.cpuLabel.text = [NSString stringWithFormat:@"%.1f", cpuValue];
    } else {
        self.cpuLabel.text = [NSString stringWithFormat:@"%.0f", cpuValue];
    }
}

- (void)setUsedMemoryValue:(CGFloat)usedMemoryValue
{
    _usedMemoryValue = usedMemoryValue;
    self.useMemoryLabel.text = [NSString stringWithFormat:@"%.0f", usedMemoryValue];
}

- (void)setAvailableMemoryValue:(CGFloat)availableMemoryValue
{
    _availableMemoryValue = availableMemoryValue;
    self.avalibelMemoryLabel.text = [NSString stringWithFormat:@"%.0f", availableMemoryValue];
}

- (UIColor *)colorWithHexStr:(NSString *)hexStr alpha:(CGFloat)alpha{
    
    // 第一位是#号则去掉#号;
    if (hexStr && hexStr.length > 1 && [[hexStr substringToIndex:1] isEqualToString:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
    }
    
    // 如果色值不合法，返回白色
    if (!hexStr || hexStr.length != 6) {
        return [UIColor whiteColor];
    }
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]]scanHexInt:&blue];
    
    //要进行颜色的RGB设置，要进行对255.0的相除（与其他语言不同）
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:alpha];
}

@end
