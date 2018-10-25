import json
import numpy as np

q1_list = [173,49,254,103,1901,258,237,62,748,403,67,55,652,276,143,127,163,219,52,295,379,384,270,97,244,36,90,126,60,487,80,1160,425,35,478,148,174,570,49,164,40,255,1207,115,26,424,340,65,248,39]
GREEN = "\x1b[32m"
RED = "\x1b[31m"
CYAN = "\x1b[96m"
RESET = "\x1b[m"

def get_mode():
    prnt_dct = dict()
    for val in q1_list:
        if val not in prnt_dct:
            prnt_dct[val] = 0
        prnt_dct[val] += 1
    print(json.dumps(prnt_dct, indent = 4))
    _max = q1_list[0]
    for key in prnt_dct:
        if prnt_dct[key] > prnt_dct[_max]:
            _max = key

    print("The mode for this data set is {} which occurs {} times".format(_max,prnt_dct[_max]))

def get_mean():
    print("The mean of the data set is {}/{} = {}".format(sum(q1_list),len(q1_list), (sum(q1_list)/len(q1_list))))

def get_median():
    med = (q1_list[(int(np.floor(len(q1_list)/2)))]+q1_list[(int(np.ceil(len(q1_list)/2)))])/2
    print("the median for this data set is {}".format(med))



if __name__ == "__main__":
    q1_list.sort()
    print(q1_list)
    inpt = int(input("please enter the value associated with the output you want:"
                 "\n\t{cyan}0{reset} -> gets the {green}MEAN{reset} of the data set"
                 "\n\t{cyan}1{reset} -> gets the {green}MEDIAN{reset} of the data set"
                 "\n\t{cyan}2{reset} -> gets the {green}MODE{reset} of the data set".format(cyan=CYAN, reset=RESET,green=GREEN )))
    while True:
        if inpt is 0:
            get_mean()
        elif inpt is 1:
            get_median()
        else:
            get_mode()
        inpt = int(input("please enter the value associated with the output you want:"
                 "\n\t{cyan}0{reset} -> gets the {green}MEAN{reset} of the data set"
                 "\n\t{cyan}1{reset} -> gets the {green}MEDIAN{reset} of the data set"
                 "\n\t{cyan}2{reset} -> gets the {green}MODE{reset} of the data set".format(cyan=CYAN, reset=RESET,green=GREEN )))
        if inpt not in [0,1,2]:
            break