module fork_join;
   initial begin
      $display("Starting 2 processes");
      fork
         begin
            repeat(5) begin
               $display("[%0t] Printing from 1st process", $time);
               #10;
            end
         end
         begin
            repeat(2) begin
               $display("[%0t] Printing from 2nd process", $time);
               #20;
            end
         end
      join
      $display("Both the process ended");
      //first fork end
      
      begin
      $display("Starting 2 processes");
      fork
         begin
            repeat(5) begin
               $display("[%0t] Printing from 1st process", $time);
               #10;
            end
         end
         begin
            repeat(2) begin
               $display("[%0t] Printing from 2nd process", $time);
               #20;
            end
         end
      join_any
      $display("One of the process ended");
      end
   
      begin
         $display("Starting 2 processes");
         fork
            begin
                repeat(5) begin
                    $display("[%0t] Printing from 1st process", $time);
                    #10;
                end
            end
            begin
                repeat(2) begin
                    $display("[%0t] Printing from 2nd process", $time);
                    #20;
                end
            end
         join_none
         $display("Started the process and came out of fork_join block");
         wait fork;
         $display("All process finished");
      end
   end
  
   initial begin
      string s = "SystemVerilog";
      string sub1 = s.substr(0, 6);
      string sub2 = s.substr(7, 4);
      $display("Substring 1: %0s, Substring 2: %0s", sub1, sub2); // Output: Substring 1: System,
   end
  
endmodule
