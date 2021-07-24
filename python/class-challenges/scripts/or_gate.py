# Built-int imports 
import sys
import argparse

# External imports
import numpy as np


class OrGate:
    """
    Class created to implement at low level the learning of a small neural network
    this network is of the perceptron type and it's goal is achieve the behavior of
    an OR logic gate.
    """
    def __init__(self, alpha, loops):
        self.__dataset = np.array(
            [
                [1, 0, 0, 0],
                [1, 1, 0, 1],
                [1, 0, 1, 1],
                [1, 1, 1, 1]
            ]
        )

        self.__alpha = alpha
        self.__loops = loops
        self.__weights = np.array([[0.5,1,0]])
        self.__m_s_error_k = list()
        self.__output = list()
        self.__iteration = list()

    def activation_function(self, output):
        if (output >= 0):
            return 1
        return 0

    def error(self, output, objetive):
        return (objetive - output)  

    def mean_square_error_k(self, error):
        return (0.5*error**2)

    def upgrate_weight(self, weight, error, input):
        return (weight + self.__alpha*error*input)

    def network_tranning(self):
        k_ads = 0
        for i in iter(range(self.__loops)):
            for k in iter(range(self.__dataset.shape[0])):
                self.__iteration.append(k_ads)
                a_k = np.dot(self.__dataset[k,:3], self.__weights[k_ads])
                
                y_k = self.activation_function(a_k)
                self.__output.append(y_k)
                
                e_k = self.error(y_k, self.__dataset[k,3])

                ecm_k = self.mean_square_error_k(e_k)
                self.__m_s_error_k.append(ecm_k)
                
                weights_k_1 = np.array([[self.upgrate_weight(
                    self.__weights[k_ads,x],
                    e_k,
                    self.__dataset[k,x]
                ) for x in [0,1,2]]])
                if not((k == self.__dataset.shape[0]-1) and (i == self.__loops-1)):
                    self.__weights = np.concatenate((self.__weights,weights_k_1),axis=0)
                k_ads += 1

            if (i == 0):
                self.__m_s_error = sum(self.__m_s_error_k)       
            else:
                self.__m_s_error = sum(self.__m_s_error_k[(k_ads-5):])       
            print(f"ecm: {self.__m_s_error}")
        
        print(f"ecm_k:{self.__m_s_error_k}")
        print(f"weights:\n {self.__weights}")

def main():
    """SMART SYSTEMS - EIA UNIVERSITY
    First challenge of the EIA University's smart systems class.
    Run this scripts in order to see Elkin Guerra's solucion 
    of this test. 
    """
    epilog = """
    Related examples:
    More to come...
    """
    arg_fmt = argparse.RawDescriptionHelpFormatter
    parser = argparse.ArgumentParser(formatter_class=arg_fmt,
        description=main.__doc__,
        epilog=epilog
    )
    required = parser.add_argument_group('required arguments')
    required.add_argument(
        '-a', '--alpha', dest='alpha', required=True,
        help='The learning power (alpha) to be used '
    )

    required.add_argument(
        '-l', '--loops', dest='loops', required=True,
        help='number of times the dataset is gonna be traversed'
    )


    args = parser.parse_args()

    print("Initializing program... ")
    or_gate = OrGate(float(args.alpha), int(args.loops))

    or_gate.network_tranning()

    return 0


if __name__=='__main__':
    sys.exit(main())