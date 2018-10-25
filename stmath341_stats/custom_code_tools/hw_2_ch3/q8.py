import hw_2_ch3.data_cleaner as dclean
import numpy as np


def get_mean(data:list):
    mean = (sum(data)/len(data))
    print("The mean of the data set is {}/{} = {}".format(sum(data),len(data), mean))
    return mean

def _segment_median(data:list, strt:int, stp:int):
    lo = int(np.floor((strt+stp)/2))
    hi = int(np.ceil((strt+stp)/2))
    return (data[lo]+data[hi])/2, int((lo+hi)/2)

def get_median(data:list):
    data.sort()
    med, midx = _segment_median(data,0,len(data))

    quart1,q1idx = _segment_median(data,0,midx)
    quart3, q3idx = _segment_median(data,midx, len(data))
    iqr = quart3 - quart1
    return (quart1,q1idx), (med, midx), (quart3,q3idx), iqr

def count_std_devs(mean:float, std_dev:float, target:int)-> int:
    count = 0
    val = mean
    while val < target:
        val += std_dev
        count += 1
    return count

def get_std_devs(data: list):
    rang = data[-1] - data[0]
    summ = sum(data)
    n = len(data)
    avg = summ / n
    summ_x_sqr = sum([x * x for x in data])
    squared_sums = (summ * summ)
    pop_variance = (summ_x_sqr - (squared_sums / n)) / n
    samp_variance = (summ_x_sqr - (squared_sums / n)) / (n-1)
    pop_std_dev = pop_variance ** (1 / 2)
    samp_std_dev = samp_variance ** (1 / 2)
    return summ_x_sqr, summ, n, avg, rang, pop_variance,samp_variance, pop_std_dev, samp_std_dev

def main():
    dcleaner = dclean.DataClean()
    family_count = dcleaner.get_data()
    family_count = [int(cnt) for cnt in family_count]
    bill_low = dcleaner.get_data()
    bill_high = dcleaner.get_data()
    bill_range = [(int(lo),int(hi)) for lo,hi in zip(bill_low,bill_high)]
    data = [(num,rng) for num,rng in zip(family_count,bill_range)]
    data.sort(key=lambda tpl:tpl[1][0])
    print("The data set we will use for calculating the range, variance, and standard deviation (std_dev) is:\n\t{}".format(data))
    summ_x_sqr, summ, n, avg, rang, pop_variance, samp_variance, pop_std_dev, samp_std_dev = get_std_devs([x[0] for x in data])
    print("For population:\n\tThe range is: {}\n\tThe variance is: {}\n\tThe std_dev is: {}".format(rang, pop_variance, pop_std_dev))
    print("For sample:\n\tThe range is: {}\n\tThe variance is: {}\n\tThe std_dev is: {}".format(rang, samp_variance, samp_std_dev))
    mean = get_mean([x[0] for x in data])
    count = count_std_devs(mean,samp_std_dev,173)
    print("173 is {} standard deviations from the mean".format(count))
    q1, med, q3, iqr = get_median([x[0] for x in data])
    print("the median for this data set is {}".format(med[0]))
    print("quartile 1 = {}, quartile 3 = {}, irq = {}".format(q1[0], q3[0], iqr))



if __name__ == "__main__":
    main()

