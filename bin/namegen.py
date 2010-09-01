#!/usr/bin/python
from random import choice
import sys, getopt, re

vowels = [ 'a', 'e', 'i', 'o', 'u', 'y' ]

syllable = ['ach', 'ack', 'ad', 'age', 'ald', 'ale', 'an', 'ang', 'ar', 'ard', 'as', 'ash', 'at', 'ath', 'augh',
     'aw', 'ban', 'bel', 'bur', 'cer', 'cha', 'che', 'dan', 'dar', 'del', 'den', 'dra', 'dyn', 'ech',
     'eld', 'elm', 'em', 'en', 'end', 'eng', 'enth', 'er', 'ess', 'est', 'et', 'gar', 'gha', 'hat',
     'hin', 'hon', 'ia', 'ight', 'ild', 'im', 'ina', 'ine', 'ing', 'ir', 'is', 'iss', 'it', 'kal', 'kel',
     'kim', 'kin', 'ler', 'lor', 'lye', 'mor', 'mos', 'nal', 'ny', 'nys', 'old', 'om', 'on', 'or', 'orm',
     'os', 'ough', 'per', 'pol', 'qua', 'que', 'rad', 'rak', 'ran', 'ray', 'ril', 'ris', 'rod',
     'roth', 'ryn', 'sam', 'say', 'ser', 'shy', 'skel', 'sul', 'tai', 'tan', 'tas', 'ther', 'tia',
     'tin', 'ton', 'tor', 'tur', 'um', 'und', 'unt', 'urn', 'usk', 'ust', 'ver', 'ves', 'vor', 'war',
     'wor', 'yer']

longvowels = [  'ae', 'ai', 'au', 'ay', 'ea', 'ee', 'ei', 'eu',
                'ey', 'ia', 'ie', 'oe', 'oi', 'oo', 'ou', 'ui' ]

consonants = [  'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 
                'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z'        ]

longconsonants = [  'ch', 'ck', 'gh', 'ld', 'll', 'lt', 'nd',
                    'nn', 'nt', 'ph', 'rd', 'rr', 'rt', 'sh', 'ss', 'st', 'th']

Beginningsyllables = [   'b', 'bl', 'br', 'c', 'ch', 'chr', 'cl', 'cr', 'd', 
        'dr', 'f', 'g', 'h', 'j', 'k', 'l', 'll', 'm', 
        'n', 'p', 'ph', 'qu', 'r', 'rh', 's', 'sch', 
        'sh', 'sl', 'sm', 'sn', 'st', 'str', 'sw', 't', 
        'th', 'thr', 'tr', 'v', 'w', 'wh', 'y', 'z', 'zh'       ]



def usage():
    print """
Generates random names according to a pattern.
Default pattern is "23233" (consonant, vowel, consonant, vowel, vowel)

Options:
    -h|--help                           Shows this usage information.
    -p 'pattern'|--pattern='pattern'    Overrides the default pattern.
    
        Keywords for the pattern are:
            1   a list of syllables suitable for the beginning of the word
            2   Consonant
            3   Vowel
            4   a long list of syllables
            5   another list of vowels (with diphtongs etc)
            6   another list of (mostly two or three letter consonants)
            '   a literal apostrophe

"""

def givename(pattern):
    name = []
    for x in list(pattern):
        if not (name):
            if x == '1':
                name.append(choice(Beginningsyllables))
                continue
        if x == '2':
            name.append(choice(consonants))
            continue
        if x == '3':
            name.append(choice(vowels))
            continue
        if x == '4':
            name.append(choice(syllable))
            continue
        if x == '5':
            name.append(choice(longvowels))
            continue
        if x == '6':
            name.append(choice(longconsonants))
            continue
        if x == "'":
            name.append("'")
            continue
        if re.match("\D", x):
            name.append(x)
            continue

    print ''.join(name)



def main(argv):
    pattern = "23233"
    howmany = 3
    try:
        opts, args = getopt.getopt(argv, "hp:", ["help", "pattern="])
    except getopt.GetoptError:
        usage()
        sys.exit(2)
    for opt, arg in opts:
        if opt in ('-h', '--help'):
            usage()
            sys.exit(1)
        elif opt in ('-p', '--pattern'):
            pattern = arg
#        elif opt == '-n':
#            a = arg.replace('"', '')
#            howmany = int(a)

    for i in range(0,howmany):
        givename(pattern)
        name = []


if __name__ == "__main__":
    main(sys.argv[1:])
