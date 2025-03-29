module test();
  
/*Define following constraints for a 4 bit dynamic array.
  The size of the array should be in between 15 to 20.
  There should be even numbers in odd location and odd numbers in even locations
*/

  class seqm; 
    
    rand bit [3:0] dyn_arr[];
    
    constraint d{
      {
        dyn_arr.size < 20;
        dyn_arr.size >= 15;
      }
    }
    //else statement here is giving const failure
    constraint e{
      {
        foreach(dyn_arr[i]) { 
          if(i%2 == 1) {dyn_arr[i]%2 == 0; }
            //else { dyn_arr[i+1]%2 == 1; }
        }
      }
    }
              
    constraint f{
      {
        foreach(dyn_arr[i]) { 
          if(i%2 == 0) {dyn_arr[i]%2 == 1; }
        }
      }
    }
    // Constructor
    function new();
      
    endfunction
    
    function void pre_randomize();
  
    endfunction

    function void post_randomize();
    endfunction   
             
        
    // Display the distribution
    function void display();
       //$display("abc_last_5_diff=%d",abc_last_5_diff);
      foreach(dyn_arr[i])
        $display("arr[%d]= %d", i, dyn_arr[i]);
      
    endfunction
  endclass
  
   initial begin
     seqm seq1 = new();
     
     repeat(1)   
     if (seq1.randomize()) begin
            seq1.display();
            $display("ball distribution");
        end else begin
            $display("Failed to randomize ball distribution");
        end
    end
endmodule
