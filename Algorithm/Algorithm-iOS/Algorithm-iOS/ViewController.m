//
//  ViewController.m
//  Algorithm-iOS
//
//  Created by zhi on 2019/9/16.
//  Copyright © 2019 zhi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *muArr = [NSMutableArray arrayWithObjects:@(2),@(5),@(1),@(12),@(8), nil];
//    [self buddleSort:muArr]; 冒泡排序
//    [self quickSort:muArr];//快速排序
    [self mergeSort:muArr]; //归并排序
}

#pragma mark -- buddle Sort
/**
 冒泡排序： 可以想象成一个水杯中的泡泡，大的泡泡会依次向上冒
 对于这个简单的排序，直接上代码
 **/

- (void)buddleSort:(NSMutableArray *)mutArr
{
    if (mutArr.count == 0 || mutArr == nil) {
        return;
    }
    for (int i = 0; i < [mutArr count] - 1; i++){
        for (int j = 0; j < [mutArr count] - i - 1; j++) {
            NSString *s1 = mutArr[i];
            NSString *s2 = mutArr[j];
            NSInteger i1 = [s1 integerValue];
            NSInteger i2 = [s2 integerValue];
            if (i1 > i2) {
                [mutArr replaceObjectAtIndex:j withObject:s2];
                [mutArr replaceObjectAtIndex:j + 1 withObject:s1];
            }
        }
    }
      NSLog(@"排序后的结果：%@", [mutArr componentsJoinedByString:@","]);
}

#pragma mark -- quickSort
/**
 这里是快速排序，关于快速排序的简单思想是这样的
 我们这边直接使用数组进行排序，下面是对于快速排序的简单思路
 
 在对一个数组进行排序之前，我们可以通过分治算法来寻找到一个相应的枢纽元，将数组分成两个部分，分别对枢纽元的左右两边进行排序，这里会用到划分算法进行递归处理
 在C++ 和 C语言中都有相应的快速排序函数，但是又有些许区别，在C语言中，sort函数不仅仅是简单的快速排序大致是这样的(快速排序+ 堆排序+插入排序)
 
 如果有兴趣还可以去看《算法》这本书，毕竟作者是专业搞快速排序的
 */

// 以下是快速排序的简单实现，当然这里并不是最正统的快速排序，具体需要再参看《算法》中的实现
-(NSArray *)quickSort:(NSMutableArray *)unsortedDataArray
{
    NSUInteger quickSortCount = 0;

    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
    NSMutableArray *greaterArray =[[NSMutableArray alloc] init];
    if ([unsortedDataArray count] <1)
    {
        return nil;
    }
    int randomPivotPoint = arc4random() % [unsortedDataArray count];
    NSNumber *pivotValue = [unsortedDataArray objectAtIndex:randomPivotPoint];
    [unsortedDataArray removeObjectAtIndex:randomPivotPoint];
    for (NSNumber *num in unsortedDataArray)
    {
        quickSortCount++; //查看使用快速排序对数组进行排序所需的迭代次数
        if (num < pivotValue)
        {
            [lessArray addObject:num];
        }
        else
        {
            [greaterArray addObject:num];
        }
    }
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    [sortedArray addObjectsFromArray:[self quickSort:lessArray]];
    [sortedArray addObject:pivotValue];
    [sortedArray addObjectsFromArray:[self quickSort:greaterArray]];
    return sortedArray;
}


#pragma mark -- 归并排序
-(NSArray *)mergeSort:(NSArray *)unsortedArray
{
    if ([unsortedArray count] < 2)
    {
        return unsortedArray;
    }
    long middle = ([unsortedArray count]/2);
    NSRange left = NSMakeRange(0, middle);
    NSRange right = NSMakeRange(middle, ([unsortedArray count] - middle));
    NSArray *rightArr = [unsortedArray subarrayWithRange:right];
    NSArray *leftArr = [unsortedArray subarrayWithRange:left];
    NSArray *resultArray =[self merge:[self mergeSort:leftArr] andRight:[self mergeSort:rightArr]];
    return resultArray;
}

-(NSArray *)merge:(NSArray *)leftArr andRight:(NSArray *)rightArr
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int right = 0;
    int left = 0;
    while (left < [leftArr count] && right < [rightArr count])
    {
        if ([[leftArr objectAtIndex:left] intValue] < [[rightArr objectAtIndex:right] intValue])
        {
            [result addObject:[leftArr objectAtIndex:left++]];
        }
        else
        {
            [result addObject:[rightArr objectAtIndex:right++]];
        }
    }
    NSRange leftRange = NSMakeRange(left, ([leftArr count] - left));
    NSRange rightRange = NSMakeRange(right, ([rightArr count] - right));
    NSArray *newRight = [rightArr subarrayWithRange:rightRange];
    NSArray *newLeft = [leftArr subarrayWithRange:leftRange];
    newLeft = [result arrayByAddingObjectsFromArray:newLeft];
    return [newLeft arrayByAddingObjectsFromArray:newRight];
}


#pragma mark -- 遍历二叉树
//遍历二叉树有四种方法，现在写最基本的三种，循环、递归、层次遍历（类似广度优先搜索）、深度遍历
//遍历二叉树又分成前序、中序、后序，这里的前中后最主要的区别在于根节点所在的位置来定义

/**忽然发现利用OC来构建二叉树实在是太费劲了，如果想要用Objective-c 来构建二叉树可以尝试看看这个地址https://github.com/agnosticdev/Tutorials/tree/master/HowToCreateABinaryTreeInObjectiveC
 */

// 我觉得还是使用C++ 比较好，如果你没有C++的基础也没有关系，我觉得这里只会用到简单的C++语法，并不会再放在


@end
