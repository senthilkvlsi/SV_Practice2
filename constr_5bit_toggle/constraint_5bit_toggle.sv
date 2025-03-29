
module test();
  
  //Write a seq that toggle 5 bits compared to previous number
  class seqm;
    
    rand bit [7:0] word_5bits_toggled;
    rand bit [7:0] word_5bits_toggled_2;
    bit [7:0] temp_value_to_store_word_2;
    rand bit[3:0] v[];
    // Variables to represent the number of balls each girl and boy receives
    
    // Constructor
    function new();
    endfunction
    
    function void pre_randomize();
      v = new[36];
    endfunction

    function void post_randomize();
      temp_value_to_store_word_2 = word_5bits_toggled_2;
    endfunction

    constraint seq1 {
      foreach (v[i]) {
        if (i%2 == 0) {v[i] == 0;}
          else if ((i==1)||(i==19)) {v[i] == 1;}  
          else { v[i] == v[i-2] + 1;}
          
      }      
      foreach (v[i]) {v[i] < 10;  }
             
    }
        
    constraint word_5bits {
     // {$countones(word_5bits_toggled^ const'(word_5bits_toggled)) == 5;    }
    }

    //Use combination of $coutones and XOR to implement this logic    
    constraint word_5bits_2 {
      {$countones(word_5bits_toggled^ (temp_value_to_store_word_2)) == 5;    }
    }
    
        
    // Display the distribution
    function void display();
        /*
        foreach(v[i])
          $display("v[%d]=%d", i, v[i]);  
          */
        $display("word_5bits_toggled=%b",word_5bits_toggled);
        $display("word_5bits_toggled=%b,temp_value_to_store_word_2=%b",word_5bits_toggled_2,temp_value_to_store_word_2);
    endfunction
  endclass
  
   initial begin
     seqm seq1 = new();
     
     repeat(5)   
     if (seq1.randomize()) begin
            seq1.display();
        end else begin
            $display("Failed to randomize ball distribution");
        end
    end
endmodule
