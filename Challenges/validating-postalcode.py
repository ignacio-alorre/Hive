# Challenge: Validating-postalcode
# https://www.hackerrank.com/challenges/validating-postalcode/problem

# Notes about regex

# ^ denotes the start of the string
# $ denotes the end of the string
# Two different checking can be combined just wrapping them like (^...)(...$)
# [] indicates the possible values [123] means can be 1 or 2 or 3
# [] also accepts ranges: [0-9] means 0 or 1 or 2 or 3 or 4 or 5 or 6 or 7 or 8 or 9
# {} denotes the lenght of chars to analyse for the given pattern. {3} means a substring of 3 char
# {} also accept ranges, for example {3,5} can be from 3 to 5 char, or {3,} minimum 3 characters
# | denotes OR

regex_integer_in_range = r"(^[1-9]{1})([0-9]{5}$)"
import re
s = "1088011"

print(bool(re.match(regex_integer_in_range, s)))

# Repetitive characters

# (.) makes groups from one char, any char
# (\d) makes groups from digits
# \1{3,} matches MORE than 3 CONSECUTIVE times that char from the first group
# \d\2 look ahead skipping one single element

s2 = "12145"
# regex_repetitive = r"(\d)\1{3,}"
regex_repetitive = r"(?=((\d)\d\2))" #"^([a-z])(?!\1)([a-z])(?:\1\2)*\1?$"   
print(str(re.findall(regex_repetitive, s2)))