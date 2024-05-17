# Formal methods homework 2, see READEME for more
# Generating z3 code to solve a sodoku problem given the dimentions and existing data
import sys
import subprocess

# When calling from cmd line param 1 = file, param 2 = size, param 3 = list of initail conditions seperated by only commas
n = int(sys.argv[1])
s = n**2

ic = sys.argv[2].split(',')


with open('sudoku.smt2', 'w') as z3:
    z3.write(f'; Sudoku solver for a {s}x{s} board with the following inital conditions: {" ,".join(ic)}\n\n')

    # Declare variables
    z3.write('; cijk means cell i, j has value k\n')
    for i in range(1, s+1):
        for j in range(1, s+1):
            for k in range(1, s+1):
                z3.write(f'(declare-const c{i}{j}{k} Bool)\n')

    # Can't think of a slick way with logic to ensure only one var is true so im writing a function to sum the 1s
    z3.write(f'\n; This function takes {s} arguments and sums up the bool values\n; This will be used to ensure only one bool is true for each digit for each row, col, and box')
    fun_args = ''
    for i in range(1,s+1):
        fun_args += f'(n{i} Bool)'

    fun_body = ''
    for i in range(1,s+1):
        if i == 1:
            fun_body += f'(ite n{i} 1 0)\n'
        elif i == s:
            fun_body += f'       (ite n{i} 1 0)'
        else:
            fun_body += f'       (ite n{i} 1 0)\n'
    z3.write(f'\n(define-fun sum_ones ({fun_args}) Int\n    (+ {fun_body}))\n')
    
    # No column has duplicate values
    z3.write('\n; No column has duplicate values\n; Use the function to sum bool vals for each col for each digit and ensure is 1\n')
    for i in range(1, s+1):
        for d in range(1, s+1):
            col_args = ''
            for j in range(1, s+1):
                col_args += f' c{i}{j}{d}'
            z3.write(f'(assert (= (sum_ones{col_args}) 1))\n')
            
    # No row has duplicate values
    z3.write('\n; No row has duplicate values\n; Use the function to sum bool vals for each row for each digit and ensure is 1\n')
    for j in range(1, s+1):
        for d in range(1, s+1):
            col_args = ''
            for i in range(1, s+1):
                col_args += f' c{i}{j}{d}'
            z3.write(f'(assert (= (sum_ones{col_args}) 1))\n')

    # No 'box' (nxn squares) has duplicates
    # boxes number 1 through 9 in the same way you read (l to r, u to d)
    z3.write("\n; No 'box' (nxn squares) has duplicate values\n; Use the function to sum bool vals for each box for each digit and ensure is 1\n")
    for d in range(1, s+1):
        box_args = ['' for i in range(n)]
        for j in range(1, s+1):
            for i in range(1, n+1):
                for l in range(n):
                    box_args[l] += f' c{i + l*(n)}{j}{d}'
            if j % n == 0:
                for a in box_args:
                    z3.write(f'(assert (= (sum_ones{a}) 1))\n')
                box_args = ['' for i in range(n)]

    # Each cell has a digit
    z3.write('\n; Each cell has a digit\n; Ensure each cell has atleast one value true\n')
    for i in range(1, s+1):
        for j in range(1, s+1): 
            vals = '(or'
            for k in range(1, s+1): 
                vals += f' c{i}{j}{k}'
            z3.write(f'(assert {vals}))\n')
            
    # Initial configuration
    z3.write('\n; Initial configuration of cells (preassinged cells digits)\n; And each of the given parameters to ensure they all hold true\n')
    ic_str = '(and'
    for i in ic:
        ic_str += f' {i}'
    z3.write(f'(assert {ic_str}))')

    # write check-sat and get-model for the output when ran
    z3.write('\n\n(check-sat)\n(get-model)')

print('To run z3, use the following cmd:\nz3 sudoku.smt2 > sudoku.out')

subprocess.run(["z3", "sudoku.smt2"]) 

lines = open('sudoku.out').readlines()
#first two lines can be forgotten
#then odds are vairable and the next is the truth value

#TODO: Write script to run here, and parse output, then move to java write frontend/backend appliaction using this