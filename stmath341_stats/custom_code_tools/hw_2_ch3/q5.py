import hw_2_ch3.data_cleaner as dclean

def get_std_devs(data:list):
    rang = data[-1] - data[0]
    summ = sum(data)
    n = len(data)
    avg = summ / n
    summ_x_sqr = sum([x * x for x in data])
    variance = (sum([x * x for x in data]) - ((summ * summ) / n)) / n
    std_dev = variance ** (1 / 2)

    return summ_x_sqr,summ,n,avg, rang, variance, std_dev

def main():
    dcleaner = dclean.DataClean()
    data = dcleaner.get_data()
    data = [int(val) for val in data]
    data.sort()
    print("The data set we will use for calculating the range, variance, and standard deviation (std_dev) is:\n\t{}".format(data))
    summ_x_sqr, summ, n, avg, rang, variance, std_dev = get_std_devs(data)

    print(summ_x_sqr)
    print("sum: {}\nn: {}\navg: {}".format(summ,n,avg))

    print("The range is: {}\nThe variance is: {}\nThe std_dev is: {}".format(rang,variance,std_dev))

if __name__ == "__main__":
    main()

