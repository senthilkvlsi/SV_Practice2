// Sequence to create from 0 1 0 2 0 3 .. 0 9 0 1 0 2 ...
module test();
  
  class seqm;
    
    rand bit[3:0] v[];
    // Variables to represent the number of balls each girl and boy receives
    
    // Constructor
    function new();
    endfunction
    
    function void pre_randomize();
      v = new[37];
    endfunction

    constraint seq1 {
      foreach (v[i]) {
        if (i%2 == 0) {v[i] == 0;}
          else if ((i==1)||(i==19)) {v[i] == 1;}  
          else { v[i] == v[i-2] + 1;}
          
      }      
      foreach (v[i]) {v[i] < 10;  }
             
    }
    
    // Display the distribution
    function void display();
        foreach(v[i])
          $display("v[%d]=%d", i, v[i]);
    endfunction
  endclass
  
   initial begin
     seqm seq1 = new();
        
     if (seq1.randomize()) begin
            seq1.display();
        end else begin
            $display("Failed to randomize ball distribution");
        end
    end
endmodule

/* Notes1 */
/* Output *

Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Mar 22 04:08 2025
v[          0]= 0
v[          1]= 1
v[          2]= 0
v[          3]= 2
v[          4]= 0
v[          5]= 3
v[          6]= 0
v[          7]= 4
v[          8]= 0
v[          9]= 5
v[         10]= 0
v[         11]= 6
v[         12]= 0
v[         13]= 7
v[         14]= 0
v[         15]= 8
v[         16]= 0
v[         17]= 9
v[         18]= 0
v[         19]= 1
v[         20]= 0
v[         21]= 2
v[         22]= 0
v[         23]= 3
v[         24]= 0
v[         25]= 4
v[         26]= 0
v[         27]= 5
v[         28]= 0
v[         29]= 6
v[         30]= 0
v[         31]= 7
v[         32]= 0
v[         33]= 8
v[         34]= 0
v[         35]= 9
v[         36]= 0
           V C S   S i m u l a t i o n   R e p o r t

	   */

/* Notes2 */
/*
* Above code will not work if v[] size is >=38
testbench.sv, 39
  Constraints are inconsistent and cannot be solved.
  Please check the inconsistent constraints being printed above and rewrite 
  them.
*/ 
