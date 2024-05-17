# Formal methods homework 2, see READEME for more
# Generating z3 code to solve a mutilated checkerboard problem given the dimentions and blocked positions
import sys

# When calling from cmd line param 1 = file, param 2 = size, param 3 = list of blocked off cell coordinates seperated by commas only, param4 = file name with no extentions
n = int(sys.argv[1])

ic = sys.argv[2].split(',')

with open(f'{sys.argv[3]}.smt2', 'w') as z3:
    z3.write(f"; Mutilated checkerboard for an {n}x{n} board with positions {', '.join(ic)} blocked off\n\n")
    # Declare variables
    # Vertical dominos
    z3.write('; vij means a vertical domino starting at (i, j)\n')
    for i in range(1, n+1):
        for j in range(1, n):    
            z3.write(f'(declare-const v{i}{j} Bool)\n')
    # Horizontal dominos
    z3.write('\n; hij means a horizontal domino starting at (i, j)\n')
    for i in range(1, n):
        for j in range(1, n+1):    
            z3.write(f'(declare-const h{i}{j} Bool)\n')
    
    # Every unmutilated cell is covered
    z3.write('\n; Ensure open cells are covered by a domino\n; Go through each unmutilated cell and ensure atleast one domino that covers it is true\n')
    for i in range(1, n+1):
        for j in range(1, n+1):
            if(not(str(i)+str(j) in ic)):
                unmut_args = ''
                # check if left avail (h)
                if(i - 1 >= 1):
                    unmut_args += f' h{i - 1}{j}'
                # check if right avail (h)
                if(i + 1 <= n):
                    unmut_args += f' h{i}{j}'
                # check if up avail (v)
                if(j-1 >= 1):
                    unmut_args += f' v{i}{j - 1}'
                # check if down avail (v)
                if(j + 1 <= n):
                    unmut_args += f' v{i}{j}'
                z3.write(f'(assert (or{unmut_args})) ;cell {i}{j}\n')

    # Blocked off cells are uncovered
    z3.write('\n; Ensure blocked off cells have NO dominos\n; Check the four places where a domino starting there would cover it and ensure no domino will go there\n')
    for c in ic:
        blocked_args = ''
        # check if left avail (h)
        if(int(c[0]) - 1 >= 1):
            blocked_args += f' (not h{int(c[0]) - 1}{c[1]})'
        # check if right avail (h)
        if(int(c[0]) + 1 <= n):
            blocked_args += f' (not h{c})'
        # check if up avail (v)
        if(int(c[1])-1 >= 1):
            blocked_args += f' (not v{c[0]}{int(c[1]) - 1})'
        # check if down avail (v)
        if(int(c[1]) + 1 <= n):
            blocked_args += f' (not v{c})'
        z3.write(f'(assert (and{blocked_args})) ;blocked cell {c}\n')

    # Can't think of a slick way with logic to ensure only one var is true so im writing a function to sum the 1s
    z3.write(f'\n; This function takes 4 arguments and sums up the bool values\n; This will be used to ensure only one bool is true for each digit for each row, col, and box')
    fun_args = ''
    for i in range(1,n+1):
        fun_args += f'(n{i} Bool)'

    fun_body = ''
    for i in range(1,n+1):
        if i == 1:
            fun_body += f'(ite n{i} 1 0)\n'
        elif i == n:
            fun_body += f'       (ite n{i} 1 0)'
        else:
            fun_body += f'       (ite n{i} 1 0)\n'
    z3.write(f'\n(define-fun sum_ones ({fun_args}) Int\n    (+ {fun_body}))\n')

    # No Dominos over lap (go through each pos and we want only 1)
    z3.write('\n; Ensure no dominos overlap\n; Use the above function to ensure only one domino is true on each cell, if there are less than 4 dominos then false is used in place of the missing ones\n')
    for i in range(1, n+1):
        for j in range(1, n+1):
            if(not(str(i)+str(j) in ic)):
                nooverlap_args = ''
                # check if left avail (h)
                if(i - 1 >= 1):
                    nooverlap_args += f' h{i - 1}{j}'
                else:
                    nooverlap_args += f' false'
                # check if right avail (h)
                if(i + 1 <= n):
                    nooverlap_args += f' h{i}{j}'
                else:
                    nooverlap_args += f' false'
                # check if up avail (v)
                if(j-1 >= 1):
                    nooverlap_args += f' v{i}{j - 1}'
                else:
                    nooverlap_args += f' false'
                # check if down avail (v)
                if(j + 1 <= n):
                    nooverlap_args += f' v{i}{j}'
                else:
                    nooverlap_args += f' false'
                z3.write(f'(assert (= (sum_ones{nooverlap_args}) 1)) ;cell {i}{j}\n')

    # Write check-sat and get-model for the output when ran
    z3.write('\n(check-sat)\n(get-model)')

print(f'To run z3, use the following cmd:\nz3 {sys.argv[3]}.smt2 > {sys.argv[3]}.out')