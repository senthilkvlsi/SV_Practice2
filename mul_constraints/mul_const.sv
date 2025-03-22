module test();
    
  class seqm;
    
    rand bit[3:0] v[];
    int arr[3] = '{2,3,5};
    rand bit [63:0] addr[10];
    rand bit [31:0] value[10];
    rand bit [4:0] max[10];
    
    rand bit [31:0] value_cons;
    rand bit [31:0] value_cons2;
    
    // Constructor
    function new();
    endfunction
    
    function bit is_two_cons_bit_set(bit [31:0] val);
      bit [31:0] temp_val = val;
      bit [31:0] new_val;
      if(val[31:30] == 2'b11) return 1'b0;
      if(val[1:0] == 2'b11) return 1'b0;
      temp_val = val<<1;
      new_val = temp_val & val;
      
      foreach (new_val[i])
        if(new_val[i]) return 1'b0;
      
      return 1'b1;
    endfunction
    
    function void pre_randomize();
      v = new[10];
    endfunction

    //generate primes based on array 
    constraint seq1 {
      foreach (v[i]) {
        v[i] inside {arr};      
      }  
    }
    
    //generate 8k addr regions    
    constraint addr_size {
      foreach (addr[i]) { addr[i][12:0] == 12'b0;}       
        
    }
        
    //generate 32 bit number with one bit set    
    constraint val{
      foreach(value[i]) {value[i] == 1<<max[i];}
    }
    
    //generate 32 bit number with no two consec bit set    
    constraint val2{
      foreach(value_cons[i]) {
        if(i>0) value_cons[i] != value_cons[i-1];
        value_cons[i] inside {0,1};
      }
    }
    
    //generate 32 bit number with no two consec bit set    
    constraint val3{
     // is_two_cons_bit_set(value_cons2) == 1'b1;
      $countones(value_cons2 & (value_cons2<<1)) == 0;
    }
    
       
    // Display the distribution
    function void display();
        foreach(v[i])
          $display("v[%d]=%d", i, v[i]);
      foreach(addr[i])
        $display("addr[%d]=%h", i, addr[i]);
      foreach(value[i])
        $display("value[%d]=%h", i, value[i]);
      $display("value_con[]=%h", value_cons);
      $display("value_con2[]=%h", value_cons2);
      
    endfunction
  endclass
  
   initial begin
     seqm seq1 = new();
     
     repeat (5)    
     if (seq1.randomize()) begin
            seq1.display();
     end else begin
            $display("Failed to randomize ball distribution");
     end
    
  end
 endmodule
