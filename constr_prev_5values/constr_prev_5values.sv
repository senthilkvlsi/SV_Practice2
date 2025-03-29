module test();
  
  //Write a seq that toggle 5 bits compared to previous number
  //Write a constraint such that when the transaction class object ( rand bit [3:0] a) is randomized , the value of “a” should not be same as previous 5 occurrence of the value of “a”.

  class seqm;
    
    rand bit [7:0] word_5bits_toggled;
    rand bit [7:0] word_5bits_toggled_2;
    bit [7:0] temp_value_to_store_word_2;
    rand bit[3:0] v[];
    rand bit [3:0] abc_last_5_diff;
    bit [3:0] abc_last_5_q[$:4];
    // Variables to represent the number of balls each girl and boy receives
    
    // Constructor
    function new();
    endfunction
    
    function void pre_randomize();
      v = new[36];
    endfunction

    function void post_randomize();
      temp_value_to_store_word_2 = word_5bits_toggled_2;
      
      //Ensure queue is cleared up
      if(abc_last_5_q.size == 5) 
        abc_last_5_q.pop_front();
      abc_last_5_q.push_back(abc_last_5_diff);
     // $display("que= %d %d %d %d %d",abc_last_5_q[0],abc_last_5_q[1],abc_last_5_q[2],abc_last_5_q[3],abc_last_5_q[4]);
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
   
    // Use ! operator correctly - !a is different from !(a ...    
    constraint abc_last_5_diff_cons 
    { 
      
      {!{abc_last_5_diff inside {abc_last_5_q}};}
    }
           
        
    // Display the distribution
    function void display();
        /*
        foreach(v[i])
          $display("v[%d]=%d", i, v[i]);  
          */
      /*
        $display("word_5bits_toggled=%b",word_5bits_toggled);
        $display("word_5bits_toggled=%b,temp_value_to_store_word_2=%b",word_5bits_toggled_2,temp_value_to_store_word_2);
        */
      $display("abc_last_5_diff=%d",abc_last_5_diff);
    endfunction
  endclass
  
   initial begin
     seqm seq1 = new();
     
     repeat(30)   
     if (seq1.randomize()) begin
            seq1.display();
        end else begin
            $display("Failed to randomize ball distribution");
        end
    end
endmodule
