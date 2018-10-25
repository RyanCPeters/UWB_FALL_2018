import matplotlib.pyplot as plt
import numpy as np


class CalcPlayerAPlot:

    def calculate_winnings(self, dice_sides:int=6):
        pay_outs = []
        cumulative_values = []
        x_vals = []
        zero_to_seven_x = []
        zero_to_seven_data = []
        cumsum = [0,0,0]
        zero_to_seven = lambda x: (((x-1)/(dice_sides**2))*(x-8))
        for x in range(2,8):
            zero_to_seven_x.append(x)
            zero_to_seven_data.append(zero_to_seven(x))
            x_vals.append(x)
            cumsum[0] += zero_to_seven(x)
            cumsum[1] += zero_to_seven(x)
            pay_outs.append(zero_to_seven(x))
            cumulative_values.append(cumsum[0])

        nine_to_12_data = []
        nine_t0_12_x = []
        zero_to_seven_x.append(8)
        zero_to_seven_data.append(0)
        nine_to_12_data.append(0)
        nine_t0_12_x.append(8)
        pay_outs.append(0)
        cumulative_values.append(cumsum[0])
        x_vals.append(8)
        nine_to_12 = lambda die,occ: (occ/(dice_sides**2))*(die-8)
        for dice,occurance in zip(range(9,13),range(5,0,-1)):
            nine_t0_12_x.append(dice)
            nine_to_12_data.append(nine_to_12(dice,occurance))
            x_vals.append(dice)
            cumsum[0] += nine_to_12(dice,occurance)
            cumsum[2] += nine_to_12(dice,occurance)
            pay_outs.append(nine_to_12(dice,occurance))
            cumulative_values.append(cumsum[0])
        return (cumsum, # 0
                x_vals, # 1
                cumulative_values, # 2
                pay_outs, # 3
                zero_to_seven_x, # 4
                zero_to_seven_data, # 5
                nine_t0_12_x, # 6
                nine_to_12_data) # 7

    def plot_winnings(self,dice_sides:int=6):
        results_tuple = self.calculate_winnings(dice_sides)
        print("the expected total winnings appears to be {}".format(results_tuple[0]))
        plt.figure(1)
        f, axx = plt.subplots(3,sharex=True)
        axx[0].plot(results_tuple[1],results_tuple[2],"r*",label="cumulative dice_values*probability payout")
        axx[0].set_title("cumulative sum of return values for dice rolls staring at 2 and ending at 12")
        # share x only
        axx[1].plot(results_tuple[1], results_tuple[3],"b+",label="discrete dice_values*probability payout")
        axx[1].set_title("player A averaged payouts for each possible dice result ")
        axx[2].plot(results_tuple[1],results_tuple[2],"r*")
        axx[2].tick_params('y', colors='r')
        ax = axx[2].twinx()
        ax.plot(results_tuple[1], results_tuple[3],"b+")
        ax.tick_params('y',colors='b')
        axx[2].set_title("combined plots on one graph")
        plt.legend()

        plt.xlabel("dice values")
        plt.show()
        plt.figure(2)
        f2, axx2 = plt.subplots(1,2, sharey=True)
        axx2[0].set_title("just payout averages for 0 to 8")
        axx2[0].plot(results_tuple[4], results_tuple[5])
        axx2[1].plot(results_tuple[6], results_tuple[7])
        axx2[1].set_title("just payout averages for 8 to 12")
        plt.xlabel("dice values")
        plt.show()

if __name__ == "__main__":
    CalcPlayerAPlot().plot_winnings(6)