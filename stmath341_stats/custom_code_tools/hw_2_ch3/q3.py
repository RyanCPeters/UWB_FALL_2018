

data = [49,52,43,28,42,30,35,19,65,40]
data.sort()


def get_mean(data: list):
    mean = (sum(data) / len(data))
    print("The mean of the data set is {}/{} = {}".format(sum(data), len(data), mean))
    return mean

if __name__ == "__main__":
    print("initial data is:\n\t{}".format(data))
    trim_amount = int(input("please enter the % of the data to be trimmed as an integer. E.G. enter 10 to trim 10% off the dataset"))
    trim_amount = int(len(data)/trim_amount)
    print("the number of data entries to be trimmed from each end is: {}".format(trim_amount))
    data_trimmed = data[trim_amount:-trim_amount]
    print("the trimmed data is now:\n\t{}".format(data_trimmed))
    get_mean(data_trimmed)

