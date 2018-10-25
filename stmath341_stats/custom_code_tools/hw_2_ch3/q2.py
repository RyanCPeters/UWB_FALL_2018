import json
import hw_2_ch3.data_cleaner as dclean
import numpy as np
#
# q2_name_list = ["Australia", "Brazil", "England", "Japan", "Korea", "Mexico", "Norway", "Sweden", "Taiwan", "United States"]
# q2_num_list = [2,1,1,2,9,1,1,2,2,4]
# data_list = [tpl for tpl in zip(q2_num_list, q2_name_list)]


# data_dict = {k:v for k,v in zip(q2_name_list,q2_num_list)}

def get_mean(data:list):
    mean = (sum(data)/len(data))
    print("The mean of the data set is {}/{} = {}".format(sum(data),len(data), mean))
    return mean

def _segment_median(data:list, strt:int, stp:int):
    lo = int(np.floor((strt+stp)/2))
    hi = int(np.ceil((strt+stp)/2))
    return (data[lo]+data[hi])/2, int((lo+hi)/2)

def get_median(data:list):
    med, midx = _segment_median(data,0,len(data))

    quart1,q1idx = _segment_median(data,0,midx)
    quart3, q3idx = _segment_median(data,midx, len(data))
    iqr = quart3 - quart1
    return (quart1,q1idx), (med, midx), (quart3,q3idx), iqr

if __name__ == "__main__":
    dcleaner = dclean.DataClean()
    data_list = dcleaner.get_data()
    data_list = [int(x) for x in data_list]
    # print(json.dumps(data_dict, indent=4))
    data_list.sort()
    mean_q2 = 0
    print("the cleaned up data_list is as follow:\n\t{}".format(data_list))

    mean1 = get_mean(data_list)
    quart1, med, quart3, iqr = get_median(data_list)

    print("the median for this data set is {}".format(med[0]))
    print("quartile 1 = {}, quartile 3 = {}, irq = {}".format(quart1[0], quart3[0], iqr))
    outliers = []
    upper_bound = quart3[0] + iqr*1.5
    lower_bound = quart1[0] - iqr*1.5
    tarpos = 0
    target = data_list[tarpos]
    while target<lower_bound and tarpos < len(data_list):
        tarpos += 1
        target = data_list[tarpos]
    lower_bound = target
    tarpos = len(data_list)-1
    target = data_list[tarpos]
    while target > upper_bound and tarpos >= 0:
        tarpos -= 1
        target = data_list[tarpos]
    upper_bound = target
    for val in data_list:
        if val > upper_bound or val < lower_bound:
            outliers.append(val)
    print("the boundary values are [{}, {}]".format(lower_bound,upper_bound))
    print("the outliers are:\n\t{}".format(outliers))
    if len(outliers) > 0:
        trunc_data = [val for val in data_list if val not in outliers]
        mean2 = get_mean(trunc_data)
        q1,m,q3,tiqr = get_median(trunc_data)
        print("the median for this data set is {}".format(m[0]))
