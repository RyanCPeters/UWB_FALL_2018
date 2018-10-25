import hw_2_ch3.data_cleaner as dclean
import time

def main():
    dcleaner = dclean.DataClean()
    print("first, enter the score values for exam1, exam2, and the final")
    time.sleep(.5)
    data = dcleaner.get_data()

    print("Now, enter the associated weights, and sorry but you also need to enter any repeat values")
    time.sleep(.5)
    weights = dcleaner.get_data()
    data = [int(val) for val in data]
    weights = [int(val) for val in weights]

    print("data converted to int values is now:\n\t{}".format(data))
    print("weights converted to int values is now:\n\t{}".format(weights))

    wmean = sum([x*w for x,w in zip(data,weights)])/sum(weights)
    print("the calculated weighted mean is then {}".format(wmean))


if __name__ == "__main__":
    main()