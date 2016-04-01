//
//  ViewController.m
//  CommonFramework
//
//  Created by dengtao on 16/3/28.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import "ViewController.h"
#import "PDHttpTool.h"
#import "TestModel.h"
#import "MTLFMDBAdapter.h"
#import "FMDBManager.h"
#import "TestModelDao.h"

@interface ViewController ()
{
    UITextField *name;
    UITextField *age;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试子界面";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    
    name = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH-40, 30)];
    name.placeholder = @"请输入姓名";
    [self.view addSubview:name];
    
    age = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(name.frame), SCREEN_WIDTH-40, 30)];
    age.placeholder = @"请输入年龄";
    [self.view addSubview:age];
    
    UIButton *add = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(age.frame), SCREEN_WIDTH-40, 40)];
    [add setTitle:@"新增用户" forState:UIControlStateNormal];
    [add setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    
    UIButton *show = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(add.frame), SCREEN_WIDTH - 40, 40)];
    [show setTitle:@"查看用户" forState:UIControlStateNormal];
    [show setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [show addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:show];
    
    UIImageView *imageView =  [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(show.frame)+30, 200, 100)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/h%3D200/sign=f1bdcdf64010b912a0c1f1fef3fcfcb5/8326cffc1e178a8285adf5edf103738da877e8ee.jpg"]
                 placeholderImage:[UIImage imageNamed:@"Default"]];
    [self.view addSubview:imageView];

    [[PDHttpTool sharedHttpTool] request:GET
                               urlString:@"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios"
                              parameters:nil
                                finished:^(id result, NSError *error) {
                                    
                                    TestModel *test = [MTLJSONAdapter modelOfClass:[TestModel class] fromJSONDictionary:(NSDictionary *)result error:nil];
                                    
                                    NSDictionary *json = [MTLJSONAdapter JSONDictionaryFromModel:test error:nil];
                                    
                                    [TestModelDao shareInstance];
                                    TestModel *resultUser = nil;
                                    
                                    // Create the INSERT statement
//                                    NSString *stmt = [MTLFMDBAdapter insertStatementForModel:test];
//                                    NSArray *params = [MTLFMDBAdapter columnValues:test];
//                                    [[FMDBManager shareInstance] executeUpdate:stmt withArgumentsInArray:params];
                                    test.appid = nil;
                                    test.testModelID = [NSString generateUniqueString:@"TestModel"];
                                    [[FMDBManager shareInstance] insertInstance:test];

                                    NSArray *resultArr = [[FMDBManager shareInstance] executeQueryToArray:@"select * from TEST_MODEL_TABLE" withClass:TestModel.class];
                                    
                                    TestModel *test2 = resultArr[0];
                                    test2.appid = @"2";
                                    
                                    [[FMDBManager shareInstance] updateInstance:test2];
                                    
                                    resultArr = [[FMDBManager shareInstance] executeQueryToArray:@"select * from TEST_MODEL_TABLE" withClass:TestModel.class];
                                    
                                    NSLog(@"%@", ((TestModel *)resultArr[0]).appid);
                                    
                                    [[FMDBManager shareInstance] deleteInstance:test2];
                                    resultArr = [[FMDBManager shareInstance] executeQueryToArray:@"select * from TEST_MODEL_TABLE" withClass:TestModel.class];
                                    
                                    NSLog(@"%ld", resultArr.count);
    }];
}

- (void)addUser:(UIButton *)sender
{
}

- (void)show:(UIButton *)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
