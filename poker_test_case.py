import random


card_dict = {1: 'A C', 2: '2 C', 3: '3 C', 4: '4 C', 5: '5 C', 6: '6 C', 7: '7 C', 8: '8 C', 9: '9 C', 10: '10 C',
            11: 'J C', 12: 'Q C', 13: 'K C', 14: 'A D', 15: '2 D', 16: '3 D', 17: '4 D', 18: '5 D', 19: '6 D', 20: '7 D',
            21: '8 D', 22: '9 D', 23: '10 D', 24: 'J D', 25: 'Q D', 26: 'K D', 27: 'A H', 28: '2 H', 29: '3 H', 30: '4 H',
            31: '5 H', 32: '6 H', 33: '7 H', 34: '8 H', 35: '9 H', 36: '10 H', 37: 'J H', 38: 'Q H', 39: 'K H',
            40: 'A S', 41: '2 S', 42: '3 S', 43: '4 S', 44: '5 S', 45: '6 S', 46: '7 S', 47: '8 S', 48: '9 S', 49: '10 S',
            50: 'J S', 51: 'Q S', 52: 'K S'}


def generate_n_testcases(n):
    for i in range(n):
        input = generate_input()
        hand1, hand2 = split_input(input)
        hand1 = [card_dict[i] for i in hand1]
        hand2 = [card_dict[i] for i in hand2]

        print('Input: {} Hand 1: {} Hand 2: {}'.format(input, hand1, hand2))
        print()


def generate_input():
    input=[]
    for i in range(10):
        card = random.randint(1, 52)
        while card in input:
            card = random.randint(1, 52)
        input.append(card)

    return input


def split_input(input):
    hand1 = []
    hand2 = []
    for i in range(10):
        if i % 2 == 0:
            hand1.append(input[i])
        else:
            hand2.append(input[i])
    return sorted(hand1), sorted(hand2)


def card_list(hand1, hand2):
    res = []
    for i in range(5):
        res.append(hand1[i])
        res.append(hand2[i])
    return res


generate_n_testcases(20)