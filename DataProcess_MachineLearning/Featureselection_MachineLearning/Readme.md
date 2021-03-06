#Content
* [Abstract](#abstract)
* [BER](#ber)
* [selectresult](#selectresult)
* [adaboost.py](#adaboost)
    * [loadDataSet(fileName)](#loaddataset)
    * [stumpClassify(dataMatrix,dimen,threshVal,threshIneq)](#stumpclassify)
    * [buildStump(dataArr,classLabels,D)](#buildStump)
    * [adaBoostTrainDS(dataArr,classLabels,numIt=40)](#adaboosttrainds)
    * [adaClassify(datToClass,classifierArr)](#adaclassify)
    * [plotROC(predStrengths, classLabels)](#plotroc)
    * [evaluatemodel(y_true,y_predict,proba)](#evaluatemodel)
* [ann.py](#ann)
    * [loadDataSet(filename)](#loaddataset)
    * [preprocess(dataset)](#preprocess)
    * [preprocess1(dataset)](#preprocess1)
    * [rowscale(dataset)](#rowscale)
    * [ANNClassifier(neuo,trainin,trainout,testin)](#annclassifier)
    * [SVMClassifier(trainin,trainout,testin)](#svmclassifier)
    * [evaluatemodel(y_true,y_predict,proba)](#evaluatemodel)
* [comparemodel.py](#comparemodel)  
* [final_eigen.csv](#final_eigen)
* [FS.py](#fs)  
* [FSscore.csv](#fsscore)
* [FSsort.csv](#fssort)
* [global_new.py](#global_new)
* [logRegres.py](#logregres)
    * [loadDataSet()](#loaddataset)
    * [sigmoid(inX)](#sigmoid)
    * [gradAscent(dataMatIn, classLabels)](#gradascent)
    * [plotBestFit(weights):](#plotbestfit(weights))
    * [stocGradAscent0(dataMatrix, classLabels)](#stocgradascent0)
    * [stocGradAscent1(dataMatrix, classLabels, numIter=150)](#stocgradascent1)
    * [classifyVector(inX, weights)](#classifyvector)
    * [classifyProb(inX, weights)](#classifyprob)
    * [colicTest()](#colictest)
    * [multiTest()](#multites)
* [resultplot.py](#resultplot)
* [sortedFeature.csv](#sortedfeature)
* [testann.py](#testann)
* [ttestcross.py](#testcross)
* [testLR.py](#testlr)
* [testSVM.py](#testsvm)


## abstract
    本文件夹中包含神经网络、AdaBoost、逻辑回归、支持向量机算法的实现及测试程序
    
## ber
    BER文件夹下的csv文件为四中机器学习算法对应全部特征值“_all”、BER最小时特征值子集"_min"、
    以及特征值数目最小时"_ks"对应的测试集十折交叉验证的各评价指标结果
    
## selectresult
    本文件夹中的 csv文件主要记录的是特征值按照重要性（由Gini_index、
    Fisher_score、ReliefF算法共同确定）排序后逐个累加代入各个模型中，
    得到的BER平均值及标准差的变化过程  
    
## adaboost
    AdaBoost算法的实现
    
### loaddataset
    '''
    loaddataset(filename)
    从txt中导入数据和标签，最后一列为标签
    '''  
    
### stumpclassify
    '''
    stumpclassify(datamatrix,dimen,threshval,threshIneq)
    Description:
        按照单一的特征进行分类
    Input:
        dataMatrix:输入的特征值矩阵，多列的
     dimen:表示用哪一列特征进行分类
     threshVal:分类的阈值
     threshIneq:用小于号还是大于等于号进行分类
    Output:
        retArray:分类的结果
    '''
    
### buildstump
    """
    buildstump(dataarr,classlabels,d)
    Description:
     构建单层决策树
    Input:
        dataArr：输入特征值矩阵
     classLabels：标签
     D：每个样本的权重
    Output:
         bestStump：最优决策树包括：特征值、分类阈值、分类符号
        minError：最优决策树对应的分类误差
         bestClasEst：最优决策树对应的分类结果
    """
### adaboostTrainds
    """
    adaboostTrainds(dataarr,classlabels,numIt=40)
    Description:
        1.AdaBoost算法训练，刚开始时初始化每个样本的权重D为相等的（样本数目分之一）
        2.调用buildStump函数寻找出当前D值下的最优单程决策树，即一个弱分类器
        3.计算该弱分类器在强分类器中的权重a
        4.根据弱分类器的分类误差调整各个样本的权重D
        5.当前弱分类器叠加到强分类器中，计算当前分类结果
        6.如果误差满足要求或达到预设迭代次数，停止训练
    Input:
        dataArr：特征值矩阵
        classLabels：标签
        numIt=40：迭代次数，即弱分类器的个数，默认40个
    Output:
        weakClassArr：输出的弱分类器，每个弱分类器对应有：所用的特征值、分类阈值、分类符号、弱分类器的权重
        aggClassEst：分类的结果,概率值
    """
### adaclassify
    Description:
    adaclassify(datToclass,classifierarr)
        应用训练好的弱分类器进行分类
    Input:
     datToClass：需要进行分类的数据，测试集数据
     classifierArr：弱分类器集合
    Output:
        sign(aggClassEst)：分类的结果，标签
        aggClassEst：分类的结果，概率值
### plotroc
    Description:
    plotroc(predstrengths,classlabels)
     绘制ROC曲线并求曲线下面积
    Input：
        predStrengths：预测值，概率
         classLabels：实际标签
    Output:
          ySum*xStep：曲线下面积
### evaluatemodel
    Description:
    evaluatemodel(y_true,y_predict,proba)
        分类模型评价指标
    Input:
         y_true:实际标签
         y_predict:预测结果
        proba:预测概率值
    Output:
         [[TPR,SPC,PPV,NPV,ACC,AUC,BER]]:各评价指标
         [[tn,fp,fn,tp]]:混淆矩阵
         
## ann
    包含神经网络分类器、支持向量机分类器、模型评价等
    
### loaddataset
    loaddataset(filename)
    加载txt格式的数据文件
### preprocess
    preprocess(dataset)
    将特征值规范化到[0,1]之间
### preprocess1
    preprocess1(dataset)
    normalize the data between -1 and 1
### rowscale
    rowscale(dataset)
    normalize the data between -1 and 1 according to row
    按行归一化，默认的按列
### annclassifier
    annclassifier(neuo,trainin,trainout,testin)
    Description:
        神经网络分类器
    Input:
        trainin:训练集输入数据
        trainout:训练集标签
        testin:测试集输入数据
    output:
        train_predict:对训练集数据的预测结果，0，1标签
        test_predict:对测试集数据的预测结果，0，1标签
        proba_train:对训练集数据的预测结果，概率值
        proba_test:对测试集数据的预测结果，概率值
### svmclassifier
    svmclassifier(trainin,trainout,testin)
    Description:
        支持向量机分类器
    Input:
        trainin:训练集输入数据
        trainout:训练集标签
        testin:测试集输入数据
    output:
        train_predict:对训练集数据的预测结果，0，1标签
        test_predict:对测试集数据的预测结果，0，1标签
        proba_train:对训练集数据的预测结果，概率值
        proba_test:对测试集数据的预测结果，概率值
        weights：各个特征值对应的权重
### evaluatemodel
    evaluatemodel(y_true,y_predict,proba)
    Description:
        分类模型评价指标
    Input:
        y_true:实际标签
        y_predict:预测结果
        proba:预测概率值
    Output:
        [[TPR,SPC,PPV,NPV,ACC,AUC,BER]]:各评价指标
        [[tn,fp,fn,tp]]:混淆矩阵
## comparemodel
    Description:
        1. 本程序主要比较同一评价指标对于不同分类算法的结果
        2. 最后绘制箱线图进行表示，横轴表示四种机器学习算法及MEWS评分，
            纵轴表示某一评价指标
## final_eigen
    特征值矩阵
    
## fs
    Description：
        1.首先计算Relief、Fisher-score、Gini_index三个得分值，归一化后叠加到一起得到最终分值
        2.根据叠加后的分值对特征值进行排序
        3.根据排序结果逐个增加特征值，得到BER平均值及std的变化曲线并进行保存
            注意：1.对于AdaBoost算法，只能区分1，-1标签
                       2. 对于逻辑回归，第一项是常数项，在每折中添加
        4.大段注释掉的是自己按照文献公式复原的相关性系数和Fisher-score得分
        5.最终进行特则选择使用的是scikit-feature包
    OutputMessage:
        sorteigen：记录的是各个方法得到的特征值评分以及根据整合后评分进行排序后的结果，
                        对应FSsort.csv
        sortFeatures:是根据sorteigen的结果对全部特征值进行排序，用于最终模型的训练，对应
                        sortedFeature.csv文件
        writemean：逐步增加特征值个数时，当前算法对应的BER平均值
        writestd：逐步增加特征值个数时，当前算法对应的BER标准差
## fsscore
    记录的是特征值对应的各个特征选择方法的得分值以及最终的组合分值
    特征值的排列顺序不变
## fssort
    数据跟上面的FSscore.csv是一样的，只不过特征值是按照组合得分进行排序的
## global_new
    Description：
        提取特征值，对哑变量性别进行处理，然后进行归一化
        0——79列是特征值，最后一列是标签

    输入信息：
        final_eigen.csv:特征值矩阵
    输出结果：
        framefile: 处理完哑变量后的，归一化到[0,1]之间的各个特征值及标签
## logregres
    逻辑回归的实现过程
###  loaddataSet
    loaddataSet()
    Description:
        加载数据
    Output:
        datamat:特征值矩阵
        labelmat:标签
### sigmoid
    sigmoid(inx)
    Description:
        S 函数
    Input:
        inX：输入数据
    Output:
        S函数变换后的结果
### gradascent
    gradascent(datamatIn,classlabels)
    Description:
        梯度上升算法
    Input:
        dataMatIn：输入的特征值矩阵
        classLabels：类别标签
    Output:
        weights：梯度上升算法训练后返回的权重向量
### plotbestfit
    plotbestfit(weights)
    Description:
        根据权重，绘制分类结果
    Input:
        weights：梯度上升算法训练后返回的权重向量
    Output:
        在图中画出两类样本及分类直线
### stocgradascent0
    stocgradascent0(datamatrix,classlabels)
    Description:
        随机梯度上升算法，相比于本文件里上面的梯度上升算法，此处的算法每次只用
        一个样本来更新权重，上面的那个每次都用全部样本更新权重，更新速度慢
    Input:
        dataMatrix:特征值矩阵
        classLabels:标签
    Output:
        weights：随机梯度上升算法训练后返回的权重向量
### stocgradascent1
    stocgradascent1(datamatrix,classlabels,numIter=150)
    Description:
        改进的随机梯度上升算法，相比于本文件里上面的随机梯度上升算法，此处的算法每次随机选择
        一个样本来更新权重，已选中的删除，下次不再选择，并且更新权重时增加了一个权值
    Input:
        dataMatrix:特征值矩阵
        classLabels:标签
    Output:
        weights：改进随机梯度上升算法训练后返回的权重向量
### classifyvector
    classifyvector(inx,weights)
    Description:
        根据随机梯度上升算法训练得到的权值进行分类
    Input:
        inX:待分类特征值矩阵
        weights：改进随机梯度上升算法训练后返回的权重向量
    Output:
        分类标签
### classifyprob
    classifyprob(inx,weights)
    Description:
        根据随机梯度上升算法训练得到的权值进行分类
    Input:
        inX:待分类特征值矩阵
        weights：改进随机梯度上升算法训练后返回的权重向量
    Output:
        分类概率值
### colictest
    colictest()
    Description:
        逻辑回归的应用示例
### multitest
    multitest()
    Description:
        累计误差
## resultplot
    Description:
        1.对于ANN、AdaBoost、LR、SVM四种算法逐步增加特征值后BER的平均值及标准差，
        绘制变化过程曲线，数据文件在selectresult文件夹中
        2.找到每种算法BERmean的最小值，然后找到第一个落在最小值加减标准差范围内的索引值
         注：这里的索引值的就是实际的个数，是从1 开始的
    Output message：
        stdvalue:BER的标准差
        meanvalue：BER的平均值
        minindex：BER最小值索引（从1 开始的）
        minvalue：BER最小值
        up：BER最小值位置的上限（minvalue+对应的标准差）
        down：BER最小值位置的下限
        a：up、down范围内的最小特征值数目
        tmp：a对应的BER值
## sortedfeature
    按照特征值重要性进行排序后的特征值矩阵
## testann
    Description:
        本程序为神经网络算法的运行程序
    输入参数：
        sortedFeatures.csv:按照重要性排序后的特征值

    重要的中间变量：
        train_predict：训练后的模型对训练集的预测标签
        test_predict：训练后的模型对测试集的预测标签
        proba_train：模型对训练集的预测概率值（相加为1的两列）
        proba_test：模型对测试集的预测概率值（相加为1的两列）

    输出结果：
        evaluate_train：各折训练集的各个评价指标，最后两行分别为平均值及标准差
        evaluate_test：各折测试集的各个评价指标，最后两行分别为平均值及标准差
        prenum_train：各折训练集混淆矩阵的结果
        prenum_test：各折测试集混淆矩阵的结果
## testcross
     Description:
        本程序为AdaBoost算法的运行程序
    输入参数：
        sortedFeatures.csv:按照重要性排序后的特征值

    重要的中间变量：
        train_predict：训练后的模型对训练集的预测标签
        test_predict：训练后的模型对测试集的预测标签
        proba_train：模型对训练集的预测概率值（相加为1的两列）
        proba_test：模型对测试集的预测概率值（相加为1的两列）

    输出结果：
        evaluate_train：各折训练集的各个评价指标，最后两行分别为平均值及标准差
        evaluate_test：各折测试集的各个评价指标，最后两行分别为平均值及标准差
        prenum_train：各折训练集混淆矩阵的结果
        prenum_test：各折测试集混淆矩阵的结果
## testlr
     Description:
        本程序为逻辑回归算法的运行程序
    输入参数：
        sortedFeatures.csv:按照重要性排序后的特征值

    重要的中间变量：
        train_predict：训练后的模型对训练集的预测标签
        test_predict：训练后的模型对测试集的预测标签
        proba_train：模型对训练集的预测概率值（相加为1的两列）
        proba_test：模型对测试集的预测概率值（相加为1的两列）

    输出结果：
        evaluate_train：各折训练集的各个评价指标，最后两行分别为平均值及标准差
        evaluate_test：各折测试集的各个评价指标，最后两行分别为平均值及标准差
        prenum_train：各折训练集混淆矩阵的结果
        prenum_test：各折测试集混淆矩阵的结果
## testsvm
     Description:
        本程序为支持向量机算法的运行程序
    输入参数：
        sortedFeatures.csv:按照重要性排序后的特征值

    重要的中间变量：
        train_predict：训练后的模型对训练集的预测标签
        test_predict：训练后的模型对测试集的预测标签
        proba_train：模型对训练集的预测概率值（相加为1的两列）
        proba_test：模型对测试集的预测概率值（相加为1的两列）

    输出结果：
        evaluate_train：各折训练集的各个评价指标，最后两行分别为平均值及标准差
        evaluate_test：各折测试集的各个评价指标，最后两行分别为平均值及标准差
        prenum_train：各折训练集混淆矩阵的结果
        prenum_test：各折测试集混淆矩阵的结果   
 