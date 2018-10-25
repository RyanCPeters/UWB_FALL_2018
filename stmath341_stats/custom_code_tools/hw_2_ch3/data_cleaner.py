import re
class DataClean:
    def get_data(self):

        inpt = re.split(r'\W+', input("Please paste a copy of the data you wish to use"))
        inpt = [val for val in inpt if len(val) > 0]
        negs = []
        for i,val in enumerate(inpt):
            if 'neg' in val:
                negs.append(i)

        negs.reverse()
        for i in negs:
            inpt[i] = int(inpt[i+1])*(-1)
            inpt.pop(i+1)

        print(inpt)
        return inpt

if __name__ == "__main__":
    data = DataClean().get_data()

